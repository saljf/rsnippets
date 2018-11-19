##########################################
# IMPORT DATA
##########################################

# Read in CSV
df <- read_csv('data.csv')
df <- read.csv('data.csv', stringsAsFactors = FALSE)

# Rename columns
colnames(df) <- c('col1', 'col2', etc)

# Replace NAs with 0
df$col[is.na(df$col)] <- 0

# Replace blanks with NA
df[df == ''] <- NA

# Fill values forward to replace following NAs (zoo package)
df$col <- na.locf(df$col)

# Convert to factor
df$col <- as.factor(df$col)

# Convert several to factor
cols <- c('a', 'b', 'c')
df[cols] <- lapply(df[cols], as.factor)

# Convert to ordinal
df$col <- factor(df$col,
                 levels = c('1', '2', '3'),
                 ordered = TRUE)

# Convert several to ordinals
cols <- c('a', 'b', 'c')
df[cols] <- lapply(df[cols],
                   factor,
                   levels = c('1', '2', '3'),
                   ordered = TRUE)

# Convert to date (lubridate package)
df$col <- ymd(df$col)

# Convert to POSIX (timestamp)
df$col <- as.POSIXct(df$col,
                     format='REFER TO DOCUMENTATION')

# Extract date from POSIX
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

# Find and replace
df$col <- gsub('existingstring', 'replacementstring', df$col)

# Find and replace (stringr package)
df$col <- str_replace_all(df$col, 'existingstring', 'replacementstring')

# Find and replace, conditional on existing variable
df$col <- ifelse(col == condition, value1, value2)

# Create new variable, value conditional on existing variable
df <- df %>%
  mutate(newcol = ifelse(col == condition, value1, value2))
