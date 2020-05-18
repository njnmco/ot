#' A Mock Tracer implementation
#'
#' This implements a Tracer and Span which stores all function arguments in an environment.
#'
#' @rdname mock
#' @return a new tracer instance
#' @examples
#' z <- ot::getMockTracer()
#' @export
getMockTracer <- function() {
  structure(new.env(parent = emptyenv()), class="MOCK_TRACER")
}

#' @export
startSpan.MOCK_TRACER <- function(tracer, name, ..., childOf=NULL) {
  ts <- Sys.time()
  uuid <- sprintf("%08X%08X",
                  sample.int(.Machine$integer.max, 1),
                  as.integer(ts))
  span <- list(name=name,
               uuid=uuid,
               tracer=tracer,
               start=Sys.time(),
               finish=NA,
               tags=list(...),
               logs=list(),
               parent=childOf)

  span <- list2env(span, parent = emptyenv())
  class(span) <- "MOCK_SPAN"
  tracer[[sprintf("%08X", length(tracer))]] <- span
  span
}

#' @export
print.MOCK_TRACER <- function(x, ...) {
  print(as.list.environment(x), ...)
}


###

#' @export
otlog.MOCK_SPAN <- function(span, ..., timestamp=Sys.time()) {
  x <- structure(list(...), at=timestamp)
  span[["logs"]] <- append(span[["logs"]], list(x))
}

#' @export
finish.MOCK_SPAN <- function(span, finishTime=Sys.time()) {
  span[["finish"]] <- finishTime
  NULL
}

#' @export
#' @importFrom utils str
print.MOCK_SPAN <- function(x, ...) {
  cat(sprintf("Span(%s) [%s, %s]\n",x$name, x$start, x$finish))
  for(t in names(x$tags)) {
    cat(sprintf("  %s: %s\n", t, x$tags[[t]]))
  }
  for(t in x$logs) {
    cat(sprintf("<%s>\n", attr(t, "at")))
    str(structure(t, at=NULL))
  }

}
