#' Open Tracing
#' @name ot
#' @docType package
NULL

#' @export
startSpan <- function(tracer, name, ...) {
  UseMethod("startSpan")
}

#' @export
inject <- function(tracer, contextObj, format, carrier) {
  if(inherits(contextObj, "span")) context <- getContext(contextObj)
  UseMethod("inject")
}

#' @export
extract <- function(tracer, format, carrier) {
  UseMethod("inject")
}


###

#' @export
setTags <- function(span, ...) {
  UseMethod("setTags")
}

#' @export
baggage <- function(span, ...) {
  UseMethod("baggage")
}

#' @export
`baggage<-` <- function(span, ...) {
  UseMethod("baggage<-")
}

#' @export
getContext <- function(span, ...) {
  UseMethod("getContext")
}


#' @export
otlog <- function(span, ..., timestamp=Sys.time()) {
  UseMethod("otlog")
}

#' @export
finish <- function(span, finishTime=Sys.time()) {
  UseMethod("finish")
}

