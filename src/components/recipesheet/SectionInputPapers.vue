<template lang="pug">
	section.editer-section
		h2.editer-section-title 材料
		table.input-table
			tr
				th
				th
					p.table-title.title-horizontal 身
				th
				th
					p.table-title.title-horizontal 蓋
			tr
				th.table-title.title-vertival 生<br>地
				td 
					input-paper( :part="'body'", :target="'base'" )
				td.links
					p.links-btn( @click="bodyToLid('base') ") →
					p.links-btn( @click="lidToBody('base') ") ←
				td
					input-paper( :part="'lid'", :target="'base'" )
			tr
				th.table-title.title-vertival 合<br>紙<br>用<br>紙
				td
					input-paper( :part="'body'", :target="'inside'" v-show="useInsidePaper('body')" )
					p.caution( v-show="!useInsidePaper('body')" ) ※合紙用紙はしません
				td.links
					p.links-btn( @click="bodyToLid('inside') ") →
					p.links-btn( @click="lidToBody('inside') ") ←
				td
					input-paper( :part="'lid'", :target="'inside'" v-show="useInsidePaper('lid')" )
					p.caution( v-show="!useInsidePaper('lid')" ) ※合紙用紙はしません
			tr
				th.table-title.title-vertival 包<br>み<br>紙
				td
					input-paper( :part="'body'", :target="'wrap'" )
				td.links
					p.links-btn( @click="bodyToLid('wrap') ") →
					p.links-btn( @click="lidToBody('wrap') ") ←
				td
					input-paper( :part="'lid'", :target="'wrap'" )
</template>
<script lang="coffee">
	Paper = require "./../../models/data_type/Paper.coffee"
	bus = require "./../../scripts/bus.coffee"
	module.exports =
		components: { InputPaper: require "./../input_modules/InputPaper" }
		methods:
			useInsidePaper: (part) ->
				if part is "body"
					bool = bus.ordersheet.recipes.body.flow.getParam("合紙")?.value
					bus.ordersheet.papers.body.inside.use = bool is "する"
					return bool is "する"
				else
					bool = bus.ordersheet.recipes.lid.flow.getParam("合紙")?.value
					bus.ordersheet.papers.lid.inside.use = bool is "する"
					return bool is "する"
			
			bodyToLid: (part) ->
				switch part
					when "base" then bus.ordersheet.papers.lid.base = new Paper bus.ordersheet.papers.body.base.toSource()
					when "inside" then bus.ordersheet.papers.lid.inside = new Paper bus.ordersheet.papers.body.inside.toSource()
					when "wrap" then bus.ordersheet.papers.lid.wrap = new Paper bus.ordersheet.papers.body.wrap.toSource()

			lidToBody: (part) ->
				switch part
					when "base" then bus.ordersheet.papers.body.base = new Paper bus.ordersheet.papers.lid.base.toSource()
					when "inside" then bus.ordersheet.papers.body.inside = new Paper bus.ordersheet.papers.lid.inside.toSource()
					when "wrap" then bus.ordersheet.papers.body.wrap = new Paper bus.ordersheet.papers.lid.wrap.toSource()
</script>
<style lang="sass" scoped>
	@import "../../sass/colors"
	table
		margin-top: -10px
	
	.input-table
		width: 100%
		border-collapse: separate;
		border-spacing: 0 20px;
	
	tr:not(:first-child)
		height: 200px

	td:not(.links), tr:first-child th:nth-child(2), tr:first-child th:nth-child(4)
		padding: 0 20px
	
	.table-title
		font-size: 10pt
		background-color: $Gray300
		color: $Gray700
		font-weight: bold
	
	.title-horizontal
		padding: 0 0.5em
		padding-top: 2px
		line-height: 1.2em
	
	.title-vertival
		width: 1.2em
		padding-top: 0.5em
		vertical-align: top
		text-align: center
		line-height: 1.1em

	.links
		width: 1em
		text-align: center
	
	.caution
		font-size: 11pt
		color: $Gray500
		text-align: center
	
	.links-btn
		width: 30px
		height: 30px
		border-radius: 50%
		background-color: $White
		color: $Gray500
		cursor: pointer
		margin: 10px 0
		line-height: 30px
		font-weight: bold
		&:hover
			color: $Blue400
</style>