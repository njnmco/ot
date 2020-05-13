stopifnot(requireNamespace("ot"))

{
  tracer <- ot::getMockTracer()

  Sys.sleep(1)
  span <- ot::startSpan(tracer, 'test_operation', key1="value1")

  Sys.sleep(1)
  ot::log(span, "HIA")

  Sys.sleep(1)
  span2 <- ot::startSpan(tracer, 'test_operation', key1="value2", childOf = span)

  Sys.sleep(1)
  ot::log(span, "RYLAH")

  Sys.sleep(1)
  ot::log(span2, "done")

  Sys.sleep(1)
  ot::finish(span)

  Sys.sleep(1)
  ot::finish(span2)
}

stopifnot(inherits(tracer, 'MOCK_TRACER'))

stopifnot(
  span$name == 'test_operation',
  span$start < span2$start,
  span2$start < span$finish,
  span$finish < span2$finish,
  length(span$logs) == 2,
  span$tags$key1 == 'value1',
  identical(span, span2$parent)
)

