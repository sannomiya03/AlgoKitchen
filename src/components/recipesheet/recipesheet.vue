<template lang="pug">
	section.recipesheet
		h2.title {{recipesheet.title}}
</template>

<script lang="coffee">
	module.exports =
		data: ->
			return {
				recipesheet:
					title: "menu"
			}
</script>

<style lang="sass">
	.recipesheet
		position: relative
		width: 400px
		height: 400px
		margin: 0 auto
		border: 1px solid #AF8727
		
</style>
