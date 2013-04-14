class $$.ApplicationView extends Backbone.View
  el: 'body'
  
  keys:
    'return esc': 'onKeyPress'
  
  onKeyPress: (event, name) =>
    @trigger("keypress-#{name}", event, name)
