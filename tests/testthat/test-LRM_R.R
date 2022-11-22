test_that("Linear Regression works", {
  expect_equal(as.numeric(LRM_R(mtcars$mpg~mtcars$disp +mtcars$wt+mtcars$qsec )$r.squared), summary(lm(mtcars$mpg~mtcars$disp +mtcars$wt+mtcars$qsec ))$r.squared)
  expect_equal(as.numeric(LRM_R(mtcars$mpg~mtcars$disp +mtcars$wt+mtcars$qsec )$fstatistic), as.numeric(summary(lm(mtcars$mpg~mtcars$disp +mtcars$wt+mtcars$qsec ))$fstatistic[1]))
})
