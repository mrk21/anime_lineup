class $$.ChannelsModel extends Backbone.Model
  schema:
    name: {type: 'Text', validators: ['required']}

class $$.ChannelsCollection extends Backbone.Collection
  model: $$.ChannelsModel
