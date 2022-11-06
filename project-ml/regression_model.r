# build a regression model

head(mtcars)

model <- lm(mgp ~ hp + wt, data = mtcars)

summary(model)

