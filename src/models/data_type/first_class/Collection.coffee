module.exports = class Collection
	constructor: ->
		@objects = []
		@sources = []
		@instanceConstructor = (source) -> return

	add: (object) ->
		if not @hasObject object
			@objects.push object
			@sources.push object.source

	new: (title) ->
		object = @getObject title
		if object? then return @instanceConstructor object.toSource()
		else return null

	newObjects: (objects=[]) ->
		if @objects.length is 0 then return objects
		for object in @objects
			objects.push @instanceConstructor object.toSource()
		return objects

	hasObject: (target) ->
		for object in @objects
			if object.title is target.title then return true
		return false

	getObject: (title) ->
		for object in @objects
			if object.title is title then return object
		return null

	updateObject: (target) ->
		for object, index in @objects
			if object.title is target.title then @objects[index] = target