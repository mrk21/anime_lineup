class $$.AirtimesModel extends Backbone.Model
  START_TIME_REGEXP = /^(\d{1,2}):(\d{1,2})$/
  DAY_LABELS = ['日','月','火','水','木','金','土']
  DAY_NAMES = ['sun','mon','tues','wed','thurs','fri','sat']
  
  @dayNames: (day) ->
    if _.isUndefined(day)
      DAY_NAMES
    else
      DAY_NAMES[day-0]
  
  @dayLables: (day) ->
    if _.isUndefined(day)
      DAY_LABELS
    else
      DAY_LABELS[day-0]
  
  dayName: ->
    @constructor.dayNames(@get('day'))
  
  dayLabel: ->
    @constructor.dayLables(@get('day'))
  
  channel: ->
    @channels.get(@get('channel_id'))
  
  formatted_start_time: ->
    start_time = @get('start_time')-0
    h = ('00'+parseInt(start_time/60)).substr(-2,2)
    m = ('00'+parseInt(start_time%60)).substr(-2,2)
    "#{h}:#{m}"
  
  set_start_time: ->
    @attributes.start_time_str ||= ''
    matches = @attributes.start_time_str.match(START_TIME_REGEXP)
    return unless matches
    delete @attributes.start_time_str
    @attributes.start_time = (matches[1]-0)*60 + (matches[2]-0)
  
  defaults:
    state: 1
    enable: 1
  
  schema: ->
    channel_id:
      type: 'Select'
      options: @channels.map (v) -> {val: v.id, label: v.get('name')}
    day:
      type: 'Select'
      options: _(@constructor.dayLables()).map (v,i) -> {val: i, label: v}
    start_time:
      type: 'Number'
    start_time_str:
      type: 'Text'
      validators: [
        'required'
        (value, formValues) ->
          error = {type: 'start_time', message: 'Invalid Format'}
          matches = value.match(START_TIME_REGEXP)
          return error unless matches
          return error if parseInt(matches[1]) < 0 || parseInt(matches[1]) > 28
          return error if parseInt(matches[2]) < 0 || parseInt(matches[2]) > 59
      ]
