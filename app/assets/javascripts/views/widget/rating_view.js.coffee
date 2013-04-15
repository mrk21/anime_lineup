class $$.Widget.RatingView extends Backbone.View
  events:
    'click span': 'onClickItem'
    'mousemove .base': 'onMouseMove'
    'mouseleave .base': 'onMouseLeave'
  
  initialize: (options) ->
    super(options)
    @render()
  
  render: ->
    @$el.html('').html($$.render('widget/rating/base'))
    @items = @$('span')
    @input = @$('input').attr(name: @$el.data('name'))
    @set(@$el.data('value'), true)
    @undelegateEvents() if @options.readonly
  
  set: (value, isSet=false) ->
    @currentValue = value
    @input.val @currentValue if isSet
    @items.removeClass('active').each -> $(@).addClass('active') if $(@).data('index') <= value
  
  onMouseLeave: =>
    @set @input.val()
  
  onMouseMove: (ev) =>
    @set $(ev.target).data('index')
  
  onClickItem: =>
    @input.val @currentValue
