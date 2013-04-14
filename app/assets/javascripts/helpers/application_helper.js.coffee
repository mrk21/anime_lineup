//= require_self
//= require_tree .

$$.ApplicationHelper = 
  formTag: (url, method, content) ->
    method = method.toLowerCase()
    httpMethod = switch method
      when 'delete','put' then 'post'
      else method
    $('<div>').append(
      $('<form>').attr(action: url, method: httpMethod)
        .append($('<input>').attr(type: 'hidden', name: '_method', value: method))
        .append(content())
    ).html()
