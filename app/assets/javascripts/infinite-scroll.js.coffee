document.addEventListener 'turbolinks:load', ->
  if $('.pagination').length
    fetching_more = $('.pagination').data('title') || 'Fetching more entries...'
    $(window).scroll ->
      url = undefined
      url = $('.pagination a').attr('href')
      if url and $(window).scrollTop() > $(document).height() - $(window).height() - 200
        $('.pagination').text fetching_more
        return $.getScript(url)
    return $(window).scroll()
