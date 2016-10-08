$(document).on 'turbolinks:load', ->
  $('.code').not(':has(.CodeMirror)').each ->
    $this = $(this)
    $mode = $(this).data('mode')
    $code = $this.html()
    $unescaped = $('<div/>').html($code).text()
    $this.empty()
    CodeMirror this,
      value: $unescaped
      theme: 'mdn-like'
      mode: $mode
      lineNumbers: !$this.is('.inline')
      readOnly: true
