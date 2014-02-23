# The migrations that are central to all others

@migrationVars = {}

# see if we can find any of the crucial vars
m = Gno.in.findOne { title: 'Gno Default', public: yes }
migrationVars.defaultModeId = if m then m._id else null

Meteor.startup () ->
	#Migrations.add 'settings-1', () ->
	if Gno.get('index', t:'Settings').count() == 0
		migrationVars.defaultModeId = Gno.add 'index',
			title: 'Settings'
			collection: 'se'
			handles: []
			indexes: []

		
			
	