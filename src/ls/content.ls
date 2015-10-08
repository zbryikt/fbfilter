# global variable 'config' loaded by watcher

eventhub = do
  handlers: {}
  listen: (name, handle) ->
    @handlers[][name].push handle
    if @init => @init!
  trigger: (name, value) -> for item in (@handlers[name] or []) => item(value)
  init: ->
    @init = null
    (req, sender, res) <~ chrome.runtime.onMessage.addListener
    if !@handlers[req.type] => return
    for handler in @handlers[req.type] => handler req, sender, res

activeFilter = ->
  list = document.querySelectorAll(".userContentWrapper")
  for item in list
    result = /gogoro/ig.exec(item.innerText)
    if result => item.parentNode.removeChild(item)

setTimeout activeFilter, 5000
activeFilter!
