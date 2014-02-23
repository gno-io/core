###
if document.addEventListener
	document.addEventListener 'contextmenu', (e) ->
		alert "You've tried to open context menu"
		e.preventDefault();
	, false
else
	document.attachEvent 'oncontextmenu', () ->
		alert "You've tried to open context menu"
		window.event.returnValue = false;
###