<template lang="pug">
	section.editer-section
		table
			tr
				th 計算項目
				th 計算式
				th 計算結果
			tr( v-for="exp in getExpressions" )
				th.label {{exp.label}}
				td.expression
					div.formula( v-for="value in exp.formula")
						span( v-show="value.visible", :class="value.class" )
							span.operator( v-if="value.class=='operator'" ) {{value.value}}
							span.label( v-if="value.class=='resultValue'||value.class=='inputValue'||value.class=='textValue'" ) {{value.label}}
							span.number( v-if="value.class=='resultValue'" ) {{value.number.toFixed(1)}}
							span.inputValue( v-if="value.class=='inputValue'" ) 
								input( type="number" v-model="ordersheet.params.equipmentCost" @keyup.enter="focusNext" v-if="value.label=='設備運用費'" )
								input( type="number" v-model="ordersheet.params.prepareCostRate" @keyup.enter="focusNext" v-if="value.label=='制作準備費'" )
							span.textValue( v-if="value.class=='textValue'" ) {{value.number}}
				td.cost
					span(v-if="exp.label!='合計'") @ {{exp.cost.toFixed(1)}} 円
					span(v-if="exp.label=='合計'") {{exp.cost.toFixed(0)}} 円
</template>

<script lang="coffee">
	bus = require "./../../scripts/bus.coffee"
	OrderSheet = require "./../../models/data_type/OrderSheet.coffee"
	Task = require "./../../models/data_type/Task.coffee"

	module.exports =
		methods:
			focusNext: (e) -> e.srcElement.blur()
		computed:
			ordersheet: -> return bus.ordersheet
			getExpressions: ->
				return [
					{
						label: "材料費 小計"
						cost: OrderSheet.calc.totalPaperCost this.ordersheet
						formula: [
							{ class: "resultValue", label: "身 生地", number: OrderSheet.calc.paperCosts(this.ordersheet).body.base, visible: true }
							{ class: "operator", value: "+", visible: this.ordersheet.papers.body.inside.use }
							{ class: "resultValue", label: "身 合紙", number: OrderSheet.calc.paperCosts(this.ordersheet).body.inside, visible: this.ordersheet.papers.body.inside.use }
							{ class: "operator", value: "+", visible: true }
							{ class: "resultValue", label: "身 貼紙", number: OrderSheet.calc.paperCosts(this.ordersheet).body.wrap, visible: true }
							{ class: "operator", value: "+", visible: true }
							{ class: "resultValue", label: "蓋 生地", number: OrderSheet.calc.paperCosts(this.ordersheet).lid.base, visible: true }
							{ class: "operator", value: "+", visible: this.ordersheet.papers.lid.inside.use }
							{ class: "resultValue", label: "蓋 合紙", number: OrderSheet.calc.paperCosts(this.ordersheet).lid.inside, visible: this.ordersheet.papers.lid.inside.use }
							{ class: "operator", value: "+", visible: true }
							{ class: "resultValue", label: "蓋 貼紙", number: OrderSheet.calc.paperCosts(this.ordersheet).lid.wrap, visible: true }
						]
					}
					{
						label: "手間賃 小計"
						cost: OrderSheet.calc.totalTaskCost this.ordersheet
						formula: [
							{
								class: "resultValue",
								label: "身 手間賃",
								number: Task.calc.sumCost(this.ordersheet.recipes.body.flow.tasks),
								visible: true
							}
							{ class: "operator", value: "+", visible: true }
							{
								class: "resultValue",
								label: "蓋 手間賃",
								number: Task.calc.sumCost(this.ordersheet.recipes.lid.flow.tasks),
								visible: true
							}
						]
					}
					{
						label: "制作準備費"
						cost: OrderSheet.calc.totalTaskCost(this.ordersheet).toFixed(1)*this.ordersheet.params.prepareCostRate/100
						formula: [
							{
								class: "resultValue",
								label: "手間賃",
								number: OrderSheet.calc.totalTaskCost(this.ordersheet),
								visible: true
							}
							{ class: "operator", value: "×", visible: true }
							{
								class: "textValue",
								label: "　",
								number: "( ",
								visible: true
							}
							{
								class: "inputValue",
								label: "制作準備費",
								visible: true
							}
							{
								class: "textValue",
								label: "　",
								number: "÷ 100 )",
								visible: true
							}
						]
					}
					{
						label: "制作単価 小計"
						cost: OrderSheet.calc.totalCost this.ordersheet
						formula: [
							{
								class: "resultValue",
								label: "材料費",
								number: OrderSheet.calc.totalPaperCost(this.ordersheet),
								visible: true
							}
							{ class: "operator", value: "+", visible: true }
							{
								class: "resultValue",
								label: "手間賃",
								number: OrderSheet.calc.totalTaskCost(this.ordersheet),
								visible: true
							}
							{ class: "operator", value: "+", visible: true }
							{
								class: "resultValue",
								label: "追加制作費",
								number: OrderSheet.calc.sumOptionCost(this.ordersheet),
								visible: true
							}
							{ class: "operator", value: "+", visible: true }
							{
								class: "resultValue",
								label: "制作準備費",
								number: OrderSheet.calc.totalTaskCost(this.ordersheet)*this.ordersheet.params.prepareCostRate/100,
								visible: true
							}
							{ class: "operator", value: "+", visible: true }
							{
								class: "inputValue",
								label: "設備運用費",
								visible: true
							}
						]
					}
					{
						label: "販売単価 小計"
						cost: OrderSheet.calc.price this.ordersheet
						formula: [
							{
								class: "resultValue",
								label: "制作単価",
								number: OrderSheet.calc.totalCost(this.ordersheet),
								visible: true
							}
							{ class: "operator", value: "÷", visible: true }
							{
								class: "textValue",
								label: "粗利益率",
								number: "(1-"+this.ordersheet.params.rate/100+")",
								visible: true
							}
							{ class: "operator", value: "×", visible: true }
							{
								class: "textValue",
								label: "割引率",
								number: OrderSheet.calc.discountRate(this.ordersheet),
								visible: true
							}
						]
					}
					{
						label: "合計"
						cost: OrderSheet.calc.totalPrice this.ordersheet
						formula: [
							{
								class: "resultValue",
								label: "販売単価",
								number: OrderSheet.calc.price(this.ordersheet),
								visible: true
							}
							{ class: "operator", value: "×", visible: true }
							{
								class: "textValue",
								label: "ロット数",
								number: this.ordersheet.params.lots,
								visible: true
							}
						]
					}
				]
