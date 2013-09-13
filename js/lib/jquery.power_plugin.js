// Generated by CoffeeScript 1.3.3
(function() {
  var $,
    __slice = [].slice;

  $ = jQuery;

  $.PowerPlugin = (function() {

    PowerPlugin.prototype.defaults = {};

    PowerPlugin.prototype.events = {};

    PowerPlugin.setup = function(name) {
      var that;
      that = this;
      this.pluginName = name;
      return $.fn[this.pluginName] = function(options) {
        var plugin;
        plugin = that.getInstance(this, options);
        plugin.bindEvents();
        return this;
      };
    };

    PowerPlugin.getInstance = function(element, options) {
      var $element, data;
      $element = $(element);
      data = $element.data(this.pluginName);
      if (!data) {
        data = new this($element, options);
        $element.data(this.pluginName, data);
      }
      return data;
    };

    function PowerPlugin(element, options) {
      if (options == null) {
        options = {};
      }
      this.element = this.el = $(element);
      this.setOptions(options);
      this.initialize();
    }

    PowerPlugin.prototype.setOptions = function(options) {
      return this.options = $.extend(true, {}, this.defaults, options);
    };

    PowerPlugin.prototype.initialize = function() {};

    PowerPlugin.prototype.bindEvents = function() {
      var callback, event, _ref, _results;
      _ref = this.events;
      _results = [];
      for (event in _ref) {
        callback = _ref[event];
        _results.push(this.bindEvent(event, callback));
      }
      return _results;
    };

    PowerPlugin.prototype.bindEvent = function(event, callback) {
      var keys, selector, trigger;
      keys = event.split(" ");
      trigger = keys.shift();
      selector = keys.join(" ");
      if (selector) {
        return $(this.element).on(trigger, selector, this.eventCallback(callback));
      } else {
        return $(this.element).on(trigger, this.eventCallback(callback));
      }
    };

    PowerPlugin.prototype.eventCallback = function(callback) {
      var that;
      that = this;
      return function() {
        var args;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return that[callback].apply(that, args);
      };
    };

    return PowerPlugin;

  })();

}).call(this);
