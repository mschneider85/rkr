$(document).on 'turbolinks:load', ->
  if $('.snippet-editor').length
    editor = CodeMirror.fromTextArea $('.edit-code').get(0),
      lineNumbers: true
      lineWrapping: true
      styleActiveLine: true
      matchBrackets: true
      autoCloseBrackets: true
      selectionPointer: true
      viewportMargin: Infinity
      tabSize: 2
      mode: 'ruby'
      theme: 'mdn-like'
    charWidth = editor.defaultCharWidth()
    basePadding = 2
    editor.on 'renderLine', (cm, line, elt) ->
      offset = CodeMirror.countColumn(line.text, null, cm.getOption('tabSize')) * charWidth
      elt.style.textIndent = '-' + offset + 'px'
      elt.style.paddingLeft = basePadding + offset + 'px'
    editor.refresh()

    $('.select-mode').change ->
      value = $(this).val()
      $.ajax(
        url: '/snippets/language_code'
        dataType: 'text'
        data:
          name: value
      ).success (data) ->
        console.info 'switched to "' + data + '" mode'
        editor.setOption 'mode', data
