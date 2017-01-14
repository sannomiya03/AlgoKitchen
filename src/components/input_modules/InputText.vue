<template lang="pug">
	input.input-elm.input-text( type="text" v-model="childValue" @input="onInput" @keyup.enter="enter" )
</template>
<script lang="coffee"> 
	module.exports =
		props: ["value"]
		data: ->
			return {
				childValue: this.value
			}
		methods:
			enter: (e)->
				e.srcElement.blur()
				this.$emit 'entered', e.srcElement
			onInput: (e)->
				console.log e.target.value
				this.$emit 'input', e.target.value
</script>