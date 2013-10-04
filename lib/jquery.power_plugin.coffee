$ = jQuery

# Public: PowerPlugin (0.5.3)
#
class $.PowerPlugin
  defaults: {}
  events: {}

  # Public: Setup a jQuery plugin
  #
  # pluginName - the name of th plugin
  # Overload this method to load instance variables
  # and/or to do other stuff during the initalization.
  #
  # Examples
  #
  #   class MyPlugin extends $.PowerPlugin
  #     ...
  #
  #   # gives a name to the plugin
  #   MyPlugin.setup("myPlugin")
  #
  #   # attaches the plugin to an element
  #   $(".some-elements").myPlugin()
  #
  #   # attaches the plugin and oveload default options
  #   $(".other-elements").myPlugin
  #     anOption: "something"
  #     anOtherOption: "something else"
  #     ...
  #
  # Returns plugin function
  @setup: (pluginName) ->
    that = @
    $.fn[pluginName] = (options) ->
      new that(this, options)
      this

  constructor: (element, options={}) ->
    @element = @el = $(element)
    @setOptions(options)
    @initialize()
    @bindEvents()

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
