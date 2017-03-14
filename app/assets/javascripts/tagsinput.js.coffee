$(document).on 'turbolinks:load', ->
  $('.tag-list-input').each (index, taglist) ->
    $(this).tagit
      removeConfirmation: true
      caseSensitive: false
      allowSpaces: true
      fieldName: $(taglist).attr('name') + '[]'
      onTagExists: (func, callback) ->
        $(callback.existingTag).animateCss('bounceIn')
      autocomplete:
        source: (search, showChoices) ->
          that = this
          if window.xhr && window.xhr.readyState != 4
            window.xhr.abort()
          window.xhr = $.ajax
            url: '/tags'
            data:
              query: search.term
              assigned_tags: that.assignedTags()
            success: (choices) ->
              showChoices that._subtractArray(choices, that.assignedTags())
        delay: 0
        minLength: 2

$(document).on 'focus', 'input[type="text"].ui-widget-content.ui-autocomplete-input', ->
  $(this).closest('.tag-list-input').addClass('focused')

$(document).on 'blur', 'input[type="text"].ui-widget-content.ui-autocomplete-input', ->
  $(this).closest('.tag-list-input').removeClass('focused')
