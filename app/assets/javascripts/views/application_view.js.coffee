class $$.ApplicationView extends Backbone.View
  el: 'body'
  
  keys:
    'return esc': 'onKeyPress'
    'left right up down': 'onKeyPress'
    
    'f+alt space+alt s+alt e+alt': 'onAltKeyPress'
    'left+alt right+alt': 'onAltKeyPress'
    '1+alt 2+alt 3+alt': 'onGlobalMenuKeyPress'
    
    '1+alt+shift 2+alt+shift 3+alt+shift': 'onAltShiftKey'
  
  onKeyPress: (ev,name,baseName) =>
    baseName ||= name
    @trigger("keypress-#{name}", ev, name, baseName)
  
  onAltKeyPress: (ev,name) =>
    return if ev.shiftKey
    @onKeyPress(ev, "alt+#{name}", name)
  
  onAltShiftKey: (ev,name) =>
    @onKeyPress(ev, "alt+shift+#{name}", name)
  
  onGlobalMenuKeyPress: (ev,name) =>
    return if ev.shiftKey
    @$('header.page nav.main li a').get(name-1).click()
