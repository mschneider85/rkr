$(document).on 'turbolinks:load', ->
  hljs.registerLanguage 'no-highlightning', (hljs) ->
    case_insensitive: true
    keywords: ''
    contains: []
  $('pre code').each (i, block) ->
    hljs.highlightBlock block
