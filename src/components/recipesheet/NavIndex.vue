<template lang="pug">
	ul
		li(@click="smoothScroll(target.id)" v-for="target in targets") {{target.label}}
</template>
<script lang="coffee">
	module.exports = 
		props: ["targets"]
		methods:
			smoothScroll: (id) ->
				target = $("#"+id)
				position = target.offset().top + $(".page").scrollTop()
				$('.page').animate({scrollTop: position-110}, 500, 'swing')
</script>
<style lang="sass" scoped>
	@import "./../../sass/colors"
	ul li
		color: $Gray400
		font-size: 10pt
		line-height: 2.5em
		cursor: pointer
		outline: none
		text-align: right
		&:hover
			color: $Teal700
		&.active
			color: $Teal700
</style>