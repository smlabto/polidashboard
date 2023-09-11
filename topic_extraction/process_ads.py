import json
from collections import defaultdict
import yake
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.corpus import stopwords, words
import spacy
from stop_words import get_stop_words
from transformers import BertTokenizer, BertModel
import torch.nn.functional as F
import torch
import generate_wordcloud

# Load BERT model and tokenizer
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = BertModel.from_pretrained('bert-base-uncased')

# nltk.download('stopwords')
# nltk.download('words')

# Load stopwords and English words
stop_words = set(stopwords.words('english'))
english_words = set(words.words())
en = spacy.load('en_core_web_lg')
stop_words = stop_words.union(en.Defaults.stop_words).union(get_stop_words('english'))


def extract_phrase(text, top_n=10, max_length=5):
    # The Language is English, a deduplication threshold is set to 0.9, and ngram size is 1 up to 3.
    kw_extractor = yake.KeywordExtractor(lan="en", dedupLim=0.9, windowsSize=1, top=top_n, features=None, n=max_length)
    keywords = kw_extractor.extract_keywords(text)
    # remove all the keyword that is only a single word and return the list of keywords

    keyword_list = [kw[0] for kw in keywords]
    # remove all the keyword that is only a single word and return the list of keywords
    return [kw for kw in keyword_list if len(kw.split()) > 1]


def get_topics_for_ad(text):
    """Extract topics/tags for a given ad text using YAKE."""
    return extract_phrase(text)


def extract_top_topics(ads, top_n=20, share_word_threshold=0.49):
    topic_freq = defaultdict(int)

    for ad in ads:
        ad_text = ad["creative_bodies"]
        topics = get_topics_for_ad(ad_text)
        for topic in topics:
            topic_freq[topic] += 1

    # Sort topics by frequency
    sorted_topics = sorted(topic_freq.keys(), key=lambda x: topic_freq[x], reverse=True)

    # Filter out overlapping and nonsensical topics
    # final topics are a list of frequency dictionary
    final_topics = []

    for i in range(len(sorted_topics)):
        current_topic = sorted_topics[i]

        # Check if the topic is at least 75% similar to any of the final topics
        is_similar = False

        for previous_topic in final_topics:
            previous_topic = previous_topic["topic"]
            # Calculate the similarity between the current topic and the previous topic by counting the number of shared
            # words
            current_topic_words = set(current_topic.lower().split())
            previous_topic_words = set(previous_topic.lower().split())
            shared_words = current_topic_words.intersection(previous_topic_words)
            similarity = len(shared_words) / len(current_topic_words)

            # if the similarity is greater than 75%, then the current topic is similar to the previous topic
            if similarity >= share_word_threshold:
                # remove the current topic
                is_similar = True
                # add the current topic frequency to the previous topic frequency in the final topics
                # find the dict in the final topics list that have the same topic as the previous topic
                for final_topic in final_topics:
                    if final_topic["topic"] == previous_topic:
                        final_topic["freq"] += topic_freq[current_topic]
                        break
                break

        if len(final_topics) == top_n:
            break

        if not is_similar:
            final_topics.append({"topic": current_topic, "freq": topic_freq[current_topic]})

    # sort the final topics by frequency
    final_topics = sorted(final_topics, key=lambda x: x["freq"], reverse=True)

    # make a final_topic dict with key being the topic and value being the frequency
    topic_freq = {}
    for topic in final_topics:
        topic_freq[topic["topic"]] = topic["freq"]
    return topic_freq


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


def extract_keywords(texts, top_n=10, is_politically_relevant_threshold=0.75, similarity_threshold=0.5):
    # Use Tfidf Vectorizer to get important words based on TF-IDF scores
    vectorizer = TfidfVectorizer(stop_words=list(stop_words), max_features=10000)
    tfidf_matrix = vectorizer.fit_transform(texts)
    feature_names = vectorizer.get_feature_names_out()
    tfidf_scores = tfidf_matrix.sum(axis=0).A1
    tfidf_ranking = [(feature_names[i], tfidf_scores[i]) for i in tfidf_scores.argsort()[::-1]]

    # # Filter out non-legit words and stopwords
    # tfidf_ranking = [(word, score) for word,
    # score in tfidf_ranking if word in english_words and word not in stop_words]
    # tfidf_ranking = [
    #     (word, score) for word, score in tfidf_ranking
    #     if word in english_words and word not in stop_words and is_politically_relevant(word)
    # ]

    tfidf_ranking = [
        (word, score) for word, score in tfidf_ranking
        if word in english_words and is_politically_relevant(word,
                                                             is_politically_relevant_threshold=is_politically_relevant_threshold)
    ]
    tfidf_ranking = remove_duplicate_keywords(tfidf_ranking, similarity_threshold=similarity_threshold)

    keyword_freq = {}
    for keyword in tfidf_ranking[:top_n]:
        keyword_freq[keyword[0]] = keyword[1]
    return keyword_freq


# remove the deplicate words, rule: if two words share more than 50% of the same word, then remove the one with
# fewer characters
def remove_duplicate_keywords(tfidf_ranking, similarity_threshold=0.5):
    # create a set of words
    words_set = set()
    unique_keywords = []
    for keyword in tfidf_ranking:
        # if the current word is not 50% similar of any word in the set, add it to the set and append it to the
        # list of unique keywords
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


# This function returns the embedding of a word using BERT
def get_embedding(word):
    tokens = tokenizer(word, return_tensors="pt")
    with torch.no_grad():
        outputs = model(**tokens)
    return outputs.last_hidden_state.mean(dim=1)


# Establish a political context
political_context = ["election", "democracy", "legislation", "parliament", "senate", "governance", "government", "vote",
                     "tax", "extreme", "climate", "cost", "house", "senator", "congress"]
context_embeddings = [get_embedding(word) for word in political_context]


def is_politically_relevant(word, is_politically_relevant_threshold=0.75):
    word_embedding = get_embedding(word)
    similarities = [F.cosine_similarity(word_embedding, context_emb).item() for context_emb in context_embeddings]
    avg_similarity = sum(similarities) / len(similarities)
    return avg_similarity > is_politically_relevant_threshold


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

    top_topics = extract_top_topics(republican_ads, top_n=40, share_word_threshold=0.49)
    for i in top_topics:
        print(i)

    # Add this function call in the main() function to see the results:
    print([ad["creative_bodies"] for ad in republican_ads])
    keywords = extract_keywords([ad["creative_bodies"] for ad in republican_ads], top_n=100)

    generate_wordcloud.generate_phrase_wordcloud(top_topics)
    generate_wordcloud.generate_keyword_wordcloud(keywords)


if __name__ == '__main__':
    main()
