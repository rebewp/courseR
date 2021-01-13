# Data Sources

The "books.tsv" and "books.txt" data sets were obtained from the New York Times using their Books API and the `jsonlite` R package. "publishers_with_places.xlsx" was then deducted from this (and its non-fiction complementary): the unique publishers were extracted and their respective places manually (i.e., google searches) added.

"ches_2017_modified.csv" was downloaded from the CHES homepage (https://www.chesdata.eu) and then modified using `dplyr`.

"speeches.csv" contains speeches which were held in the Swedish parliament (Riksdagen). The data were collected by Måns Magnusson on the official Riksdagen homepage, cleaned, and can be downloaded from his GitHub Repo (<https://www.github.com/MansMeg/rcrpsriksdag>).

"spotify2018.csv" contains the 100 most-played songs on Spotify in 2018. It was downloaded from Kaggle (<https://www.kaggle.com/nadintamer7top-spotify-tracks-of-2018>).
