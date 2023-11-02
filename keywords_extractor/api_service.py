from fastapi import FastAPI, HTTPException
import fetch_db_data
from datetime import datetime
import generate_wordcloud
import process_ads
import json

client, db = fetch_db_data.return_client_and_db()

app = FastAPI()


@app.get("/")
async def main(country: str,
               start_time: datetime,
               end_time: datetime,
               funding_entity: str = None,
               page_id: str = None,
               is_wordcloud: bool = False,
               top_n_key_phrases: int = 40,
               top_n_keywords: int = 100,
               key_phrase_share_word_threshold: float = 0.49,
               keyword_share_word_threshold: float = 0.49,
               if_only_politically_relevant: bool = False,
               is_politically_relevant_threshold: float = 0.75,
               if_extended_stop_words: bool = False,
               if_generate_img_base64: bool = True,
               max_table_length: int = 100,
               dpi: int = 100):
    # if both funding_entity and page_id are not None, raise an exception
    if funding_entity is not None and page_id is not None:
        raise HTTPException(status_code=400, detail="Both funding_entity and page_id cannot be specified")

    # only adding the page name to the ads if page_id is provided
    page_name = None
    if page_id is not None:
        page = fetch_db_data.fetch_page(db, country, page_id)
        if page is not None:
            page_name = page["name"]
        else:
            raise HTTPException(status_code=404, detail="No page found for the given params")

    ads = fetch_db_data.fetch_ads(db, country, funding_entity, page_id, start_time, end_time)
    if page_id is not None:
        ads = fetch_db_data.merge_page_name_with_associated_ads(ads, page_name)

    ads_summary = fetch_db_data.create_ads_summary_table(ads, country)

    # if ads is an empty list, raise an exception
    if len(ads) == 0:
        raise HTTPException(status_code=404, detail="No ads found for the given params")

    if is_wordcloud:
        top_keywords = process_ads.extract_keywords(ads,
                                                    top_n=top_n_keywords,
                                                    similarity_threshold=keyword_share_word_threshold,
                                                    is_politically_relevant_threshold=is_politically_relevant_threshold,
                                                    if_only_politically_relevant=if_only_politically_relevant,
                                                    if_extended_stop_words=if_extended_stop_words)
        img_base64 = None
        if if_generate_img_base64:
            img_base64 = generate_wordcloud.generate_keyword_wordcloud(top_keywords, dpi=dpi, debug=False)

        top_keywords = fetch_db_data.top_keyword_to_d3_dict_list(top_keywords)

        # make a result dict with the image base64 string and the top keywords
        result_dict = {"img": img_base64, "result": top_keywords}
        return json.dumps(result_dict)

    else:
        top_key_phrases = process_ads.extract_top_key_phrase(ads,
                                                             top_n=top_n_key_phrases,
                                                             share_word_threshold=key_phrase_share_word_threshold)
        img_base64 = None
        if if_generate_img_base64:
            img_base64 = generate_wordcloud.generate_phrase_wordcloud(top_key_phrases, dpi=dpi, debug=False)

        top_key_phrases = fetch_db_data.top_keyphrase_to_d3_dict_list(top_key_phrases)

        # make a result dict with the image base64 string and the top key phrases
        result_dict = {"img": img_base64, "result": top_key_phrases}
        return json.dumps(result_dict)


@app.on_event("shutdown")
async def app_shutdown():
    print("Closing connection to database.....")
    client.close()


if __name__ == '__main__':
    # to run the server, run the following command in the terminal:
    # uvicorn api_service:app --reload
    pass
