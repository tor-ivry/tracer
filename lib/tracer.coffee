class Tracer
  constructor: (log, stats, opts)->
    @prefix = opts.service_name
    @log = log
    @stats = stats

  error: (message, object) ->
    @log.error(message, object)

  trace: (label, message, object)->
    if message
      @log.debug(message, object)
    @stats.inc "#{@prefix}.#{label}"

  fail: (label, message, err)->
    @error(message, err)
    @stats.inc "#{@prefix}.#{label}.error"

  start: (key) ->
    start = new Date()
    return =>
      @_timing(key, start)

  measure: (key, fn)=>
    start = new Date()
    fn()
    @_timing(key, start)

  _timing: (key, start)->
    timing = (new Date() - start)
    @stats.timing "#{@prefix}.#{key}.time", timing
    @log.debug "Timing of #{@prefix}.#{key}.time: #{timing}"

module.exports = Tracer
