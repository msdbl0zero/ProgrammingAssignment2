## This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL # initialize inverse to NULL
  set <- function(y) {
    x <<- y #this cache operation stores the data 
    inv <<- NULL
  }
  get <- function() x  # get function returns the matrix
  setinv <- function(x) inv <<- x # sets the inverse 
  getinv <- function() inv  # gets the inverse
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
  if(!is.null(inv)) {  # if the inverse already exists, return it
    message("getting cached data")
    return(inv)
  }
  data <- x$get() # get the matrix
  inv <- solve(data, ...) # solve the inverse of the matrix
  x$setinv(inv)  # set the inverse of the matrix
  inv
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
