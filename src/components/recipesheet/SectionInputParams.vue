<template lang="pug">
	div.lay-twoColumn
		section.editer-section.lay-column( v-for="source in getSource" )
			h2.editer-section-title {{source.title}}
			section.input-item( v-for="param, index in source.params" )
				p.input-item-title {{param.label}}
				p.input-item-value
					input-number( v-model="params.size.width" @entered="focusNext" v-if="param.index==1" )
					input-number( v-model="params.size.depth" @entered="focusNext" v-if="param.index==2" )
					input-number( v-model="params.size.height" @entered="focusNext" v-if="param.index==3" )
					input-number( v-model="params.size.lidHeight" @entered="focusNext" v-if="param.index==4" )
					input-number( v-model="params.prepareCostRate" @entered="focusNext" v-if="param.index==5" )
					input-number( v-model="params.equipmentCost" @entered="focusNext" v-if="param.index==6" )
					input-number( v-model="params.rate" @entered="focusNext" v-if="param.index==7" )
					input-number( v-model="params.lots" @entered="focusNext" v-if="param.index==8" )
					span.unit {{param.unit}}
</template>
<script lang="coffee">
	bus = require "./../../scripts/bus.coffee"
	module.exports =
		components: { InputNumber: require "./../input_modules/InputNumber" }
		data: -> return { params: bus.ordersheet.params }
		methods:
			focusNext: (elm) ->
				next = this.getNextElm(elm)
				if next? then next.focus()
				else this.$emit 'entered'
			getNextElm: (elm) ->
				rootElm = elm.parentNode.parentNode.parentNode
				inputs = rootElm.getElementsByClassName("input-elm")
				for input, index in inputs
					if input is elm then return inputs[index+1]
		computed:
			getSource: ->
				return [
						{
							title: "寸法"
							params: [
								{ label: "横(W)", index: "1", unit: "mm" }
								{ label: "高さ(H)", index: "2",unit: "mm" }
								{ label: "深さ(D)", index: "3",unit: "mm" }
								{ label: "蓋の深さ", index: "4",unit: "mm" }
							]
						}
						{
							title: "見積もり変数"
							params: [
								{ label: "粗利益率", index: "7", unit: "%" }
								{ label: "ロット数", index: "8", unit: "個" }
							]
						}
					]
</script>
