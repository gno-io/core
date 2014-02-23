@Migrations = new Meteor.Collection('migrations');

Migrations.add = (name,func) ->
	console.log '\n\n\n\n\n\n--------------'
	console.log Migrations.findOne({name:name})
	if Migrations.findOne({name: name}).count() == 0
		Migrations.insert 
			name: name
		func()