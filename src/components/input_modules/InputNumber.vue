<template lang="pug">
	input.input-elm.input-number(
		type="number"
		v-model="childValue"
		@input="onInput"
		@keyup.enter="enter"
		v-bind:step="getStep"
		v-bind:min="getMin"
		v-bind:max="getMax" )
</template>
<script lang="coffee"> 
	module.exports =
		props: ["value","step","min","max"]
		data: -> return { childValue: this.value }
		methods:
			enter: (e)->
				e.srcElement.blur()
				this.$emit 'entered', e.srcElement
			onInput: (e)->
				this.$emit 'input', Number(e.target.value)
		computed:
			getStep: -> if this.step? then return this.step
			getMin: -> if this.min? then return this.min else 0
			getMax: -> if this.max? then return this.max
</script>