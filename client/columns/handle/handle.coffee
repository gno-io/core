Template.handle.events
	'click a.gno-handle': (event) ->
		event.preventDefault()
		$handle = $(event.currentTarget)
		Gno.open $handle.attr('data-c'), $handle.attr('data-i')
	
Gno.ha.openLink = (href, dest="#gno-content") ->
	hrefSplit = href.split '/'
	Gno.open hrefSplit[1], hrefSplit[2], dest

Gno.ha.open = (handle, dest="#gno-content") ->
	Gno.open handle.c, handle.i, dest