#' A NoOp Tracer implementation
#'
#' The OpenTracing specification mandates a tracer implementation which does nothing.
#'
#'
#' @rdname noop
#' @return a tracer instance
#' @examples
#' z <- ot::getNoOpTracer()
#' @export
getNoOpTracer <- function() {
  structure(0, class="NOOP_TRACER")
}

#' @export
inject.NOOP_TRACER <- function(tracer, contextObj, format, carrier) {
  NULL
}

#' @export
extract.NOOP_TRACER <- function(tracer, format, carrier) {
  NULL
}


#' @export
startSpan.NOOP_TRACER <- function(tracer, name, ...) {
  structure(0, class="NOOP_SPAN")
}

###

#' @export
setTags.NOOP_SPAN <- function(span, ...) {
  NULL
}

#' @export
otlog.NOOP_SPAN <- function(span, ..., timestamp=Sys.time()) {
  span
}

#' @export
finish.NOOP_SPAN <- function(span, finishTime=Sys.time()) {
  NULL
}

#' @export
baggage.NOOP_SPAN <- function(span,...) {
  NULL
}

#' @export
`baggage<-.NOOP_SPAN` <- function(span, ..., value) {
  span
}

#' @export
getContext.NOOP_SPAN <- function(span, ...) {
  NULL
}

