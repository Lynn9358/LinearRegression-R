


LRM_R <- function(formula, df, model = TRUE, x = FALSE, y = FALSE){

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
  result <- list(coefficients = coefficients, r.squared = R_2 ,fstatistic = F_stat)

return(result)

}

bench::mark(summary(lm(H$weight~H$age +H$height ))$coef, LRM_R(H$weight~H$age +H$height ))
all.equal(summary(lm(H$weight~H$age +H$height ))$coef,LRM_R(H$weight~H$age +H$height)
aa$r.squared
as.numeric(aa$fstatistic[1])
