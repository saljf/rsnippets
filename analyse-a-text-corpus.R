##########################################
# ANALYSING A TEXT CORPUS
##########################################

wordcloud(data$var, # values #wordcloud package
          data$var, # value frequencies
          min.freq = int,
          random.order = FALSE,
          colors = brewer.pal(8, 'Dark2')) # or choose an alternative #RColorBrewer pacakge
