#'Linear Regression Model using R
#'
#'LRM_R is used to implementing simple and multiple linear regression using least squares method in R.
#'It can carry out the estimated value，standard deviation and statistics value of coefficients
#'
#'
#' @param formula  a symbolic description of the model to be fitted.
#' @param x=FALSE  logicals.It is TRUE after the model matrix returned.
#' @param y=FALSE  logicals.It is TRUE after the reponse matrix returned.
#'
#'
#'@returns LRM_R returns a set of simple and multiple linear regression result of formula.
#'An object of class "LRM_R" is a list containing at least the following components:
#'\itemize{
#'   \item coefficients -  The estimated value, standard deviation and statistics value of coefficients
#'   \item r.squared - The coefficient of determination of the fitted model
#'   \item fstatistic - The result of F-statistic of the fitted model
#'   \item Y_model - The result of linear regression for response matrix
#' }
#'
#'@examples
#'#Using R's default dataset
#'LRM_R(mtcars$mpg~mtcars$disp +mtcars$wt+mtcars$qsec )
#'
#'#In addition to data frames, it also supply vectors.
#'a <- c(1.1,2.5,4.1,5.0,6.5,2.6,1.1,3.5,3.3,4.1)
#'b <- c(4.8,4.1,4.4,3.5,5.8,3.8,6.0,4.8,4.3,4.6)
#'LRM_R(a~b)$coefficients
#'LRM_R(a~b)$r.squared
#'
#'
#'@export
#'

LRM_R <- function(formula,x = FALSE, y = FALSE){
#Find model frame, response variables and covariance
  MF1 = model.frame(formula)
  Y = model.response(MF1)
  X = model.matrix(MF1)
  n = nrow(X)
  p = ncol(X)

# Calculate estimated value of coefficients
  coeff = solve(t(X)%*%X)%*%t(X)%*%Y

#Calculate residual and the estimated value of Y
  Y_e = X%*%coeff
  residual = Y - Y_e

#Estimated sigma^2
  sigma_2 = t(residual)%*%residual/(n-p)

#Calculate estimated variance and standard deviation of coefficients
  var_coeff = diag( solve(t(X)%*%X) )*c(sigma_2)
  sd_coeff = sqrt(var_coeff)

#Calculate t statistic and p value for coefficient(under hypothesis that coefficient are zreo )
  t_stat = c(coeff/sd_coeff)
  p_value_t = c(2*( 1-pt(q=abs(t_stat),n-p) ))

#Calculation of R and F-statistics
  R_2 = var(Y_e)/var(Y)
  F_stat = var(Y_e)*(n-1)/(p-1)/sigma_2
  p_value_F = c(pf(F_stat,p-1,n-p,lower.tail = FALSE) )

#Calculation coefficients
  coefficients =cbind("Estimate"=c(coeff), "Std. Error" =sd_coeff,"t value" =t_stat,"Pr(>|t|)" =p_value_t)

# build result
  result <- list(coefficients = coefficients, r.squared = R_2 ,fstatistic = F_stat,Y_model = Y_e)

return(result)

}

