###

Router.configure
	layoutTemplate: 'body'
	loadingTemplate: 'loading'
	before: () ->
		Session.set 'showContent', true
	, except: ['home']
	
Router.map () ->
	this.route 'home',
		path: '/'
		before: () ->
			Session.set 'showContent', false
		action: () ->
			this.render 'home', to: 'content'
		after: ()->
			$('#gno-content').removeClass 'opened'
	this.route 'composition', 
		path: '/co/:_id'
		data: () ->
			Gno.get 'composition', this.params._id
		action: () ->
			this.render 'composition', to: 'content'
		after: () ->
			alert 'hi' if $('#gno-container').length > 0
			$('#gno-content').addClass 'opened'
	
###