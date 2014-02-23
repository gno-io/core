owns = (userId, el) ->
	el && el.a.i == userId
	
Meteor.users.allow
	update: (userId, user, fields, modifier) ->
		userId == user._id and fields.every (f) -> f in ['profile','view','mode']