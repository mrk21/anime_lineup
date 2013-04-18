class $$.Widget.ListView extends Backbone.View
  initialize: ->
    super()
    @el.scrollTop = @$('li.current')[0].offsetTop
  
  items: (expr = null) ->
    els = @$('> li')
    els = els.filter(expr) if expr
    els
  
  currentItem: ->
    @items('.current')

