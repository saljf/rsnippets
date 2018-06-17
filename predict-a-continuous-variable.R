##########################################
# PREDICT A CONTINUOUS VARIABLE
##########################################

# Linear regression - base R
##########################################

# Split into training and test set
set.seed(42)
df$train <- ifelse(runif(nrow(df)) < 0.7, 1, 0) # For 70/30 split; change if required
train <- subset(df, train == 1)
train <- subset(train, select = -train)
test <- subset(df, train == 0)
test <- subset(test, select = -train)

# Feature selection - backwards selection
step(model, train, direction = 'backward')

# Build model
model <- lm(res ~ pred1 + pred2 + etc, train)
summary(model)

# Predict on test set
predict <- predict(model, test)

# Evaluate model performance - mean squared error
error <- predict - test$res
sqrt(mean(error^2))

# Lasso and ridge regression - glmnet package
##########################################

# Build model
trainx <- model.matrix(res ~ pred1 +
                         pred2 +
                         etc,
                       train)
y <- train$res
model <- cv.glmnet(trainx, 
                   y, 
                   family = 'binomial', 
                   alpha = 0) # alpha = 0 for ridge regression and alpha = 1 for lasso regression 
summary(model)

# Predict on test set
testx <- model.matrix(res ~ pred1 +
                        pred2 +
                        etc,
                      test)
predict <- predict(model$glmnet.fit,
                   testx,
                   type = 'response',
                   s = model$lambda.min)