</script>
<style lang="sass" scoped>
	@import "./../../sass/colors"
	.editer-section
		border-top: 1px solid $Gray300
		background-color: #F8F7F6
		margin-bottom: 0
	
	.editer-section-title
		border-color: $Gray700
		border: none
		color: $Gray700
		margin-bottom: 1em

	table
		tr:first-child th
			font-size: 10pt
			padding-bottom: 0.3em
			// background-color: $Gray300
			color: $Gray600
		th, td
			padding-left: 1em
		tr>.label
			padding-right: 1em
			font-size: 10pt
			color: $BlueGray700
		tr>.cost
			font-size: 10pt
			color: $BlueGray700
		tr
			border-bottom: 1px solid $Gray300
		td
			padding-top: 5px
			padding-bottom: 5px
	
	.expression
		display: flex
		align-items: center
		flex-wrap: wrap
		margin-left: 3px
		.formula
			.operator
				color: $BlueGray200
				padding: 0 0.5em
				font-size: 10pt
			.value,.resultValue,.inputValue,.textValue
				display: flex
				flex-direction: column
				align-items: center
			.label
				color: $BlueGray500
				font-size: 8pt
				line-height: 1.5em
			.number,.inputValue,.textValue
				line-height: 1.2em
				font-size: 10pt
				color: $BlueGray800
	input[type="number"]
		height: 1.2em
		line-height: 1.2em
		border: none
		padding: 0
		font-size: 10pt
		color: $BlueGray800
		&:focus
			border: none
	
</style>