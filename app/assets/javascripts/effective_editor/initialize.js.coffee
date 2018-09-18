# https://quilljs.com/docs/download/
# https://github.com/quilljs/quill
(this.EffectiveBootstrap || {}).effective_editor = ($element, options) ->
  editor = '#' + $element.attr('id') + '_editor'

  content_mode = options['content_mode']
  delete options['content_mode']

  quill = new Quill(editor, options)
  content = $element.val() || ''

  if content.length > 0
    if content.startsWith('{')
      quill.setContents(JSON.parse(content))
    else if content_mode == 'code'
      quill.setText(content)
    else if content.startsWith('<')
      quill.pasteHTML(content)
    else
      quill.setText(content)

  if content_mode == 'code'
    quill.format('code-block', true)
    quill.on 'text-change', (delta, old, source) -> $element.val(quill.getText())

  if content_mode == 'delta'
    quill.on 'text-change', (delta, old, source) -> $element.val(JSON.stringify(quill.getContents()))

  if content_mode == 'html'
    quill.on 'text-change', (delta, old, source) ->
      html = $(editor).children('.ql-editor').html()
      html = '' if html == '<p><br></p>' || html == '<p></p>'
      $element.val(html)

  $element.on 'quill:focus', (event) -> quill.focus()

# This is the read only region. Always delta.
(this.EffectiveBootstrap || {}).effective_editor_tag = ($element, options) ->
  quill = new Quill('#' + $element.attr('id'), options)

  content = ($element.attr('data-content') || '')
  content_mode = $element.data('content-mode')

  if content.length > 0
    if content.startsWith('{')
      quill.setContents(JSON.parse(content))
    else if content_mode == 'code'
      quill.setText(content)
    else if content.startsWith('<')
      quill.pasteHTML(content)
    else
      quill.setText(content)

  if content_mode == 'code'
    quill.format('code-block', true)
