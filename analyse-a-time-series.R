##########################################
# ANALYSE A TIME SERIES
##########################################

# Linear regression - base R
##########################################

# Split into training and test set
index <- round(nrow(data)*0.85) # For 85/15 split; change if required
train <- data[1:index, ]
test <- data[(index+1):nrow(data), ]

# Build model
model <- lm(res ~ pred1 + pred2 + etc, train)
summary(model)

# Predict on test set
predict <- predict(model, test)

# Plot model against data: train and test (time series)
fitted <- predict(model, data) %>% #dplyr package
  as.data.frame()
fitted <- cbind(data$date, fitted)
colnames(fitted) <- c('date', 'string')
ggplot() +
  geom_path(data, # predicted data
            aes(x = date,
                y = string,
                col = 'blue', # or something else
                group = 1),
            size = 1) +
  geom_path(data, # observed data
            aes(x = var,
                y = var,
                group = 1),
            size = 1) +
  geom_vline(xintercept = as.numeric(data$date[index]), # observed data
             linetype = 'dashed',
             size = 1)


# seasonal ARIMA
##########################################

library(astsa)
library(forecast)
library(fpp2)

# Convert to time series object
data <- ts(data, frequency = 12, start = c(2000, 1)) # edit as appropriate

# Split into training and test set
train <- window(data, start = c(2000, 1), end = c(2015, 12)) # edit as appropriate
test <- window(data, start = c(2016, 1), end = c(2017, 12)) # edit as appropriate

# Plot train
autoplot(train)

# Decompose train
autoplot(decompose(train)) +
  labs (title = 'Decomposition of ...')

# Difference train
autoplot(diff(train)) +
  labs(title = 'Differenced ...',
       y = NULL)

# Seasonally difference train
autoplot(diff(train, lag = 12)) +
  labs(title = 'Seasonally differenced...',
       y = NULL)

# Plot Acf and PAcf of differenced train
ggAcf(diff(train), lag.max = 36) +
  labs(title = 'Autocorrelation function - differenced ...')
ggPacf(diff(train), lag.max = 36) +
  labs(title = 'Partial autocorrelation function - differenced ...')

# Calculate automated arima model
auto.arima(train)
sarima(train, 0, 0, 0, 0, 0, 0, 12) # edit as appropriate

# Plot forecasts against actual for the test dataset period
autoplot(window(train, start = 2015)) +
  autolayer(forecast(Arima(train, 
                           order = c(0, 0, 0), # edit as appropriate 
                           seasonal = c(0, 0, 0)), # edit as appropriate
                     h = 16),
            series = 'Automated Forecast',
            PI = FALSE) +
  autolayer(test, 
            series = 'Actual', 
            PI = FALSE) +
  labs(title = 'Forecast by automated ARIMA model') +
  theme(legend.position = 'bottom')

# Evaluate model
accuracy(forecast(Arima(train,
                        order = c(0, 0, 0), # edit as appropriate
                        seasonal = c(0, 0, 0)), # edit as apppropriate
                  h = 16)$mean, test)

# Compare to Holt-Winters
accuracy(forecast(hw(train,
                     seasonal = 'additive'))$mean, test)

# Calculate forecast errors
errors_automated <- forecast(Arima(train,
                                   order = c(0, 0, 0), # edit as appropriate
                                   seasonal = c(0, 0, 0)), # edit as appropriate
                             h = 16)$mean - test
errors_hw <- forecast(hw(train,
                         seasonal = 'additive'))$mean - test
ggAcf(errors_automated, lag.max = 16) +
  labs(title = 'Forecast errors - automated ARIMA model')
ggAcf(errors_hw, lag.max = 16) +
  labs(title = 'Forecast errors - Holt-Winters model')

# Ljung-Box tests
Box.test(errors_automated, type='Ljung-Box')
Box.test(errors_hw, type='Ljung-Box')

# Plot automated forecast against actual for the test dataset period
autoplot(window(train, start = 2015)) + # edit as appropriate
  autolayer(forecast(Arima(train, 
                           order = c(0, 0, 0), # edit as appropriate
                           seasonal = c(0, 0, 0)), # edit as appropriate
                     h = 16),
            series = 'Automated Forecast') +
  autolayer(monthly_test, 
            series = 'Actual', 
            PI = FALSE) +
  labs(title = 'Forecast from automated ARIMA model') +
  theme(legend.position = 'bottom')