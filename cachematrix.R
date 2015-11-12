## This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
}


## This function computes the inverse of the special "matrix" returned by
## makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), 
## then cacheSolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
}

## test case
# construct a 3x3 invertible matrix
mat <- matrix(c(1,2,3, 5,6,8, 11,12,13), nrow = 3, ncol = 3, byrow = TRUE,
                dimnames = list(c("A", "B", "C"),
                c("r1", "r2", "r3")))
# call the function to store the mdat matrix
X <- makeCacheMatrix(mat)
# call cacheSolve function to get the inverse of the matix
# first time, it solves it, after that returns the cached data
cacheSolve(X)
cacheSolve(X)
cacheSolve(X)
