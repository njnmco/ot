#' A NoOp Tracer implementation
#'
#' The OpenTracing specification mandates a tracer implementation which does nothing.
#'
#'
#' @rdname noop
#' @export
getNoOpTracer <- function() {
  structure(0, class="NOOP_TRACER")
}


#' @export
startSpan.NOOP_TRACER <- function(tracer, name, ...) {
  structure(0, class="NOOP_SPAN")
}

###

#' @export
otlog.NOOP_SPAN <- function(span, ..., timestamp=Sys.time()) {
  span
}

#' @export
finish.NOOP_SPAN <- function(span, finishTime=Sys.time()) {
  NULL
}
