<template lang="pug">
	div
		section.input-item
			p.input-item-title 紙名
			p.input-item-value
				input.input-elm( type="text" v-model="getPaper.title" @keyup.enter="focusNext" )
		section.input-item
			p.input-item-title 寸法
			p.input-item-value
				input.input-elm( type="number" v-model="getPaper.width" @keyup.enter="focusNext" )
				span.unit mm
				span.operator ×
				input.input-elm( type="number" v-model="getPaper.height" @keyup.enter="focusNext" )
				span.unit mm
		section.input-item
			p.input-item-title 単価
			p.input-item-value
				input.input-elm( type="number" v-model="getPaper.price" @keyup.enter="focusNext" )
				span.unit 円/枚
		section.input-item
			p.input-item-title 取数
			p.input-item-value
				InputNP( :part="part", :target="target" )
</template>
<script lang="coffee">
	bus = require "./../../scripts/bus.coffee"
	module.exports =
		components:
			InputSelecter: require "./../input_modules/InputSelecter"
			InputNumber: require "./../input_modules/InputNumber"
			InputText: require "./../input_modules/InputText"
			InputNP: require "./../input_modules/InputNP"
		props: ["part","target"]
		methods:
			focusNext: (e) ->
				e.srcElement.blur()
				next = this.getNextElm e.srcElement
				if next? then next.focus() else this.$emit 'entered'
			
			getNextElm: (elm) ->
				rootElm = elm.parentNode.parentNode.parentNode.parentNode
				inputs = rootElm.getElementsByClassName("input-elm")
				for input, index in inputs then if input is elm then return inputs[index+1]
			
			changeCutDir: (msg) ->
				this.getPaper.cutVerDir = if msg.index is 0 then true else false

		computed:
			getSelecterValue: ->
				return [
					{ name: "縦取り" }
					{ name: "横撮り" }
				]
			getActiveIndex: ->
				return if this.getPaper.cutVerDir then return 0 else 1
			
			getPaper: ->
				if this.part is "body"
					if this.target is "base" then return bus.ordersheet.papers.body.base
					if this.target is "inside" then return bus.ordersheet.papers.body.inside
					if this.target is "wrap" then return bus.ordersheet.papers.body.wrap
				else
					if this.target is "base" then return bus.ordersheet.papers.lid.base
					if this.target is "inside" then return bus.ordersheet.papers.lid.inside
					if this.target is "wrap" then return bus.ordersheet.papers.lid.wrap
</script>
<style lang="sass" scoped>
	.input-item-title
		width: 3em
</style>