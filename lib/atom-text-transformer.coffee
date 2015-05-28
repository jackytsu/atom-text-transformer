getStringArray = (text) ->
  str = []
  lastPos = 0
  i = 0
  while i < text.length
    if /[\s\-_A-Z]/.test(text.charAt(i))
      s = text.substring(lastPos, i).replace(/[\s\-_]/, "")
      if s.length > 0
        str.push s.toLowerCase()
      lastPos = i
    i++

  if lastPos < text.length
      s = text.substring(lastPos, i).replace(/[\s\-_]/, "")
      if s.length > 0
        str.push s.toLowerCase()
  return str

textTransform = (separator) ->
  editor = atom.workspace.getActivePaneItem()
  for selection in editor.getSelections()
    selection.insertText(getStringArray(selection.getText()).join(separator), {select: true})

module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor', "atom-text-transformer:upper", => @upper()
    atom.commands.add 'atom-text-editor', "atom-text-transformer:lower", => @lower()
    atom.commands.add 'atom-text-editor', "atom-text-transformer:reverse", => @reverse()
    atom.commands.add 'atom-text-editor', "atom-text-transformer:camel", => @camel()
    atom.commands.add 'atom-text-editor', "atom-text-transformer:dashed", => @dashed()
    atom.commands.add 'atom-text-editor', "atom-text-transformer:underline", => @underline()

  upper: ->
    editor = atom.workspace.getActivePaneItem()
    for selection in editor.getSelections()
      selection.insertText(selection.getText().toUpperCase(), {select: true})

  lower: ->
    editor = atom.workspace.getActivePaneItem()
    for selection in editor.getSelections()
      selection.insertText(selection.getText().toLowerCase(), {select: true})

  reverse: ->
    editor = atom.workspace.getActivePaneItem()
    for selection in editor.getSelections()
      text = selection.getText()
      str = []
      i = 0

      while i < text.length
        s = text.charAt(i)
        str.push (if s.toLowerCase() is s then s.toUpperCase() else s.toLowerCase())
        i++

      selection.insertText(str.join(''), {select: true})

  camel: ->
    editor = atom.workspace.getActivePaneItem()
    for selection in editor.getSelections()
      text = getStringArray(selection.getText()).join('-').replace /(\-[a-z])/g, (w) ->
        w.toUpperCase().replace /\-/, ""
      selection.insertText(text, {select: true})

  dashed: ->
    editor = atom.workspace.getActivePaneItem()
    textTransform('-')

  underline: ->
    editor = atom.workspace.getActivePaneItem()
    textTransform('_')
