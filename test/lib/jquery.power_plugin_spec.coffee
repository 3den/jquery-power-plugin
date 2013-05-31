#= require spec_helper

describe "$.PowerPlugin", ->

  describe ".setup", ->
    class DummyPlugin extends $.PowerPlugin
      defaults:
        message: "Hello World"
      initialize: ->
        @element.append("<p>#{@options.message}</p>")

    beforeEach ->
      @div = $("<div></div>")
      DummyPlugin.setup("dummyPlugin")

    it "adds the plugin to jQuery elements", ->
      expect(@div).to.respondTo "dummyPlugin"

    it "initializes the plugin", ->
      @div.dummyPlugin()
      expect(@div.html()).to.equal "<p>Hello World</p>"

    it "customizes the plugin options", ->
      @div.dummyPlugin(message: "I'm customized!")
      expect(@div.html()).to.equal "<p>I'm customized!</p>"

  describe "#bindEvents", ->
    class DummyPlugin extends $.PowerPlugin
      defaults:
        messageSelector: ".message"
      events:
        "submit": "submit"
        "change input": "changeInput"
      initialize: ->
        @message = @element.find(@options.messageSelector)
      submit: (e) ->
        e.preventDefault()
        @message.html("Submitting form...")
      changeInput: (e) ->
        e.preventDefault()
        $target = $(e.target)
        @message.html("Input changed to '#{$target.val()}'.")

    beforeEach ->
      @form = $("""
        <form>
          <input type="text">
          <div class="message"></div>
        </form>
      """)
      DummyPlugin.setup("dummyPlugin")
      @form.dummyPlugin()

    it "binds an event to the main element", ->
      @form.submit()
      expect(
        @form.find(".message").text()
      ).to.equal "Submitting form..."

    it "binds an event to a child element", ->
      @form.find("input").val("dude").change()
      expect(
        @form.find(".message").text()
      ).to.equal "Input changed to 'dude'."
