class ContentView extends Backbone.Form
  memoEvents: =>
    'keydown': @onKeyDown
    'keyup': @onKeyUp
  
  initialize: (options) ->
    super(options)
  
  render: =>
    @template = _.template $$.render('widget/memo/base', @options)
    super()
    @fields.memo.delegateEvents(@memoEvents())
    @$el.hide().css(@options.offset).appendTo('body')
  
  show: =>
    return if @isShow
    @isShow = true
    @render()
    @fields.memo.setValue(@options.target.val())
    @$el.stop().fadeIn 100, => @fields.memo.editor.$el.focus()
  
  hide: =>
    return unless @isShow
    @isShow = false
    @$el.stop().fadeOut 100, => @remove()
  
  toggle: =>
    if @isShow then @hide() else @show()
  
  onKeyDown: (ev) =>
    ev.preventDefault() if ev.altKey
    @content
  
  onKeyUp: (ev) =>
    @options.target.val(@fields.memo.getValue())
  
  schema:
    memo: 'TextArea'


class $$.Widget.MemoView extends Backbone.View
  events:
    'click': 'toggle'
  
  applicationEvents: =>
    'keypress-alt+m': @toggle
    'keypress-esc': @hide
  
  initialize: (options) ->
    super(options)
    offset = @$el.offset()
    offset.top += @$el.outerHeight()
    @content = new ContentView(offset: offset, target: @$('input'))
    $$.listenTo(@, $$.app, @applicationEvents)
  
  show: =>
    @content.show()
  
  hide: =>
    @content.hide()
  
  toggle: =>
    @content.toggle()
