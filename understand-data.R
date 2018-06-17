##########################################
# UNDERSTAND DATA
##########################################

# Overview
str(df)
head(df)
tail(df)
glimpse(df) # dplyr package 
summary(df)

# categorical variable
count(df, col1, col2, etc)

# continuous variable
group_by(df, col) %>% # dplyr package
  summarise(min = min(col),
            median = median(col),
            max = max(col),
            mean = mean(col),
            sd = sd(col))

# Histogram
ggplot(df, # ggplot2 package
       aes(x = col,
           y = col,
           fill = col)) + 
  geom_bar(stat = 'identity',
           position = position_dodge())

# Density plot
ggplot(df, # ggplot2 package
       aes(x = col,
           fill = col)) +
  geom_density(alpha = 0.4)

# Boxplot
ggplot(df, # ggplot2 package
       aes(x = col,
           y = col,
           fill = col)) +
  geom_boxplot() +
  coord_flip() # Optional

# Column chart
ggplot() + # ggplot2 package
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
           width = 0.40)

# Line chart
ggplot(df, # ggplot2 package
       aes(x = col,
           y = col,
           group = col, # Optional
           colour = col)) + # Optional
  geom_line(size = 1)

# Scatterplot (jittered)
ggplot(df, # ggplot2 package
       aes(x = col,
           y = col,
           colour = col)) +
  geom_jitter()

# Scatterplot (no jittering)
ggplot(df, # ggplot2 package
       aes(x = col,
           y = col,
           colour = col)) +
  geom_point() +
  geom_smooth(method = lm, 
              se = FALSE) # Optional regression line

### faceting
facet_wrap( ~ col) #ggplot2 package

# Collinearity; pairwise correlations
pairs(df)
cor.test(df$col1, df$col2)