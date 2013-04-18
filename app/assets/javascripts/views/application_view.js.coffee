class $$.ApplicationView extends Backbone.View
  el: 'body'
  
  keys:
    'return esc left right up down': 'onKeyPress'
    'f+alt left+alt right+alt space+alt s+alt': 'onAltKeyPress'
    '1+alt 2+alt 3+alt': 'onGlobalMenuKeyPress'
  
  onKeyPress: (ev,name) =>
    @trigger("keypress-#{name}", ev,name)
  
  onAltKeyPress: (ev,name) =>
    @onKeyPress(ev, "alt+#{name}")
  
  onGlobalMenuKeyPress: (ev,name) =>
    @$('header.page nav.main li a').get(name-1).click()
