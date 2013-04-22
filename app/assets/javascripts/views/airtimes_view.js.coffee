class NewFromView extends Backbone.Form
  events:
    'click button': 'onSubmit'
  
  dialogEvents: =>
    show: @onShowDialog
    hide: @onHideDialog
  
  applicationEvents: =>
    'keypress-return': @onReturnKey
  
  initialize: (options) ->
    super(options)
    $$.listenTo(@, $$.app, @applicationEvents)
    $$.listenTo(@, @options.dialog, @dialogEvents)
  
  onShowDialog: =>
    @fields.day.editor.focus()
  
  onHideDialog: =>
    @remove()
  
  onReturnKey: (event,name) =>
    @onSubmit(event) if @$(event.target).filter(':input').size()
  
  onSubmit: (event) =>
    return if @commit()
    @model.set_start_time()
    @options.dialog.hide()
    @trigger('submit', @)

class $$.AirtimesView extends Backbone.View
  events:
    'click .AirtimesView-new': 'new'
    'click .AirtimesView-edit': 'edit'
    'click .AirtimesView-delete-item': 'deleteItem'
  
  newFormEvents: =>
    'submit': @onSubmitNewForm
  
  initialize: ->
    super()
    @channels = new $$.ChannelsCollection(@$el.data('channels'))
    @newDialog = new $$.Widget.DialogView
      class: 'airtimes new'
      yield: @yieldNewDialog
      renderWith: @renderNewFrom
  
  new: =>
    @airtime = new $$.AirtimesModel()
    @airtime.channels = @channels
    @newDialog.show()
  
  edit: (event) =>
    if @isEdit
      @isEdit = false
      $('.anime.detail').removeClass('edit')
      @$el.removeClass('edit')
      @$('.list').removeClass('edit')
      $(event.target).text($(event.target).data('normal-label'))
    else
      @isEdit = true
      $('.anime.detail').addClass('edit')
      @$el.addClass('edit')
      @$('.list').addClass('edit')
      $(event.target).text($(event.target).data('deleting-label'))
  
  deleteItem: (event) =>
    input = $(event.target).find('input')
    item = $(event.target).closest('li')
    if item.hasClass('new')
      item.remove()
    else
      input.attr(value: 1)
      item.hide()
  
  renderNewFrom: (view, content) =>
    @newForm = new NewFromView(parent: @, dialog: view, model: @airtime, template: _.template(content))
    @newForm.render()
    $$.listenTo(@, @newForm, @newFormEvents)
    @newForm.el
  
  yieldNewDialog: (type) =>
    $$.render('airtimes/new', type: type)
  
  onSubmitNewForm: (view) =>
    list = @$('ul.list')
    divider = list.find("li.divider[data-day=#{@airtime.get('day')}]")
    items = @$('ul.list li.item')
    if divider.size() == 0
      list.append(
        $$.render('airtimes/new_item', airtime: @airtime, i: items.size(), withDivider: true)
      )
    else
      divider.after(
        $$.render('airtimes/new_item', airtime: @airtime, i: items.size())
      )
