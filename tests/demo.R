{
tracer <- getMsgTracer()
span <- startSpan(tracer, 'test_operation', key1="value1")
otlog(span, "HIA")

span2 = startSpan(tracer, 'test_operation', key1="value2", childOf = span)
otlog(span, "RYLAH")
otlog(span2, "done")

finish(span)
finish(span2)
span

tracer
}
