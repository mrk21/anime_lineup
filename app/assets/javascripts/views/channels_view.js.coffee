class NewFromView extends Backbone.Form
  events:
    'submit form': 'onSubmit'
  
  dialogEvents: =>
    show: @onShowDialog
    hide: @onHideDialog
  
  initialize: (options) ->
    super(options)
    _(@fields).each (f) -> f.editor.$el.attr 'name', "channel[#{f.editor.$el.attr('name')}]"
    $$.listenTo(@, @options.dialog, @dialogEvents)
  
  onShowDialog: =>
    @fields.name.editor.focus()
  
  onHideDialog: =>
    @remove()
  
  onSubmit: (event) =>
    event.preventDefault()
    event.target.submit() if !@commit()
    false

class $$.ChannelsView extends Backbone.View
  events:
    'click .ChannelsView-new': 'new'
    'click .ChannelsView-delete': 'delete'
  
  initialize: ->
    super()
    @list = new $$.Widget.ListView(el: @$('.list'))
    @newDialog = new $$.Widget.DialogView
      class: 'channels new'
      yield: @yieldNewDialog
      renderWith: @renderNewFrom
    @deleteDialog = new $$.Widget.DialogView
      class: 'channels delete'
      yield: @yieldDeleteDialog
  
  new: =>
    @channel = new $$.ChannelsModel()
    @newDialog.show()
  
  delete: =>
    @channel = new $$.ChannelsModel(@list.currentItem().data())
    @deleteDialog.show()
  
  renderNewFrom: (view, content) =>
    @newForm = new NewFromView(dialog: view, model: @channel, template: _.template(content))
    @newForm.render()
    @newForm.el
  
  yieldNewDialog: (type) =>
    $$.render('channels/new', type: type)
  
  yieldDeleteDialog: (type) =>
    $$.render('channels/delete', channel: @channel, type: type)
