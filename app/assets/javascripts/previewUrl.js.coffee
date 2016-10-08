$(document).on 'input', '.url-for-preview', (e) ->
  if window.ajax
    window.ajax.abort()
  clearTimeout window.timer
  window.timer = setTimeout((->
    window.ajax = $.ajax(
      url: '/links/load_preview'
      type: 'GET'
      data:
        url: $(e.target).val()
      beforeSend: ->
        $('.button.submit-link').prop('disabled', true)
    ).success (data) ->
      if (data['status'] == 'fail')
        $('.button.submit-link').prop('disabled', false)
      else
        $('.url-for-preview').blur()
  ), 500)
