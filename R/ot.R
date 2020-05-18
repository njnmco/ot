#' Open Tracing
#'
#' Open Tracing is a specification for trace logging. This package provides generics for the required methods, and a minimal
#' implementation for testing purposes.
#'
#' @name ot
#' @docType package
#'
#' @seealso \url{https://opentracing.io/}
NULL

#' Tracer methods
#'
#' Tracer objects encapsulate the state of the logging system. startSpan creates a span, and inject and extract set metadata via sidechannels.
#'
#' @param tracer the tracing implementation
#' @param name the name of the span
#' @param ... left to implementation
#' @rdname tracer-methods
#' @examples
#' z <- ot::getNoOpTracer()
#' ot::startSpan(z)
#' ot::inject(z, list("User-Agent"="R"), "HTTP_HEADERS", NULL)
#' ot::extract(z, "HTTP_HEADERS", NULL)
#' @export
startSpan <- function(tracer, name, ...) {
  UseMethod("startSpan")
}

#' @param contextObj a span or span context
#' @param format One of the OpenTracing format values
#' @param carrier A corresponding carrier object
#' @rdname tracer-methods
#' @export
inject <- function(tracer, contextObj, format, carrier) {
  if(inherits(contextObj, "span")) contextObj <- getContext(contextObj)
  UseMethod("inject")
}

#' @rdname tracer-methods
#' @export
extract <- function(tracer, format, carrier) {
  UseMethod("extract")
}


###


#' Span Object Methods
#'
#' These define the core methods required by the specification for using spans.
#'
#' @param span a span object
#' @param ... defined by implementation
#' @return the span, except for getContext which returns the span's parent context and baggage, which returns any baggage objects.
#' @rdname span-methods
#' @examples
#' s <- ot::startSpan(ot::getNoOpTracer())
#' ot::setTags(s, foo=1)
#' ot::baggage(s) <- list(ctx=1)
#' ot::getContext(s)
#' ot::otlog(s, foo=1)
#' ot::log(s, bar=2)
#' ot::finish(s)
#' ot::baggage(s)
#' @export
setTags <- function(span, ...) {
  UseMethod("setTags")
}

#' @export
#' @rdname span-methods
baggage <- function(span, ...) {
  UseMethod("baggage")
}

#' @param value the baggage data
#' @rdname span-methods
#' @export
`baggage<-` <- function(span, ..., value) {
  UseMethod("baggage<-")
}

#' @rdname span-methods
#' @export
getContext <- function(span, ...) {
  UseMethod("getContext")
}

#' @param timestamp a POSIXct timestamp for the beginning of a span
#' @rdname span-methods
#'
#' @note Developers should implement the \code{otlog} method only for their spans - log is a generic method used by R for logarithms. \code{ot::log} is an alias for convenience only.
#'
#' @export
otlog <- function(span, ..., timestamp=Sys.time()) {
  UseMethod("otlog")
}

#' @rdname span-methods
#' @export
log <- function(span, ..., timestamp=Sys.time()) {
  UseMethod("otlog")
}

#' @param finishTime a POSIXct timestamp for the end of a span
#' @rdname span-methods
#' @export
finish <- function(span, finishTime=Sys.time()) {
  UseMethod("finish")
}

