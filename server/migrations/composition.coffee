
Meteor.startup () ->
	# Migrations.add 'composition-1', () ->
	if Gno.get('template', t:'Gno Simple').count() == 0
		t_id = Gno.addItem 'template', null,
			title: 'Gno Simple'
			brief: 'Just add markdown.'
			author:
				i:0 # signifies Gno
			content:
				title: 'Simple' # in displaying data, content title will override element title
				published: yes
				structure: 
					md: 'Content' # md stands for markdown	
		ids = Gno.addItems 'setting', null, [
				title: 'Autosave'
				breif: 'Enable autosave for your compositions.'
				content:
					choice: 'bool'
					value: yes
			,
				title: 'Default Template'
				brief: 'Select which template to use when opening a new composition.'
				content:
					choice: 'select template'
					value: t_id
		]
		id = Gno.add 'index',
			title: 'Composition Settings'
			collection: 'se'
			handles: ids
			indexes: []
			
		# add these settings to the default mode
		Gno.in.addIndex migrationVars.defaultModeId, id
		
			
