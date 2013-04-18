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
    'mouseenter .list li': 'onSelect'
  
  applicationEvents: =>
    'keypress-alt+f': @onEnableSearchKey
    'keypress-esc': @onDisableSearchKey
    'keypress-up': @onKeyUp
    'keypress-down': @onKeyDown
    'keypress-alt+space': @onFetch
  
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
    @active = @list.currentItem()
  
  new: =>
    @anime = new $$.AnimesModel()
    @newDialog.show()
  
  delete: =>
    @anime = new $$.AnimesModel(@list.currentItem().data())
    @deleteDialog.show()
  
  onEnableSearchKey: =>
    @isEnableSearch = true
    @$el.addClass('search')
    setTimeout (=> @$('.AnimesView-search').focus()), 200
  
  onDisableSearchKey: =>
    @isEnableSearch = false
    @$el.removeClass('search')
    @list.items().removeClass('no-match')
    @select()
  
  search: (word) ->
    word = StringNormalizer.exec word
    @list.items().each ->
      title = StringNormalizer.exec $(@).data('title')
      if title.search(word) < 0 then $(@).addClass('no-match') else $(@).removeClass('no-match')
  
  onSearch: (ev) =>
    word = $(ev.target).val()
    return if @activeSearchWord == word
    @activeSearchWord = word
    @search @activeSearchWord
    return unless @activeSearchWord
    @select ':not(.no-match):eq(0)'
    @list.el.scrollTop = @active[0].offsetTop
  
  select: (expr = null) ->
    @list.items().removeClass('active')
    if expr
      element = @list.items(expr).eq(0)
      element.addClass('active')
      @active = element 
      @active = @list.items(':first') if @active.size() == 0
    else
      @active = $()
  
  onSelect: (ev) =>
    @select $(ev.target).closest('li')
  
  onKeyUp: (ev) =>
    ev.preventDefault()
    to = @active
    to = to.prevAll('li:not(.no-match)').eq(0) if to
    to = @list.items(':not(.no-match)').eq(-1) if $(to).size() == 0
    @select to
    @list.el.scrollTop = @active[0].offsetTop
    false
  
  onKeyDown: (ev) =>
    ev.preventDefault()
    to = @active
    to = to.nextAll('li:not(.no-match)').eq(0) if to
    to = @list.items(':not(.no-match)').eq(0) if $(to).size() == 0
    @select to
    @list.el.scrollTop = @active[0].offsetTop
    false
  
  onFetch: (ev) =>
    ev.preventDefault()
    location.href = @active.find('a')[0].href if @active
    false
  
  renderNewFrom: (view, content) =>
    @newForm = new NewFromView(dialog: view, model: @anime, template: _.template(content))
    @newForm.render()
    @newForm.el
  
  yieldNewDialog: (type) =>
    $$.render('animes/new', type: type)
  
  yieldDeleteDialog: (type) =>
    $$.render('animes/delete', anime: @anime, type: type)
