class $$.Widget.ListView extends Backbone.View
  initialize: ->
    super()
    @el.scrollTop = @$('li.current')[0].offsetTop
  
  currentItem: ->
    @$('li.current').data()

