#' Convert p-values to Z-scores
#'
#' Counvert two-sided test p-values to Z-scores using \code{qnorm}.
#'
#' @param pval Vector of two-sided test p-values.
#' @param direction Numeric or character vector of same length of pvalue vector. Examples of numeric valuses are log fold-change,
#' regression slope, or correlation coefficient. For charecter values, only "Up" and "Down" are allowed.
#' @return Vector of Z-scores.
#' @examples
#' set.seed(0)
#' n <- 10
#' pval <- runif(n)
#' logfc <- rnorm(n)
#' pval2z(pval, logfc)
#' direction <- sample(c("Up", "Down"), n, replace=TRUE)
#' pval2z(pval, direction)
#' @export

pval2z <- function(pval, direction){
  stopifnot(length(pval)==length(direction), names(pval)==names(direction))
  if(any(pval<0 | pval>1)) stop("p-values should be within [0, 1]")

  if(is.numeric(direction)){
    direction <- sign(direction)
  }else{
    stopifnot(direction %in% c("Up", "Down"))
    direction <- ifelse(direction=="Up", 1, -1)
  }

  z <- stats::qnorm(pval/2, lower.tail=FALSE) * direction
  return(z)
}
