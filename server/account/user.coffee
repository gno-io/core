Meteor.publish 'userView', () ->
	Meteor.users.find this.userId,
		fields:
			'view': 1
			# 'mode': 1

Accounts.onCreateUser (opts, user) ->
	console.log 'creating user'
	
		
	# user.mode = Gno.get 'mode',
	# 	title: 'Gno Default'
	#	public: yes
		
	###
	view.modes.push 
		id: user.mode._id
		opened: []	
	###
	
	sId = Gno.add 'index',
		title: 'Styles'
		collection: 'st' #styles
		h: []
		i: []
		author: 
			i: user._id
	
	template = Gno.get 'handle',
		t: 'Gno Simple'
	.fetch()[0]._id
	
	console.log template
	
	tId = Gno.add 'index',
		title: 'Templates'
		collection: 'te' #templates
		handles: [ template ]
		indexes: []
		author: 
			i: user._id
	
	page = Gno.addItem 'composition', user,
		title: 'Blank Page'
		brief: 'A fresh page, our treat.'
		content:
			s: template
			a: 
				i: user._id

	
	cId = Gno.add 'index',
		title: 'Compositions'
		brief: 'Writings, etc.'
		collection: 'co' #compositions
		handles: [ page ]
		indexes: [ tId, sId ]
		author: 
			i: user._id
		
	pId = Gno.add 'index',
		title: 'Findings'
		collection: 'pu' #publications
		author: 
			i: user._id
		handles: []			
		indexes: []
		
	fIds = Gno.addItems 'feed', user, [
			title: 'Gno'
			brief: 'Updates and tutorials from Gno'
			content:
				source: 'gno'
		,
			title: 'Marked'
			brief: 'Content you\'ve marked'
			content:
				source: 'marks'
		,
			title: 'History'
			brief: 'Content you\'ve opened'		
			content:
				source: 'history'
		]
	fId = Gno.add 'index',
		title: 'Feeds'
		collection: 'fe' #feeds
		handles: fIds
		i: []
		a:
			i: user._id
	
	vId = Gno.add 'index', # top level index
		title: 'Original'
		collection: 'in' #indexes
		indexes: [ cId, pId, fId ]
		handles: []
		author:
			i: user._id
	
	user.view = [ vId ]
	return user
			
	