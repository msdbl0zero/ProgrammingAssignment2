## This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(x) inv <<- x
  getinv <- function() inv
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


## This function computes the inverse of the special "matrix" returned by
## makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), 
## then cacheSolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinv(inv)
  inv
}

## test case
# construct a 3x3 invertible matrix
mdat <- matrix(c(1,2,3, 5,6,8, 11,12,13), nrow = 3, ncol = 3, byrow = TRUE,
                dimnames = list(c("row1", "row2", "row3"),
                c("C.1", "C.2", "C.3")))
# call the function to store the mdat matrix
X <- makeCacheMatrix(mdat)
# call cacheSolve function to get the inverse of the matix
# first time, it solves it, after that returns the cached data
cacheSolve(X)
cacheSolve(X)
cacheSolve(X)
