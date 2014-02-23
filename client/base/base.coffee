Handlebars.registerHelper 'showContent',
	Session.get 'showContent'
	
Gno.open = (collection, id, dest="#gno-content") ->
	item = Gno.get collection, _id: id
	fragment = Meteor.render () ->
		Gno[collection].render item
	$(dest).html(fragment).addClass 'opened'
	
Meteor.startup () ->
	#	Hooks.init()
	#Session.set 'showContent', true
	# elements keeps track of all the elements we should have cached
	Session.set 'handles', []
	Session.set 'items',
		co: []
		pu: []
		se: []
		fe: []
		au: []	
			
	Deps.autorun () ->
		Meteor.subscribe 'handleData', Session.get 'handles'
	Deps.autorun () ->
		Meteor.subscribe 'itemData', Session.get 'items'
	Deps.autorun () ->
		Meteor.subscribe 'indexData',
				a: #author
					i: Meteor.userId()
				
	leftCol = Meteor.render () ->
		Template['left-column']()
		
	mainCols = Meteor.render () -> 
		if Meteor.userId() and Meteor.user().view
			cols = Gno.in.retrieveColumn col for col in Meteor.user().view
			Template.columns (if cols and cols.length then cols else [cols])	
		else
			Template.loading()
	
	$('#gno-left-column').html leftCol
	$('#gno-columns').html mainCols