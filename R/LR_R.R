

LR_R <- function(formula, df, model = TRUE, x = FALSE, y = FALSE){
  #Find model Frame, response variables and covariance
  MF1 = model.frame(formula)
  Y = model.response(MF1)
  X = model.matrix(MF1)
  n = nrow(X)
  p = ncol(X)

  # Calculate estimated value of coefficients
  coeff = solve(t(X)%*%X)%*%t(X)%*%Y

  #Calculate residual
  Yhat = X%*%betahat
  epsilonhat = Y - Yhat
  #Estimated sigma^2
  sigma_squared = t(epsilonhat)%*%epsilonhat/(n-p)
  #Variance of beta
  var_betahat = diag( solve(t(X)%*%X) )*c(sigma_squared)
  se_betahat = sqrt(var_betahat) ## se of betahat
  #Inference: t statistic and p val for H0: beta=0 ####
  t_statistic = c(betahat/se_betahat)
  p_value = c(2*( 1-pt(q=abs(t_statistic),df=n-p) ))
  #Calculation of R

  by_hand =cbind(Estimate=c(betahat),
                 Std_Err=se_betahat,
                 t_statistic=t_statistic,
                 p_value=p_value)

  return(by_hand)
}

