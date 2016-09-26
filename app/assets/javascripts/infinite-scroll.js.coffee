document.addEventListener 'turbolinks:load', ->
  if $('.pagination').length
    $(window).scroll ->
      url = undefined
      url = $('.pagination a').attr('href')
      if url and $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text 'Fetching more snippets...'
        return $.getScript(url)
    return $(window).scroll()
