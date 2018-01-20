##########################################
# IMPORT DATA
##########################################

# Convert to factor
data$var <- as.factor(data$var)

# Convert to POSIX (timestamp)
data$var <- as.POSIXct(data$var,
                       format='REFER TO DOCUMENTATION')

# Extract date frOm POSIX
data$var <- as.Date(data$var,
                    tz = 'REFER TO DOCUMENTATION')

# Extract day of week from date
data$var <- as.factor(weekdays(data$var))
data$var <- factor(data$var,
                   levels = c('Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday',
                              'Saturday',
                              'Sunday'))

# Extract hour from POSIX
data$var <- as.integer(format(data$var, '%H'))
