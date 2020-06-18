import chardet

csv_file = open('data/IMDb movies.csv', "rb").read()

chardet.detect(csv_file)
