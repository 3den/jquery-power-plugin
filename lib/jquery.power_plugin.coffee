$ = jQuery

# Public: PowerPlugin (0.5.2)
#
class $.PowerPlugin
  defaults: {}
  events: {}

  @setup: (name) ->
    that = @
    @pluginName = name
    $.fn[@pluginName] = (options) ->
      that.getInstance(this, options).bindEvents()
      this

  @getInstance: (element, options) ->
    new @($(element), options)

  constructor: (element, options={}) ->
    @element = @el = $(element)
    @setOptions(options)
    @initialize()

  setOptions: (options) ->
    @options = $.extend true, {}, @defaults, options

  # Public: custom initalization.
  #
  # Overload this method to load instance variables
  # and/or to do other stuff during the initalization.
  #
  # Returns nothing.
  initialize: ->

  # Public: binds all plugin events.
  #
  # This binds all @events to the @element.
  #
  # Returns nothing.
  bindEvents: ->
    for event, callback of @events
      @bindEvent event, callback

  # Public: binds a given event.
  #
  # event - the event string.
  # callback - the callback method.
  #
  # Examples
  #
  #   plugin.bindEvent "click", (e) ->
  #     alert("I am binded to @element")
  #
  #   plugin.bindEvent "click button", (e) ->
  #     alert("I am binded to a `button` in the @element")
  #
  # Returns nothing.
  bindEvent: (event, callback) ->
    keys      = event.split " "
    trigger   = keys.shift()
    selector  = keys.join " "
    if selector
      $(@element).on trigger, selector, @eventCallback(callback)
    else
      $(@element).on trigger, @eventCallback(callback)

  # Internal: higher-order callback function.
  #
  # callback - string with the name of the callback method.
  #
  # Returns a callback function.
  eventCallback: (callback) ->
    that = this
    (args...) -> that[callback].apply that, args
