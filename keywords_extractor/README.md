# metaAds

## Version 1.0

- Collecting ads
- clustering through embedding by spacy large model
- wordcloud to know the sentiment

Problem: the cluster isn't useful, i.e., containing a lots of noise and uninterested information

## Version 2.0 
- Collecting ads 
- entity recognition through hugging face models
- wordcloud to know the sentiment

Problem: the entity identified are not politically relevant, and the model need to be trained by labeled data to enable downstream entity recognition task but we don't have any data to train the model.

## Version 3.0 (Latest topic extraction)
- Load MongoDB dump
- YAKE keyword extraction
- Remove similar topics through string comparison
- wordcloud to know the sentiment

Problem: frequenist method susceptible to ads spam.

## Version 3.1 (Latest word extraction)
- Load MongoDB dump
- TF-IDF vectorization
- rank by TF-IDF importance score
- remove similar words through string comparison
- wordcloud to know the sentiment


