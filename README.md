Simple modules that helps tracing of common operations.

```
log =
  error: ->
  debug: ->

stats =
  inc: ->
  timing: ->

Tracer = require 'tracer'

tracer = new Tracer(log, stats, {service_name: "my_service"})
tracer.error("label.name", "Error message goes here", {err: data})
tracer.message("label.name", "Message goes here", {some: data})

fn = -> {...}
tracer.measure("label.name", fn)
```
