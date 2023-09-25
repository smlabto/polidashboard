import matplotlib.pyplot as plt
from wordcloud import WordCloud
from PIL import Image
import numpy as np
import base64
from io import BytesIO

mask = np.array(Image.open("thought_bubble_1.png"))


# generate a "phrase" wordcloud from the top topics dict list
def generate_phrase_wordcloud(topic_freq, output_filename='phrase_cloud', debug=False):
    # create a dictionary with topic as a key and frequency as value

    # wordcloud = WordCloud(width=1500, height=500, scale=8, font_step=0.01,
    #                       max_words=200, stopwords=None, background_color='whitesmoke', max_font_size=None,
    #                       mode='RGB', prefer_horizontal=0.5, relative_scaling=0.3,
    #                       collocations=True, normalize_plurals=True, colormap='winter_r').generate_from_frequencies(
    #     topic_freq)
    #
    # # plot the wordcloud
    # fig = plt.figure(figsize=(15, 5), dpi=100)
    # ax = plt.axes([0, 0, 1, 1])
    # plt.imshow(wordcloud, interpolation="nearest", aspect="equal")
    # plt.axis('off')

    wordcloud = WordCloud(width=1000, height=1000, scale=8, font_step=0.1, max_words=1000, stopwords=None,
                          background_color='white', max_font_size=None, mode='RGB', prefer_horizontal=0.5,
                          collocations=True, normalize_plurals=True, mask=mask, relative_scaling=0.3,
                          contour_color='orange', contour_width=10, colormap='autumn_r', repeat=True).generate_from_frequencies(
        topic_freq)

    # plot the wordcloud
    fig = plt.figure(figsize=(10, 10), dpi=100)
    ax = plt.axes([0, 0, 1, 1])
    plt.imshow(wordcloud, interpolation="nearest", aspect="equal")
    plt.axis('off')

    # Save the figure to a BytesIO object
    img_byte_arr = BytesIO()
    plt.savefig(img_byte_arr, format='png', dpi=100, bbox_inches='tight')
    img_byte_arr.seek(0)

    # Convert the BytesIO object to a base64 encoded string
    base64_encoded = base64.b64encode(img_byte_arr.getvalue()).decode('utf-8')

    if debug:
        plt.show()

    return base64_encoded


# generate a wordcloud from the keywords dict
def generate_keyword_wordcloud(keyword_freq, output_filename='keyword_cloud', debug=False):
    # wordcloud = WordCloud(width=1500, height=500, scale=8, font_step=0.01,
    #                       max_words=200, stopwords=None, background_color='whitesmoke', max_font_size=None,
    #                       mode='RGB', prefer_horizontal=0.5, relative_scaling=0.3,
    #                       collocations=True, normalize_plurals=True, colormap='winter_r').generate_from_frequencies(
    #     keyword_freq)

    # if the length of the phrase is not

    wordcloud = WordCloud(width=1000, height=1000, scale=8, font_step=0.1,
                          max_words=200, stopwords=None, background_color='white', max_font_size=None,
                          mode='RGB', prefer_horizontal=0.5, relative_scaling=0.0001, contour_color='orange',
                          contour_width=10, collocations=True, normalize_plurals=True, colormap='autumn_r',
                          mask=mask, repeat=True).generate_from_frequencies(
        keyword_freq)

    # plot the wordcloud
    fig = plt.figure(figsize=(10, 10), dpi=100)
    ax = plt.axes([0, 0, 1, 1])
    plt.imshow(wordcloud, interpolation="nearest", aspect="equal")

    plt.axis('off')

    # Save the figure to a BytesIO object
    img_byte_arr = BytesIO()
    plt.savefig(img_byte_arr, format='png', dpi=100, bbox_inches='tight')
    img_byte_arr.seek(0)

    # Convert the BytesIO object to a base64 encoded string
    base64_encoded = base64.b64encode(img_byte_arr.getvalue()).decode('utf-8')

    if debug:
        plt.show()

    return base64_encoded

    # Close the plt figure to free up resources


if __name__ == '__main__':
    pass
