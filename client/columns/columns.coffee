Handlebars.registerHelper 'renderColumns', () ->		
	if Meteor.user()
		cols = Gno.in.retrieveColumn col for col in Meteor.user().view
		console.log cols
		Template.columns (if cols and cols.length then cols else [cols])

Template.column.events
	'click .gno-column-head': () ->
		$('#gno-content').removeClass 'opened' 
		
Template.columns.rendered = () ->
	$currentColumn = $('.gno-column').first() # will probably want to base this on user history
	$currentColumn.addClass 'current-column'
	Session.set 'currentIndex', $currentColumn.attr 'id'
	
		
Gno.in.retrieveColumn = (indexId) ->
	
	index = Gno.get 'index',
		_id:indexId
	.fetch()
	
	#console.log index
	
	if index.length > 0
		Gno.in.retrieve index[0]
	
			