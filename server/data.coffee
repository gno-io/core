
# Takes an object of format:
#	co: [ ids ]
#	pu: [ ids ]
#	au: [ ids ]
#	...
# and publishes the objects with those ids from those collections.
Meteor.publish 'itemData', (items) ->
	r = {}
	for k, arr of items
		if arr.length > 0
			r[k] = Gno.getSome k,
				_id:
					$in: arr
		else
			r[k] = Gno.get k, _id:0 # return empty cursor

Meteor.publish 'handleData', (handles) ->
	if handles.length > 0
		Gno.getSome 'handles',
			_id: 
				$in: handles
	else
		Gno.get 'handle', _id:0
			
Meteor.publish 'indexData', (params) ->
	Gno.getSome 'indexes', params
		
	