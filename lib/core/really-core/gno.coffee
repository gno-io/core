###
Holds all of Gno's basic collections and implements standard functions for those collections.

All of Gno's data is accessed through indexes and handles. Everything refered to by a handle is called
an 'item'.

In both of these types of objects, one letter keys have been used to optimize space in the mongodb. 
Below, formats are expressed as:
	k(ey): description of value
where the parenteticals are omitted in the actual database.

An index is of format:
	t(itle): 		the Title of this index
	c(ollection): 	a two character specification of a Collection
	h(andles): 	array of ids of Handles, belonging to collection c
	i(ndexes):		array of ids of other Indexes

A handle is of the format:
	t(itle): 	the Title of this handle
	b(rief): 	Brief description of the content
	c(ollection): 	a two character specification of a Collection
	a(uthor): 
		i(d): 	the Id of the author
		n(ame): the Name of the author
	i(d): 		an Id pointing to a item in some collection, specified by c
	
The general process of data access is as follows.

When the user logs in, a view is retrieved, which has the following format:
	i(ndexes): an array of Index ids, which correspond to the indexes that are displayed across the top
		to the user
	o(pened): an array of index ids, identifying which have been left Open by the user

First, all of the top indexes are retrieved
, and their immediate contents are rendered.

Next, we step through the array of opened indexes, and call Gno.in.open() on each one. This
function renders handles we have already retrieved, retrieves content for those handles, 
and retrives data for any child indexes.

There are several Session variables which help us manage our subscriptions:

history: a queue which keeps track of the last publications opened, so the user can quickly 
	jump between them
handles: an array with the ids of the handles the user currently sees, and handles that the
	user saw recently

* "currently sees" technically means, "are children of opened indexes"

In theory, this setup means that by the time any user could click on something, the data for it is
already cached and waiting.
	
###

# these correspond to two letter character codes found in index objects' c(ollection) field
@Gno = 
	co: new Meteor.Collection 'compositions'
	pu: new Meteor.Collection 'publications'
	te: new Meteor.Collection 'templates'	
	se: new Meteor.Collection 'settings'
	ha: new Meteor.Collection 'handles'
	au: new Meteor.Collection 'authors'
	in: new Meteor.Collection 'indexes'
	st:	new Meteor.Collection 'styles'
	vi: new Meteor.Collection 'views'
	fe: new Meteor.Collection 'feeds'
	# mo: new Meteor.Collection 'modes'
	
	# adds item to collection and generates an handle that points to it
	add: (collection, item) ->
		# this[collection[0..1]].insert item
		this[collection[0..1]].insert this.cleanse item

	addSome: (collection, elArray) ->
		ids = for el in elArray
			this.add(collection, el)
	
	# adds item to collection and generates an handle that points to it
	addItem: (collection, user, item) ->
		id = Gno.add collection, item.content
		return this.ha.insert
			t: item.title
			b: if item.brief then item.brief else ''
			c: collection[0..1]
			a:
				i: if user then user._id else 0
				# n: user.fullname - TODO ensure every user has name
			i: id
			
	addItems: (collection, user, items) ->
		ids = this.addItem collection, user, i for i in items
	
	getSome: (collection, params) ->
		#this[collection[0..1]].find this.cleanse params
		this[collection[0..1]].find params
		
	get: (collection, params) ->
		#this[collection[0..1]].findOne this.cleanse params
		this[collection[0..1]].find params

	# retrieve the content pointed to by a handle h
	getContent: (h) ->
		this[h.c].findOne h.i
	
	# returns an object with keys reduced to their first letter
	# TODO: make sure it doesn't affect _id or strings
	cleanse: (params) ->
		r = {}
		for key, val of params
			k = key[0]
			r[k] = val
		r
			
			
	