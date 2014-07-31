getStringArray = ->
  editor = atom.workspace.activePaneItem
  selection = editor.getSelection()
  text = selection.getText()
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

module.exports =
  activate: (state) ->
    atom.workspaceView.command "atom-text-transformer:upper", => @upper()
    atom.workspaceView.command "atom-text-transformer:lower", => @lower()
    atom.workspaceView.command "atom-text-transformer:reverse", => @reverse()
    atom.workspaceView.command "atom-text-transformer:camel", => @camel()
    atom.workspaceView.command "atom-text-transformer:dashed", => @dashed()
    atom.workspaceView.command "atom-text-transformer:underline", => @underline()

  upper: ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    selection.insertText(selection.getText().toUpperCase(), {select: true})

  lower: ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    selection.insertText(selection.getText().toLowerCase(), {select: true})

  reverse: ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    text = selection.getText()
    str = []
    i = 0

    while i < text.length
      s = text.charAt(i)
      str.push (if s.toLowerCase() is s then s.toUpperCase() else s.toLowerCase())
      i++

    selection.insertText(str.join(''), {select: true})

  camel: ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    text = getStringArray().join('-').replace /(\-[a-z])/g, (w) ->
      w.toUpperCase().replace /\-/, ""
    selection.insertText(text, {select: true})

  dashed: ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    selection.insertText(getStringArray().join('-'), {select: true})

  underline: ->
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    selection.insertText(getStringArray().join('_'), {select: true})
