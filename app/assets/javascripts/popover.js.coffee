$(document).on 'turbolinks:load', ->

  $popoverLink = $('[data-popover]')
  $document = $(document)

  init = ->
    $popoverLink.on 'click', openPopover
    $document.on 'click', closePopover

  openPopover = (e) ->
    e.preventDefault()
    closePopover()
    popover = $($(this).data('popover'))
    popover.toggleClass 'open'
    e.stopImmediatePropagation()

  closePopover = (e) ->
    if $('.popover.open').length > 0
      $('.popover').removeClass 'open'

  init()
