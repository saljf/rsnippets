##########################################
# IMPORT DATA
##########################################

# Read in CSV
df <- read_csv('data.csv')

# Convert to factor
df$col <- as.factor(df$col)

# Convert to date (lubridate package)
df$col <- ymd(df$col)

# Convert to POSIX (timestamp)
df$col <- as.POSIXct(df$col,
                     format='REFER TO DOCUMENTATION')

# Extract date frOm POSIX
df$col <- as.Date(df$col,
                  tz = 'REFER TO DOCUMENTATION')

# Extract day of week from date
df$col <- factor(weekdays(df$col),
                 levels = c('Monday',
                            'Tuesday',
                            'Wednesday',
                            'Thursday',
                            'Friday',
                            'Saturday',
                            'Sunday'),
                 ordered = TRUE)

# Convert to time (hms package)
df$col <- as.hms(df$col)

# Extract hour from POSIX
df$col <- as.integer(format(df$col, '%H'))

# Convert to title case (stringr package)
df$col <- str_to_title(df$col)

# Find and replace (stringr package)
df$col <- str_replace_all(df$col, 'existingstring', 'replacementstring')

# Create new variable, value conditional on existing variable
df <- df %>%
  mutate(newcol = ifelse(col == condition, value1, value2))