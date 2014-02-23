Handlebars.registerHelper 'renderIndex', (index) ->		
	Template.index Gno.in.retrieve index
	
Template.index.events
	'click .gno-index-head': (event) ->
		$body = $(event.currentTarget).next()
		$body.toggleClass('opened').slideToggle()
		event.stopImmediatePropogation()
		
Gno.in.open = ($indexBody) ->
	true

# Retrieves all data necessary to render an index, and 
# adds newly 'shallow' elements (elements the user may
# soon click on) to the Session variable
Gno.in.retrieve = (index) ->

	Gno.in.addHandlesToSession [index]
	
	handles = 
		if index.h.length > 0
			Gno.getSome 'handles',
				_id: 
					$in: index.h

		else 
			Gno.get 'happy', _id:0
	
	# TODO - possible place to optimize by choosing items more selectively
	Gno.in.addItemsToSession index.c, handles.fetch()
	
	indexes = 
		if index.i.length > 0
			Gno.getSome 'indexes',
				_id: 
					$in: index.i	
		else
			Gno.get 'happy', _id:0

	Gno.in.addHandlesToSession indexes.fetch()
	
	return {
		title: index.t
		handles: handles
		indexes: indexes
	}
		
	
# Takes a two character collection designation (eg, 'co' for compostion)
# and an array of handles, then adds the items pointed to by those handles 
# to the 'items' Session variable (so that we subscribe to them)
Gno.in.addItemsToSession = (collection, handles) ->
	items = Session.get 'items'
	items[collection] = _.union items[collection], h.i for h in handles
	Session.set 'items', items
		
# Takes an array of indexes and adds all of the handles they point to 
# to our 'handles' Session variable (so that we subscribe to them)
Gno.in.addHandlesToSession = (indexes) ->
	arr = []
	arr = arr.concat i.h for i in indexes
	Session.set 'handles', _.union Session.get('handles'), arr
	#console.log Session.get 'handles'
		