##########################################
# PREDICT A CATEGORICAL VARIABLE
##########################################

# Logistic regression - base R
##########################################

# Split into training and test set
set.seed(42)
data$train <- ifelse(runif(nrow(data)) < 0.7, 1, 0) # For 70/30 split; change if required
train <- subset(data, train == 1)
train <- subset(train, select = -train)
test <- subset(data, train == 0)
test <- subset(test, select = -train)

#Build model
lmodel <- glm(resp ~ pred1 +
                pred2 + 
                etc,
              train,
              family = binomial)
summary(lmodel)

# Feature selection - backwards selection
step(lmodel, train, direction = 'backward')

# Predict on test set
lpredict <- predict(lmodel, test, type = 'response')

# Evaluate model performance - mean squared error
lerror <- lpredict - test$resp
sqrt(mean(lerror^2))

# Evaluate model performance - AUC
lROC <- roc(test$resp, lprob)
plot(lROC, col = 'red')
auc(lROC)

# Lasso and ridge regression - glmnet package
##########################################

# Build model
trainx <- model.matrix(resp ~ pred1 +
                         pred2 +
                         etc,
                       train)
y <- train$resp
gmodel <- cv.glmnet(trainx, 
                    y, 
                    family = 'binomial', 
                    alpha = 0) # alpha = 0 for ridge regression and alpha = 1 for lasso regression 
summary(gmodel)

# Predict on test set
testx <- model.matrix(resp ~ pred1 +
                        pred2 +
                        etc,
                      test)
predict <- predict(gmodel$glmnet.fit,
                   testx,
                   type = 'response', # Should this be 'prob' for categorical?
                   s = model$lambda.min)

# Evaluate model performance - AUC
gROC <- roc(test$resp, gprob)
plot(gROC, col = 'red')
auc(gROC)

# Decision tree - rpart (and rpart.plot) package
##########################################

# Split into training and test set
set.seed(42)
data$train <- ifelse(runif(nrow(data)) < 0.7, 1, 0) # For 70/30 split; change if required
train <- subset(data, train == 1)
train <- subset(train, select = -train)
test <- subset(data, train == 0)
test <- subset(test, select = -train)

# Build model
rpmodel <- rpart(resp ~ pred1 +
                   pred2 +
                   etc,
                 train,
                 method = 'class')
rpart.plot(rpmodel, #rpart.plot package
           type = 3,
           fallen.leaves = TRUE)
rpmodel <- prune(rpmodel, cp = 0.012) # Optional pruning, determine cp from plot

# Predict on test set
rppredict <- predict(rpmodel, test, type = 'prob')

# Evaluate model performance - AUC
rpROC <- roc(test$resp, rpprob)
plot(rpROC, col = 'red')
auc(rpROC)

# Random forest - randomForest package
##########################################

# Build model
rfmodel <- randomForest(resp ~ pred1 +
                          pred2 +
                          etc,
                        train,
                        ntree = 1000,
                        importance = TRUE)
importance(rfmodel)
varImpPlot(rfmodel) # Optional - visualise highly ingluential variables

# Predict on test set
rfprob <- predict(rfmodel, test, type = 'prob')

# Evaluate model performance - AUC
rfROC <- roc(test$resp, rfprob[ , 1])
plot(rfROC, col = 'red')
auc(rfROC)

# Evaluate model performance - confusion matrix
confusionMatrix(ifelse(lpredict[, 1] > 0.1, # decide threshold 
                       'string1', 
                       'string2'), 
                test$resp)