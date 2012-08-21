window.Emailify = class Emailify extends Batman.App

  # only for development
  Batman.ViewStore.prefix = 'assets/batman/views'

  @root 'stops#new'
  @resources 'stops'

  @on 'run', ->

  @on 'ready', ->
    console?.log "Emailify ready for use."

  @flash: Batman()
  @flash.accessor
    get: (key) -> @[key]
    set: (key, value) ->
      @[key] = value
      if value isnt ''
        setTimeout =>
          @set(key, '')
        , 2000
      value

  @flashSuccess: (message) -> @set 'flash.success', message
  @flashError: (message) ->  @set 'flash.error', message
