class $$.ApplicationView extends Backbone.View
  el: 'body'
  
  keys:
    'return esc left right up down': 'onKeyPress'
    'f+alt': 'onAltKeyPress'
  
  onKeyPress: (event, name) =>
    @trigger("keypress-#{name}", event, name)
  
  onAltKeyPress: (event, name) =>
    @onKeyPress(event, "alt+#{name}")
