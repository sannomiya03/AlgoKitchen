module.exports = class Calc
	# Estimate
	@totalPaperCost: (ordersheet, sum=0) ->
		return @sumRecipePaperCost(ordersheet.recipes.body, "body", ordersheet) + @sumRecipePaperCost(ordersheet.recipes.body, "lid", ordersheet)

	@totalTaskCost: (ordersheet) ->
		if !ordersheet.recipes?.body? then return 0
		return @sumTaskCost(ordersheet.recipes.body?.flow?.tasks) + @sumTaskCost(ordersheet.recipes.lid?.flow?.tasks)

	@prepateCost: (ordersheet) ->
		return @totalTaskCost(ordersheet) * ordersheet.params.prepareCostRate / 100

	@totalCost: (ordersheet) ->
		return @totalPaperCost(ordersheet) + @totalTaskCost(ordersheet) + @sumOptionCost(ordersheet.options) + @prepateCost(ordersheet) + ordersheet.params.equipmentCost

	@price: (ordersheet) ->
		return @totalCost(ordersheet) / (1-ordersheet.params.rate/100) * @discountRate(ordersheet.params.lots)

	@totalPrice: (ordersheet) ->
		return @price(ordersheet) * ordersheet.params.lots

	@discountRate: (lots) ->
		if lots <= 10 then return 2.0
		if lots <= 30 then return 1.8
		if lots <= 50 then return 1.2
		if lots <= 100 then return 1.0
		if lots <= 500 then return 0.95
		if lots <= 1000 then return 0.9
		return 1.0

	# Task
	@taskCost: (task) -> return task.aveTime * task.avePersons * task.hourlyWage/60/60
	@sumTaskCost: (tasks, sum=0) ->
		if tasks.length is 0 then return 0
		for task in tasks then sum += @taskCost(task)
		return sum

	# Option
	@optionCost: (option) -> return option.price * option.num
	@sumOptionCost: (options, sum=0) ->
		for option  in options then if option.active then sum += @optionCost(option)
		return sum

	# Paper
	@paperCost: (args) -> return if args.paper.use then args.paper.price / @paperNum args else 0
	@sumRecipePaperCost: (recipe, part, ordersheet) ->
		if part is "body"
			base = @paperCost { paper: ordersheet.papers.body.inside, flow: recipe.flow, size: ordersheet.params.size, cutVerDir: ordersheet.papers.body.base.cutVerDir }
			inside = @paperCost { paper: ordersheet.papers.body.base, flow: recipe.flow, size: ordersheet.params.size, cutVerDir: ordersheet.papers.body.inside.cutVerDir }
			wrap = @paperCost { paper: ordersheet.papers.body.wrap, flow: recipe.flow, size: ordersheet.params.size, cutVerDir: ordersheet.papers.body.wrap.cutVerDir }
			return base + inside + wrap
		else
			base = @paperCost { paper: ordersheet.papers.lid.inside, flow: recipe.flow, size: ordersheet.params.size, cutVerDir: ordersheet.papers.lid.base.cutVerDir }
			inside = @paperCost { paper: ordersheet.papers.lid.base, flow: recipe.flow, size: ordersheet.params.size, cutVerDir: ordersheet.papers.lid.inside.cutVerDir }
			wrap = @paperCost { paper: ordersheet.papers.lid.wrap, flow: recipe.flow, size: ordersheet.params.size, cutVerDir: ordersheet.papers.lid.wrap.cutVerDir }
			return base + inside + wrap
	@paperCosts: (ordersheet) ->
		return {
			body:
				base: @paperCost { 
					paper: ordersheet.papers.body.base
					flow: ordersheet.recipes.body.flow
					size: ordersheet.params.size
					cutVerDir: ordersheet.papers.body.base.cutVerDir
				}
				inside: @paperCost { 
					paper: ordersheet.papers.body.inside
					flow: ordersheet.recipes.body.flow
					size: ordersheet.params.size
					cutVerDir: ordersheet.papers.body.inside.cutVerDir
				}
				wrap: @paperCost { 
					paper: ordersheet.papers.body.wrap
					flow: ordersheet.recipes.body.flow
					size: ordersheet.params.size
					cutVerDir: ordersheet.papers.body.wrap.cutVerDir
				}
			lid:
				base: @paperCost { 
					paper: ordersheet.papers.lid.base
					flow: ordersheet.recipes.lid.flow
					size: ordersheet.params.size
					cutVerDir: ordersheet.papers.lid.base.cutVerDir
				}
				inside: @paperCost { 
					paper: ordersheet.papers.lid.inside
					flow: ordersheet.recipes.lid.flow
					size: ordersheet.params.size
					cutVerDir: ordersheet.papers.lid.inside.cutVerDir
				}
				wrap: @paperCost { 
					paper: ordersheet.papers.lid.wrap
					flow: ordersheet.recipes.lid.flow
					size: ordersheet.params.size
					cutVerDir: ordersheet.papers.lid.wrap.cutVerDir
				}
		}
	@needSize: (args) ->
		method = if args.flow.getParam("包み方").value is "包み" then "包み"
		else args.flow.getParam("巻き方").value
		switch method
			when "包み" then return {
				width: args.size.width + args.size.height*2
				height: args.size.depth + args.size.height*2
			}
			when "一本巻き" then return {
				width: args.size.width*2 + args.size.depth*2 + @toMM(0.2)
				height: args.size.height + @toMM(0.04)
			}
			when "二本巻き" then return {
				width: args.size.width + args.size.depth + @toMM(0.2)
				height: (args.size.height + @toMM(0.04))*2
			}
			when "天貼り" then return {
				width: args.size.width + @toMM(0.01)
				height: args.size.height + @toMM(0.01)
			}
			when "底貼り" then return {
				width: args.size.width - @toMM(0.01)
				height: args.size.height - @toMM(0.01)
			}
	@paperNum: (args) ->
		method = args.flow.getParam("貼り方").value
		needSize = @needSize(args)
		paper = args.paper
		cutVerDir = args.cutVerDir

		if !needSize? or needSize.height <= 0 then return 0

		switch method
			when "包み"
				if cutVerDir then return Math.floor(paper.width/needSize.width) * Math.floor(paper.height/needSize.height)
				else return Math.floor(paper.width/needSize.height) * Math.floor(paper.height/needSize.width)
			when "巻き"
				args.method = "天貼り"
				needSizes = [needSize, @needSize(args)]
				if needSizes[0].height <= 0 or needSizes[1].height <= 0 then return 0
				cutHorizonNums = 0
				cutVerticalNums = 0
				leftHeight = 0
				if cutVerDir
					cutHorizonNums = [Math.floor(paper.width / needSizes[0].width), Math.floor(paper.width / needSizes[1].width)]
					cutVerticalNums = [needSizes[0].height, needSizes[1].height]
					leftHeight = paper.height
				else
					cutHorizonNums = [Math.floor(paper.width / needSizes[0].height), Math.floor(paper.width / needSizes[1].height)]
					cutVerticalNums = [needSizes[0].width, needSizes[1].width]
					leftHeight = paper.width
				nums = [0,0]
				
				loop
					if leftHeight > cutVerticalNums[0] + cutVerticalNums[1]
						leftHeight -= (cutVerticalNums[0] + cutVerticalNums[1])
						nums[0] += cutHorizonNums[0]
						nums[1] += cutHorizonNums[1]
					else if nums[0] <= nums[1] and leftHeight > cutVerticalNums[0]
						leftHeight -= cutVerticalNums[0]
						nums[0] += cutHorizonNums[0]
					else if nums[1] <= nums[0] and leftHeight > cutVerticalNums[1]
						leftHeight -= cutVerticalNums[1]
						nums[1] += cutHorizonNums[1]
					else
						break
				return Math.min(nums[0],nums[1])

	###
	# Privates
	###
	@toShaku: (mm) ->
		return Math.floor(Number(mm) / 303.03)
	@toMM: (shaku) ->
		return Math.floor(Number(shaku) * 303.03)