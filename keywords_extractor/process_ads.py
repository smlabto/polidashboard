import json
from collections import defaultdict
import yake
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.corpus import stopwords, words
from stop_words import get_stop_words
import torch.nn.functional as F
import torch
from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import ProcessPoolExecutor
from functools import partial

# command used for downloading the nltk words
# nltk.download('stopwords')
# nltk.download('words')

# Load stopwords and English words
stop_words = set(stopwords.words('english'))
english_words = set(words.words())

tokenizer = None
model = None


def load_bert():
    # hot load bert model, speeds up three sec
    from transformers import BertTokenizer, BertModel
    global tokenizer
    global model
    tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
    model = BertModel.from_pretrained('bert-base-uncased')


# This function returns the embedding of a word using BERT
def get_embedding(word):
    tokens = tokenizer(word, return_tensors="pt")
    with torch.no_grad():
        outputs = model(**tokens)
    return outputs.last_hidden_state.mean(dim=1)


def establish_political_context():
    # Establish a political context
    political_context = ["election", "democracy", "legislation", "parliament", "senate", "governance", "government",
                         "vote",
                         "tax", "extreme", "climate", "cost", "house", "senator", "congress"]
    context_embeddings = [get_embedding(word) for word in political_context]
    return context_embeddings


def is_politically_relevant(word, political_context_embedding, is_politically_relevant_threshold=0.75):
    word_embedding = get_embedding(word)
    similarities = [F.cosine_similarity(word_embedding, context_emb).item() for context_emb in
                    political_context_embedding]
    avg_similarity = sum(similarities) / len(similarities)
    return avg_similarity > is_politically_relevant_threshold


def extend_stop_words(stop_words):
    import spacy
    en = spacy.load('en_core_web_lg')
    stop_words = stop_words.union(en.Defaults.stop_words).union(get_stop_words('english'))
    return stop_words


# This function returns a list of phrases extracted from the text
def extract_phrase(text, top_n=10, max_length=3, min_length=1):
    # The Language is English, a deduplication threshold is set to 0.9, and ngram size is 1 up to 3.
    kw_extractor = yake.KeywordExtractor(lan="en", dedupLim=0.9, windowsSize=1, top=top_n, features=None, n=max_length)
    key_phrase = kw_extractor.extract_keywords(text)

    keyword_list = [kw[0] for kw in key_phrase]
    if min_length != 0:
        keyword_list = [kw for kw in keyword_list if len(kw.split()) > min_length]
    return keyword_list


def parallel_extract_phrases(chunk_data, min_length=1, max_length=3, debug=False):
    start_idx, end_idx, chunk = chunk_data
    if debug:
        print(f"Process handling indices: {start_idx} to {end_idx}")
    results = []
    for unique_creative_ad in chunk:
        freq = unique_creative_ad["freq"]
        ad_text = unique_creative_ad["creative_bodies"]
        key_phrases = extract_phrase(ad_text, min_length=min_length, max_length=max_length)
        results.extend([(phrase, freq) for phrase in key_phrases])
    return results


def extract_top_key_phrase(unique_creative_ads_table, top_n=200, share_word_threshold=0.49, min_length=1, max_length=3,
                           num_processes=8, minimum_number_of_unique_ads_to_parallel=800, debug=False):
    key_phrase_freq = defaultdict(int)

    if len(unique_creative_ads_table) > minimum_number_of_unique_ads_to_parallel:
        # if the length of the unique_creative_ads_table is less than number of processes
        # then use the length of the unique_creative_ads_table as the number of processes
        if len(unique_creative_ads_table) < num_processes:
            num_processes = len(unique_creative_ads_table)

        # Split data into chunks for each process
        chunk_size = len(unique_creative_ads_table) // num_processes
        chunks = [(i, i + chunk_size, unique_creative_ads_table[i:i + chunk_size]) for i in
                  range(0, len(unique_creative_ads_table), chunk_size)]

        # Use partial function to fixate the min_length and max_length parameters for parallel_extract_phrases
        parallel_extract_phrases_prefilled = partial(parallel_extract_phrases,
                                                     min_length=min_length,
                                                     max_length=max_length,
                                                     debug=debug)

        with ProcessPoolExecutor(max_workers=num_processes) as executor:
            for result in executor.map(parallel_extract_phrases_prefilled, chunks):
                for phrase, freq in result:
                    key_phrase_freq[phrase] += freq

    else:
        for unique_creative_ad in unique_creative_ads_table:
            freq = unique_creative_ad["freq"]
            ad_text = unique_creative_ad["creative_bodies"]
            key_phrases = extract_phrase(ad_text, min_length=min_length, max_length=max_length)
            for phrase in key_phrases:
                key_phrase_freq[phrase] += freq

    # Sort key_phrases by frequency
    sorted_key_phrases = sorted(key_phrase_freq.keys(), key=lambda x: key_phrase_freq[x], reverse=True)

    # Aggregating key phrases by combined ones with more than share_word_threshold% of shared words
    final_key_phrases = []

    for i in range(len(sorted_key_phrases)):
        current_key_phrase = sorted_key_phrases[i]
        is_similar = False

        for previous_key_phrase in final_key_phrases:
            previous_key_phrase = previous_key_phrase["phrase"]
            # Calculate the similarity between the current phrase and the previous phrase by counting the number of
            # shared words
            current_key_phrase_words = set(current_key_phrase.lower().split())
            previous_key_phrase_words = set(previous_key_phrase.lower().split())
            shared_words = current_key_phrase_words.intersection(previous_key_phrase_words)
            similarity = len(shared_words) / len(current_key_phrase_words)

            # if the similarity is greater than share_word_threshold%,
            # then the current phrase is similar to the previous phrase
            if similarity >= share_word_threshold:
                # remove the current phrase
                is_similar = True
                # add the current phrase frequency to the previous phrase frequency in the final_key_phrases
                # find the dict in the final key_phrases list that has the same phrase as the previous phrase
                for final_key_phrase in final_key_phrases:
                    if final_key_phrase["phrase"] == previous_key_phrase:
                        final_key_phrase["freq"] += key_phrase_freq[current_key_phrase]
                        break
                break

        if len(final_key_phrases) == top_n:
            break

        if not is_similar:
            final_key_phrases.append({"phrase": current_key_phrase, "freq": key_phrase_freq[current_key_phrase]})

    # sort the final key_phrases by frequency
    final_key_phrases = sorted(final_key_phrases, key=lambda x: x["freq"], reverse=True)

    # make a final_key_phrase dict with key being the phrase and value being the frequency
    key_phrase_freq = {}
    for phrase in final_key_phrases:
        key_phrase_freq[phrase["phrase"]] = phrase["freq"]
    return key_phrase_freq


