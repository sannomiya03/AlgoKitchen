Collection = require "./first_class/Collection.coffee"
Calc = require "./Calc.coffee"

module.exports = class Task
	@collection = new Collection()
	getType: -> return "Task"
	@collection.instanceConstructor = (source) -> return new Task source
	@basedHourlyWage = 1300
	@calc = 
		cost: (task) -> return Calc.taskCost(task)
		sumCost : (tasks) -> return Calc.sumTaskCost(tasks)

	constructor: (source) ->
		@source = if source? then source else null
		@title = ""
		@aveTime = 0
		@avePersons = 0
		@hourlyWage = Task.basedHourlyWage
		@calc = {}
		@_init()

	_init: ->
		@title = @source.title
		@aveTime = @source.aveTime
		@avePersons = @source.avePersons
		@hourlyWage = @source.hourlyWage if @source.hourlyWage?
		Task.collection.add this

	reset: ->
		console.log "reset"
		@_init()