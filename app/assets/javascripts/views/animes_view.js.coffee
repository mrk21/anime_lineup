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
    'keyup .AnimesView-search': 'onSearch'
  
  applicationEvents: =>
    'keypress-alt+f': @onEnableSearchKey
    'keypress-esc': @onDisableSearchKey
  
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
    $$.listenTo(@, $$.app, @applicationEvents)
  
  new: =>
    @anime = new $$.AnimesModel()
    @newDialog.show()
  
  delete: =>
    @anime = new $$.AnimesModel(@list.currentItem())
    @deleteDialog.show()
  
  onEnableSearchKey: =>
    @isEnableSearch = true
    @$el.addClass('search')
    setTimeout (=> @$('.AnimesView-search').focus()), 200
  
  onDisableSearchKey: =>
    return unless @isEnableSearch
    @isEnableSearch = false
    @$el.removeClass('search')
    @list.$('li').show()
  
  search: (word) ->
    word = StringNormalizer.exec word
    @list.$('li').each ->
      title = StringNormalizer.exec $(@).data('title')
      if title.search(word) < 0 then $(@).hide() else $(@).show()
  
  onSearch: (ev) =>
    word = $(ev.target).val()
    return if @activeSearchWord == word
    @activeSearchWord = word
    @search @activeSearchWord
  
  renderNewFrom: (view, content) =>
    @newForm = new NewFromView(dialog: view, model: @anime, template: _.template(content))
    @newForm.render()
    @newForm.el
  
  yieldNewDialog: (type) =>
    $$.render('animes/new', type: type)
  
  yieldDeleteDialog: (type) =>
    $$.render('animes/delete', anime: @anime, type: type)
