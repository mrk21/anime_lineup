class $$.LineupsView extends Backbone.View
  applicationEvents: =>
    'keypress-alt+left': @onKeyPressPrevDay
    'keypress-alt+right': @onKeyPressNextDay
    'keypress-alt+space': @onKeyPressToday
  
  initialize: ->
    super()
    $$.listenTo(@, $$.app, @applicationEvents)
  
  onKeyPressPrevDay: (ev) =>
    ev.preventDefault();
    @moveDay(-1)
    false
  
  onKeyPressNextDay: (ev) =>
    ev.preventDefault();
    @moveDay(1)
    fales
  
  onKeyPressToday: (ev) =>
    ev.preventDefault();
    @moveToday()
    fales
  
  moveToday: ->
    location.href = "/today_lineup"
  
  moveDay: (distance) ->
    size = $$.AirtimesModel.dayNames().length
    day = @$el.data('day') + distance
    day += size
    day = day % size
    targetDay = $$.AirtimesModel.dayNames(day)
    location.href = "/lineups/#{targetDay}"
