##########################################
# COMMUNICATE FINDINGS
##########################################

# Overview
str(data)
glimpse(data) #dplyr package

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
           width = 0.40) +
  scale_fill_manual(name = NULL,
                    values = c('string1' = COLOUR1, 
                               'string2' = COLOUR2))

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

# ggplot2 variations:

### faceting
facet_wrap( ~ var)

### manually change fill colours
scale_fill_manual(name = NULL,
                  values = c('value1' = 'COLOUR1',
                             'value2' = 'COLOUR2',
                             etc),
                  labels = c('value1' = 'string',
                             'value2' = 'string',
                             etc))

### manually change axis limits (see alternative in scale_x_continuous)
expand_limits(x = c(startvalue:endvalue),
              y = c(startvalue:endvalue))

### manually change axis marks - continuous variable
scale_x_continuous(limits = c(startvalue, endvalue),
                   breaks = c(break1, break2, etc),
                   labels = c('string', 'string', etc))

### manually change axis labels - categorical variable
scale_x_discrete(labels = c('string', 'string', etc))

### manually change axis labels
labs(x = 'string',
     y = 'string')

### move legend underneath plot
theme(legend.direction = 'horizontal', 
      legend.position = 'bottom')