<template lang="pug">
	input-selecter.inputNP( :values="getSelecterValue", :activeIndex="getActiveIndex", :direction="'sidebyside'", :option="'useSubLabel'", @select="changeVerCut" )
</template>
<script lang="coffee">
	Calc = require "./../../models/data_type/Calc.coffee"
	Paper = require "./../../models/data_type/Paper.coffee"
	bus = require "./../../scripts/bus.coffee"
	
	module.exports =
		components:
			InputSelecter: require "./InputSelecter"
		props:
			["part", "target"]
		computed:
			getSelecterValue: ->
				return [
					{ title: "縦取り", paperNum: this.calcPaperNum(true)+"枚" }
					{ title: "横取り", paperNum: this.calcPaperNum(false)+"枚" }
				]
			getActiveIndex: ->
				if this.getPaper.cutVerDir then 0 else 1
			getFlow: ->
				if this.part is "body" then return bus.ordersheet.recipes.body.flow
				return bus.ordersheet.recipes.lid.flow
			getPaper: ->
				if this.part is "body"
					if this.target is "base" then return bus.ordersheet.papers.body.base
					if this.target is "inside" then return bus.ordersheet.papers.body.inside
					if this.target is "wrap" then return bus.ordersheet.papers.body.wrap
				else
					if this.target is "base" then return bus.ordersheet.papers.lid.base
					if this.target is "inside" then return bus.ordersheet.papers.lid.inside
					if this.target is "wrap" then return bus.ordersheet.papers.lid.wrap
		methods:
			changeVerCut: (msg) -> this.getPaper.cutVerDir = if msg.index is 0 then true else false
			calcPaperNum: (cutVerDir) -> return Paper.calc.paperNum this.getFlow, bus.ordersheet.params.size, this.getPaper, cutVerDir
			calcPaperCost: (cutVerDir) -> return Paper.calc.cost this.getFlow, bus.ordersheet.params.size, this.getPaper, cutVerDir
</script>