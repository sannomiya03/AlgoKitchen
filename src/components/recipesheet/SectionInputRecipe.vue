<template lang="pug">
	section.editer-section
		h2.editer-section-title 制作工程{{" "}}
			span( v-if="part=='body'" ) 身
			span( v-if="part=='lid'" ) 蓋
		div.inputPreset
			input-Preset(:part="part")
		div.lay-twoColumn
			input-forks.lay-column(:part="part")
			input-tasks.lay-column(:part="part")
</template>
<script lang="coffee">
	bus = require "./../../scripts/bus.coffee"
	module.exports =
		components:
			InputPreset: require "./../input_modules/InputPreset"
			InputForks: require "./../input_modules/InputForks"
			InputTasks: require "./../input_modules/InputTasks"
		props: ["part"]
</script>
<style lang="sass" scoped>
	@import "./../../sass/colors"
	.inputPreset
		margin-bottom: 20px
		position: relative
		&:after
			position: absolute
			left: 0
			bottom: 0
			width: 100%
			content: " "
			border-bottom: 1px solid $Gray400

	.lay-column:first-child
		width: 40%
	.lay-column:last-child
		width: 60%
</style>