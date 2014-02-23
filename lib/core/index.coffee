# Functions for indexes

# (Many of these are probably better off being abstracted..)

# adds to an index's list of elements
# param indexId is id of index to add to
# param id is id of element to add
Gno.in.addHandle = (indexId, id) ->
	# TODO add mode to determine whether it gets added to top or bottom, or in alpha-order, etc..
	this.update indexId, 
		$addToSet: 
			h: id

# adds to an index's list of indexes
Gno.in.addIndex = (indexId, id) ->
	this.update indexId,
		$addToSet:
			i: id

# sets the index 
# param arr is an array of element ids
Gno.in.setHandles = (indexId, arr) ->
	this.update indexId,
		$set:
			h: arr
			
Gno.in.setIndexes = (indexId, arr) ->
	this.update indexId,
		$set:
			i: arr
			
# returns an array in which every item in arr has been put in an object with 
# type field set to param type
#
# optionally can be filtered
#
# ex. addType('co',[i]) --returns--> [ { type:'co', id:i } ]
# Gno.in.addType = (type, idArr, filter=true) ->
#	{ type: type, id: id } for id in idArr when filter

