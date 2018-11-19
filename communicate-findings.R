##########################################
# COMMUNICATE FINDINGS
##########################################

# Overview
str(df)
glimpse(df) #dplyr package

# Histogram
ggplot(df, #ggplot2 package
       aes(x = col,
           y = col,
           fill = col)) + 
  geom_bar(stat = 'identity',
           position = position_dodge())

# Density plot
ggplot(df, #ggplot2 package
       aes(x = col,
           fill = col)) +
  geom_density(alpha = 0.4)

# Boxplot
ggplot(df, #ggplot2 package
       aes(x = col,
           y = col,
           fill = col)) +
  geom_boxplot() +
  coord_flip() # Optional

# Barchart
ggplot(df, #ggplot2 package
       aes(x = col,
           y = col,
           fill = col)) +
  geom_bar(stat ='identity') +
  coord_flip() # Optional

# Stacked barchart
ggplot(df, #ggplot2 package
       aes(x = col,
           fill = col)) +
  geom_bar(stat ='fill') +
  coord_flip() # Optional

# Column chart
ggplot() + #ggplot2 package
  geom_col(df,
           aes(x = col,
               y = col,
               fill = 'string1'),
           position = position_nudge(x = 0.3), # or change parameters
           width = 0.40) +
  geom_col(df,
           aes(x = col,
               y = col,
               fill = 'string2'),
           position = position_nudge(x = 0.7),
           width = 0.40) +
  scale_fill_manual(name = NULL,
                    values = c('string1' = COLOUR1, 
                               'string2' = COLOUR2))

#Line chart
ggplot(df, #ggplot2 package
       aes(x = col,
           y = col,
           group = col, # Optional
           colour = col)) + #Optional
  geom_line(size = 1)

# Scatterplot (jittered)
ggplot(df, #ggplot2 package
       aes(x = col,
           y = col,
           colour = col)) +
  geom_jitter()

# Scatterplot (no jittering)
ggplot(df, #ggplot2 package
       aes(x = col,
           y = col,
           colour = col)) +
  geom_point() +
  geom_smooth(method = lm, 
              se = FALSE) # Optional regression line

# Bubble plot
ggplot(df, #ggplot2 package
       aes(x = col,
           y = col,
           fill = col)) +
  geom_count() +
  scale_size_area() # Optional

# ggplot2 variations:

### minimalist background
theme(panel.background = element_blank(),
      axis.ticks = element_blank(),
      panel.grid.major.x = element_line(size = 0.5, linetype = 'solid', colour = 'lightgrey')) # Option to add gridlines back in

### faceting
facet_wrap( ~ col)

### manually change fill colours
scale_fill_manual(name = NULL,
                  values = c('value1' = 'COLOUR1',
                             'value2' = 'COLOUR2',
                             etc),
                  na.value = 'grey', # Optional to set NAs as grey
                  labels = c('value1' = 'string',
                             'value2' = 'string',
                             etc))

### manually change axis limits (see alternative in scale_x_continuous)
expand_limits(x = c(startvalue:endvalue),
              y = c(startvalue:endvalue))

### manually change axis marks - continuous variable
scale_x_continuous(limits = c(startvalue, endvalue),
                   breaks = c(break1, break2, etc), # Alternative: breaks = seq(startvalue, endvalue, increment)
                   labels = c('string', 'string', etc)) # Show numbers as percentage: labels = percent(seq(startvalue, endvalue, increment)) # scales package

### manually change axis labels - categorical variable
scale_x_discrete(labels = c('string', 'string', etc))

### manually set labels
labs(title = 'string',
     x = 'string',
     y = 'string',
     caption = 'string')

### set text size and centre title
theme(axis.text = element_text(size = 10),
     plot.title = element_text(size = 16, hjust = 0.5))

### move legend underneath plot
theme(legend.direction = 'horizontal', 
      legend.position = 'bottom')

### reverse order of legend
guides(fill = guide_legend(reverse = TRUE))

# animate ggplot: export to GIF (magick package)

plotf <- function (i) {
  plot <- ggplot(etc) +
    ggsave(filename = paste0("./plot", i,".png"),
           width = 6, height = 4, dpi = 150)
}

seq(from = startvalue, to = endvalue, by = increment) %>% 
  map_df(plotf)

list.files(path = "./", pattern = "*.png", full.names = TRUE) %>% 
  map(image_read) %>%
  image_join() %>%
  image_animate(fps = 2) %>% # speed
  image_write('animation.gif')
