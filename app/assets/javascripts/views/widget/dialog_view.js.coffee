class $$.Widget.DialogView extends Backbone.View
  events:
    'click .dialog.overlay': 'hide'
  
  applicationEvents: =>
    'keypress-esc': @hide
  
  initialize: (options) ->
    super(options)
    @options.yield ||= (->)
    @options.renderWith ||= ((v,c)->c)
  
  render: ->
    @setElement @options.renderWith(@, $$.render('widget/dialog/show', @options))
  
  show: =>
    return if @isShow
    @isShow = true
    @render().$el.hide().appendTo('body').fadeIn(100, => @trigger('show',@))
    $$.listenTo(@, $$.app, @applicationEvents)
  
  hide: =>
    return unless @isShow
    @isShow = false
    @$el.fadeOut(100, => @.remove().trigger('hide',@))
