from fastapi import FastAPI, HTTPException
import fetch_db_data
from datetime import datetime
import generate_wordcloud
import process_ads
import json

client, db = fetch_db_data.return_client_and_db()

app = FastAPI()


@app.get("/")
async def main(page_id: str,
               country: str,
               start_time: datetime,
               end_time: datetime,
               is_wordcloud: bool = False,
               top_n_topics: int = 40,
               top_n_keywords: int = 100,
               topic_share_word_threshold: float = 0.49,
               keyword_share_word_threshold: float = 0.49,
               is_politically_relevant_threshold: float = 0.75):
    page = fetch_db_data.fetch_page(db, country, page_id)
    if page is not None:
        page_name = page["name"]
    else:
        raise HTTPException(status_code=404, detail="No page found for the given params")
    ads = fetch_db_data.fetch_ads(db, country, page_id, start_time, end_time)
    ads = fetch_db_data.merge_page_name_with_associated_ads(ads, page_name)

    # if ads is an empty list, raise an exception
    if len(ads) == 0:
        raise HTTPException(status_code=404, detail="No ads found for the given params")

    if is_wordcloud:
        top_keywords = process_ads.extract_keywords([ad["creative_bodies"] for ad in ads],
                                                    top_n=top_n_keywords,
                                                    similarity_threshold=keyword_share_word_threshold,
                                                    is_politically_relevant_threshold=is_politically_relevant_threshold)
        img_base64 = generate_wordcloud.generate_keyword_wordcloud(top_keywords)

        # make a result dict with the image base64 string and the top keywords
        result_dict = {"img": img_base64, "result": top_keywords}
        return json.dumps(result_dict)

    else:
        top_topics = process_ads.extract_top_topics(ads,
                                                    top_n=top_n_topics,
                                                    share_word_threshold=topic_share_word_threshold)
        img_base64 = generate_wordcloud.generate_phrase_wordcloud(top_topics)
        # make a result dict with the image base64 string and the top keywords
        result_dict = {"img": img_base64, "result": top_topics}
        return json.dumps(result_dict)


@app.on_event("shutdown")
async def app_shutdown():
    print("Closing connection to database.....")
    client.close()
