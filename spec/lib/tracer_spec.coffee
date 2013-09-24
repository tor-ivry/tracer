lib = '../../lib'
Tracer = require "#{lib}/tracer.coffee"
sinon = require 'sinon'
should = require 'should'

stats =
  inc: ()->
  timing: ()->

log =
  debug: ()->
  error: ()->
  warn: ()->

describe 'Tracer', ->
  sandbox = null
  beforeEach ->
    sandbox = sinon.sandbox.create()
    @tr = new Tracer log, stats,
      service_name: 'tracer'

  afterEach ->
    sandbox.restore()

  it "handles error", ->
    sinon.spy(@tr.log, 'error')
    sinon.spy(@tr.stats, 'inc')

    @tr.fail "go", "Hello", {'err': 1}

    @tr.log.error.calledWith("Hello", {'err': 1}).should.be.ok
    @tr.stats.inc.calledWith('tracer.go.error').should.be.ok

  it "measures times", ->
    sinon.spy(@tr.stats, 'timing')
    sinon.spy(@tr.log, 'debug')
    @tr.start 'measure'
    @tr.stop 'measure'

    @tr.stats.timing.calledWith("tracer.measure.time", 0).should.be.ok
    @tr.log.debug.calledWith("Timing of tracer.measure.time: 0").should.be.ok
