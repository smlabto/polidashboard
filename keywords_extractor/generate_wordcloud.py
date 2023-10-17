import matplotlib.pyplot as plt
from wordcloud import WordCloud
from PIL import Image
import numpy as np
import base64
from io import BytesIO

mask = np.array(Image.open("thought_bubble_1.png"))

import random
def custom_hex_color_func(word, font_size, position, orientation, random_state=None, **kwargs):
    colors = ['#d00000', '#dc2f02', '#e85d04', '#f48c06']
    return random.choice(colors)

# generate a "phrase" wordcloud from the top topics dict list
def generate_phrase_wordcloud(topic_freq, output_filename='phrase_cloud', dpi=150, debug=False):
    print(topic_freq)
    print("Generating phrase wordcloud")
    wordcloud = WordCloud(width=2000, height=2000, scale=8, font_step=0.1, max_words=500, stopwords=None,
                          background_color='white', max_font_size=None, min_font_size=12, mode='RGB', prefer_horizontal=1.0,
                          collocations=True, normalize_plurals=True, 
                          mask=mask, relative_scaling=0.1, contour_color='orange',
                          contour_width=10, color_func=custom_hex_color_func, repeat=True).generate_from_frequencies(
        topic_freq)

    # plot the wordcloud
    fig = plt.figure(figsize=(10, 10), dpi=dpi)
    ax = plt.axes([0, 0, 1, 1])
    plt.imshow(wordcloud, interpolation="bilinear", aspect="equal")
    plt.axis('off')

    # Save the figure to a BytesIO object
    img_byte_arr = BytesIO()
    plt.savefig(img_byte_arr, format='png', dpi=150, bbox_inches='tight')
    img_byte_arr.seek(0)

    # Convert the BytesIO object to a base64 encoded string
    base64_encoded = base64.b64encode(img_byte_arr.getvalue()).decode('utf-8')

    if debug:
        plt.show()

    return base64_encoded


# generate a wordcloud from the keywords dict
def generate_keyword_wordcloud(keyword_freq, output_filename='keyword_cloud', dpi=150,  debug=False):
    wordcloud = WordCloud(width=1000, height=1000, scale=8, font_step=0.1,
                          max_words=200, stopwords=None, background_color='white', max_font_size=None,
                          mode='RGB', prefer_horizontal=0.5, relative_scaling=0.01, min_font_size=14, contour_color='orange',
                          contour_width=10, collocations=True, normalize_plurals=True, color_func=custom_hex_color_func,
                          mask=mask, repeat=True).generate_from_frequencies(
        keyword_freq)

    # plot the wordcloud
    fig = plt.figure(figsize=(10, 10), dpi=dpi)
    ax = plt.axes([0, 0, 1, 1])
    plt.imshow(wordcloud, interpolation="bilinear", aspect="equal")

    plt.axis('off')

    # Save the figure to a BytesIO object
    img_byte_arr = BytesIO()
    plt.savefig(img_byte_arr, format='png', dpi=150, bbox_inches='tight')
    img_byte_arr.seek(0)

    # Convert the BytesIO object to a base64 encoded string
    base64_encoded = base64.b64encode(img_byte_arr.getvalue()).decode('utf-8')

    if debug:
        plt.show()

    return base64_encoded

    # Close the plt figure to free up resources


if __name__ == '__main__':
    pass
