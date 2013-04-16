class $$.ApplicationView extends Backbone.View
  el: 'body'
  
  keys:
    'return esc': 'onKeyPress'
    'f+alt left+alt right+alt space+alt': 'onAltKeyPress'
  
  onKeyPress: (event, name) =>
    @trigger("keypress-#{name}", event, name)
  
  onAltKeyPress: (event, name) =>
    @onKeyPress(event, "alt+#{name}")
