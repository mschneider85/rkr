$(document).on 'turbolinks:load', ->
  $('.tag-list-input').each (index, taglist) ->
    $(this).tagit
      removeConfirmation: true
      caseSensitive: false
      fieldName: $(taglist).attr('name') + '[]'
      autocomplete:
        source: (search, showChoices) ->
          that = this
          if ajaxTags && ajaxTags.readyState != 4
            ajaxTags.abort()
          ajaxTags = $.ajax
            url: '/tags'
            data: query: search.term
            success: (choices) ->
              showChoices that._subtractArray(choices, that.assignedTags())
        delay: 300
        minLength: 2
        select: (event, ui) ->
          window.location.href = ui.item.value

$(document).on 'focus', 'input[type="text"].ui-widget-content.ui-autocomplete-input', ->
  $(this).closest('.tag-list-input').addClass('focused')

$(document).on 'blur', 'input[type="text"].ui-widget-content.ui-autocomplete-input', ->
  $(this).closest('.tag-list-input').removeClass('focused')
