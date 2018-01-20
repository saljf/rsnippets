##########################################
# UNDERSTAND DATA
##########################################

# Overview
str(data)
head(data)
tail(data)
glimpse(data) #dplyr package

# categorical variable
count(data, var1, var2, etc)

# continuous variable
group_by(data, var) %>% # dplyr package
  summarise(min = min(var),
            median = median(monthly_amount),
            max = max(monthly_amount),
            mean = mean(monthly_amount),
            sd = sd(monthly_amount))

# Histogram
ggplot(data, #ggplot2 package
       aes(x = var,
           y = var,
           fill = var)) + 
  geom_bar(stat = 'identity',
           position = position_dodge())

# Density plot
ggplot(data, #ggplot2 package
       aes(x = var,
           fill = var)) +
  geom_density(alpha = 0.4)

# Boxplot
ggplot(data, #ggplot2 package
       aes(x = var,
           y = var,
           fill = var)) +
  geom_boxplot() +
  coord_flip() # Optional

# Column chart
ggplot() + #ggplot2 package
  geom_col(data,
           aes(x = var,
               y = var,
               fill = 'string1'),
           position = position_nudge(x = 0.3), # or change parameters
           width = 0.40) +
  geom_col(data,
           aes(x = var,
               y = var,
               fill = 'string2'),
           position = position_nudge(x = 0.7),
           width = 0.40)

#Line chart
ggplot(data, #ggplot2 package
       aes(x = var,
           y = var,
           group = var, # Optional
           colour = var)) + #Optional
  geom_line(size = 1)

# Scatterplot (jittered)
ggplot(data, #ggplot2 package
       aes(x = var,
           y = var,
           colour = var)) +
  geom_jitter()

# Scatterplot (no jittering)
ggplot(data, #ggplot2 package
       aes(x = var,
           y = var,
           colour = var)) +
  geom_point() +
  geom_smooth(method = lm, 
              se = FALSE) # Optional regression line

### faceting
facet_wrap( ~ var) #ggplot2 package

# Collinearity
pairs(data)