<template lang="pug">
	table.ComputedView
		tr.computed( v-for="computation in computations")
			td
				span.key {{ computation.title }}
				span.val
					span( v-if="computation.title!='見積もり金額'" ) @ {{ computation.value.toFixed(0) }}
					span( v-if="computation.title=='見積もり金額'" ) ¥ {{ computation.value.toFixed(0) }}

</template>

<script lang="coffee">
	bus = require "./../../scripts/bus.coffee"
	OrderSheet = require "./../../models/data_type/OrderSheet.coffee"

	module.exports =
		props: ["title"]
		data: -> return { ordersheet: bus.ordersheet }
		
		computed:
			computations: -> return [
				{
					title: "材料費"
					value: OrderSheet.calc.totalPaperCost this.ordersheet
				}
				{
					title: "手間賃"
					value: OrderSheet.calc.totalTaskCost this.ordersheet
				}
				{
					title: "追加工程費"
					value: OrderSheet.calc.sumOptionCost this.ordersheet
				}
				{
					title: "制作単価"
					value: OrderSheet.calc.totalCost this.ordersheet
				}
				{
					title: "販売単価"
					value: OrderSheet.calc.price this.ordersheet
				}
				{
					title: "見積もり金額"
					value: OrderSheet.calc.totalPrice this.ordersheet
				}
			]
</script>

<style lang="sass" scoped>
	@import "./../../sass/colors"
	@import "./../../sass/mixins"

	table
		td
			padding-bottom: 10px
		td:first-child
			display: flex
			flex-direction: column
			.key
				color: $BlueGray500
				font-size: 10pt
				line-height: 1.2em
			.val
				line-height: 1.2em
		td:last-child
			vertical-align: bottom
			+animate()
			@media only screen and (max-width: 1240px)
			 	display: none
</style>