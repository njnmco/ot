#' A Message Tracer
#'
#' This implements a tracer that delegates function calls to \code{message()}.
#'
#' @return a new tracer instance
#' @rdname message
#' @examples
#' z <- ot::getMsgTracer()
#' @export
getMsgTracer <- function() {
  structure(0, class="MSG_TRACER")
}

#' @export
startSpan.MSG_TRACER <- function(tracer, name, ..., childOf=list()) {
  ts <- Sys.time()
  span <- list(name=name,
               start=Sys.time(),
               tags=list(...),
               depth=paste0(childOf$depth,"  "),
               tracer=tracer)

  class(span) <- "MSG_SPAN"
  message(span$depth, "<", span$start, "> Entering: ", span$name)
  span
}

#' @export
print.MSG_TRACER <- function(x, ...) {}

###

#' @export
otlog.MSG_SPAN <- function(span, fmt, ..., timestamp=Sys.time()) {
  message(span$depth, "<", timestamp, "> ", sprintf(fmt, ...))
}

#' @export
finish.MSG_SPAN <- function(span, finishTime=Sys.time()) {
  message(span$depth, "<", finishTime, ">", "Exiting ", span$name)
}

#' @export
setTags.MSG_SPAN <- function(span, ...) {
  message(span$depth, "<", Sys.time(), ">", "Tag ", list(...), " on ", span$name)
}


#' @export
print.MSG_SPAN <- function(x, ...) {}
