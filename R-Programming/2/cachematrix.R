## The two functions makeCacheMatrix() and cacheSolve() implement the
## computation of the inverse of a matrix and caching of results for 
## matrices for which the computation has been done in the past.

## How To use:
## create a matrix matrix <- matrix(....)
## create a special matrix using x <- makeCacheMatrix()
## To compute the inverse use cacheSolve(x)
## If the inverse is available in cache the computation will be skipped
## and the result will be returned from cache.

## The first function, makeCacheMatrix creates a special "matrix", 
## which is really a list containing a function to
# 
## 1. set <- set the value of the matrix
## 2. get <- get the value of the matrix
## 3. setinv <- set the value of the inverse
## 4. getinv <- get the value of the inverse

## Return a special matrix for 'x'
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(inverse) inv <<- inverse
  getinv <- function() inv
  list(set = set, get = get, setinv = setinv, getinv = getinv)
}

## The following function calculates the inverse of the special "matrix" 
## created with the above function. However, it first checks to see if 
## the inverse has already been calculated. If so, it gets the inverse 
## from the cache and skips the computation. Otherwise, it calculates 
## the inverse of the given matrix and sets the value of the inverse 
## in the cache via the setinv function.

## Return a matrix that is the inverse of 'x'
cacheSolve <- function(x, ...) {
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