# return a list of dictionary, for each dictionary, there are two keys: page_name and content
# page_name is the page name, content is the concatenated page name ad_creative_bodies and ad_creative_link_titles
def get_page_names_plus_ads_dict_list(combined_ads):
    page_names_plus_ads_dict_list = []
    for page_name, ads in combined_ads.items():
        content = page_name + " "
        for ad in ads:
            content += " ".join(ad["ad_creative_bodies"])
            content += " ".join(ad["ad_creative_link_titles"])
            content += " ".join(ad["ad_creative_link_descriptions"])
        page_names_plus_ads_dict_list.append({"page_name": page_name, "content": content})
    return page_names_plus_ads_dict_list


def extract_keywords(ads, top_n=200, is_politically_relevant_threshold=0.75, similarity_threshold=0.5,
                     if_only_politically_relevant=False, if_extended_stop_words=False):
    if if_extended_stop_words:
        extended_stop_words = extend_stop_words(stop_words)
        # Use Tfidf Vectorizer to get important words based on TF-IDF scores
        vectorizer = TfidfVectorizer(stop_words=list(extended_stop_words), max_features=200)
    else:
        # Use Tfidf Vectorizer to get important words based on TF-IDF scores
        vectorizer = TfidfVectorizer(stop_words=list(stop_words), max_features=200)

    texts = [ad["creative_bodies"] for ad in ads]

    tfidf_matrix = vectorizer.fit_transform(texts)
    feature_names = vectorizer.get_feature_names_out()
    tfidf_scores = tfidf_matrix.sum(axis=0).A1
    tfidf_ranking = [(feature_names[i], tfidf_scores[i]) for i in tfidf_scores.argsort()[::-1]]

    if if_only_politically_relevant:
        load_bert()
        political_context_embedding = establish_political_context()
        tfidf_ranking = [(word, score) for word, score in tfidf_ranking if
                         word in english_words and is_politically_relevant(word, political_context_embedding,
                                                                           is_politically_relevant_threshold=is_politically_relevant_threshold)]
    else:
        tfidf_ranking = [
            (word, score) for word, score in tfidf_ranking
            if word in english_words
        ]

    tfidf_ranking = remove_duplicate_keywords(tfidf_ranking, similarity_threshold=similarity_threshold)

    keyword_freq = {}
    for keyword in tfidf_ranking[:top_n]:
        keyword_freq[keyword[0]] = keyword[1]
    return keyword_freq


# remove the deplicate words, rule: if two words share more than similarity_threshold% of the same word, then remove
# the one with fewer characters
def remove_duplicate_keywords(tfidf_ranking, similarity_threshold=0.5):
    # create a set of words
    words_set = set()
    unique_keywords = []
    for keyword in tfidf_ranking:
        # if the current word is not similarity_threshold% similar of any word in the set, add it to the set and append
        # it to the list of unique keywords
        is_similar = False
        for word in words_set:
            # calculate the similarity between the current word and the word in the set by counting the number of shared
            # characters
            current_word = keyword[0]
            shared_characters = set(current_word.lower()).intersection(set(word.lower()))
            similarity = len(shared_characters) / len(current_word)
            # if the similarity is greater than 50%, then the current word is similar to the word in the set
            if similarity >= similarity_threshold:
                is_similar = True
                break
        if not is_similar:
            words_set.add(keyword[0])
            unique_keywords.append(keyword)

    return unique_keywords


def main():
    # load republican_ads.json
    with open('republican_ads.json', 'r', encoding='utf-8') as f:
        republican_ads = json.load(f)

    # convert creative_bodies to str
    for ad in republican_ads:
        creative_bodies_combined = ""
        for creative_body in ad["creative_bodies"]:
            creative_bodies_combined += " " + creative_body
        ad["creative_bodies"] = creative_bodies_combined

    top_key_phrases = extract_top_key_phrase(republican_ads, top_n=40, share_word_threshold=0.49)
    for i in top_key_phrases:
        print(i)

    # print([ad["creative_bodies"] for ad in republican_ads])
    # keywords = extract_keywords([ad["creative_bodies"] for ad in republican_ads], top_n=100)


if __name__ == '__main__':
    main()
