class Tracer
  constructor: (log, stats, opts)->
    @prefix = opts.service_name
    @log = log
    @stats = stats

  trace: (label, message, object)->
    @log.error(message, object)
    @stats.inc "#{@prefix}.#{label}"

  error: (label, message, err)->
    @trace("#{label}.error", message, err)

  measure: (key, fn)=>
    start = new Date()
    fn()
    timing = (new Date() - start)
    @stats.timing "#{@prefix}.#{key}.time", timing
    @log.debug "Timing of #{@prefix}.#{key}.time: #{timing}"

module.exports = Tracer
