class NewFromView extends Backbone.Form
  events:
    'submit form': 'onSubmit'
  
  dialogEvents: =>
    show: @onShowDialog
    hide: @onHideDialog
  
  initialize: (options) ->
    super(options)
    _(@fields).each (f) -> f.editor.$el.attr 'name', "anime[#{f.editor.$el.attr('name')}]"
    $$.listenTo(@, @options.dialog, @dialogEvents)
  
  onShowDialog: =>
    @fields.title.editor.focus()
  
  onHideDialog: =>
    @remove()
  
  onSubmit: (event) =>
    event.preventDefault()
    event.target.submit() if !@commit()
    false

class $$.AnimesView extends Backbone.View
  events:
    'click .AnimesView-new': 'new'
    'click .AnimesView-delete': 'delete'
  
  initialize: ->
    super()
    @list = new $$.Widget.ListView(el: @$('.list'))
    @newDialog = new $$.Widget.DialogView
      class: 'animes new'
      yield: @yieldNewDialog
      renderWith: @renderNewFrom
    @deleteDialog = new $$.Widget.DialogView
      class: 'animes delete'
      yield: @yieldDeleteDialog
  
  new: =>
    @anime = new $$.AnimesModel()
    @newDialog.show()
  
  delete: =>
    @anime = new $$.AnimesModel(@list.currentItem())
    @deleteDialog.show()
  
  renderNewFrom: (view, content) =>
    @newForm = new NewFromView(dialog: view, model: @anime, template: _.template(content))
    @newForm.render()
    @newForm.el
  
  yieldNewDialog: (type) =>
    $$.render('animes/new', type: type)
  
  yieldDeleteDialog: (type) =>
    $$.render('animes/delete', anime: @anime, type: type)
