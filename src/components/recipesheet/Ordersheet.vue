<template lang="pug">
	section.ordersheet
		nav.ordersheet-nav 
			NavIndex.fixmodule(:targets="getTargets")
		main.ordersheet-main
			section.recipe-editer
				SectionInputParams#size
				SectionInputPapers#paper
				SectionInputRecipe#recipe_body(:part="'body'")
				SectionInputRecipe#recipe_lid(:part="'lid'")
				SectionInputOptions#option
				SectionViewCalcResult#result
		section.ordersheet-result
			ViewComputed.fixmodule
</template>

<script lang="coffee">
	bus = require "./../../scripts/bus.coffee"

	module.exports =
		components:
			NavIndex: require "./NavIndex"
			SectionInputParams: require "./SectionInputParams"
			SectionInputPapers: require "./SectionInputPapers"
			SectionInputRecipe: require "./SectionInputRecipe"
			SectionInputOptions: require "./SectionInputOptions"
			SectionViewCalcResult: require "./SectionViewCalcResult"
			ViewComputed: require "./ViewComputed"
		
		computed:
			getTargets: ->
				return [
					{ id: "size", label: "寸法"　}
					{ id: "paper", label: "紙"　}
					{ id: "recipe_body", label: "制作工程 身"　}
					{ id: "recipe_lid", label: "制作工程 蓋"　}
					{ id: "option", label: "追加工程"　}
					{ id: "result", label: "単価計算"　}
				]
</script>

<style lang="sass">
	@import "./../../sass/colors"
	
	$editer-bg-color: $White

	.ordersheet
		position: relative
		width: 1140px
		margin: 0 auto
		.ordersheet-nav, .ordersheet-result
			width: 120px
		.ordersheet-main
			width: 100%
			padding: 40px 120px
	
	.ordersheet-nav, .ordersheet-result
		position: absolute
		width: 120px
		padding: 0 20px
		z-index: 8000
		.fixmodule
			position: fixed
		&.ordersheet-nav
			top: 110px
			left: 0
		&.ordersheet-result
			top: 110px
			right: 0

	.recipe-editer
		margin: 40px 0
		background-color: $editer-bg-color
		border: 1px solid $Gray300
	
	.editer-section
		width: 100%
		margin-bottom: 0px
		padding: 40px

	.editer-section-title
		font-size: 11pt
		font-weight: bold
		color: $Teal800
		border-top: 2px solid $Teal800
		margin-bottom: 0.5em
</style>
