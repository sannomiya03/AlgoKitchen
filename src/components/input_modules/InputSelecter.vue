<template lang="pug">
	ul.selecter( :class="[ getClassDirection ]" )
		li.select-item( v-for="value, index in values",
			:class="[ getClassActivity(index), getClassFieldLength(value), getOptionCls ]",
			@click="select(index)" )
			span.label( v-for="(item, index) in value" )
				span {{item}}
</template>

<script lang="coffee"> 
	module.exports =
		props: ["target","values", "activeIndex", "direction", "option"]
		methods:
			select: (index) ->
				this.$emit "select", { target:this.target, index: index }
			
			getClassActivity: (index) ->
				if index is this.activeIndex then return "active"
			
			getClassFieldLength: (value)->
				if Object.keys(value).length is 2 then return "twoItems"
				if Object.keys(value).length is 3 then return "threeItems"
				else return
		
		computed:
			getClassDirection: ->
				if this.direction is "sidebyside" then return "sidebyside"
				if this.direction is "sidebysideBlock" then return "sidebysideBlock"
				else return "column"
			getOptionCls: ->
				if this.option? then return "select-item-"+this.option
</script>

<style lang="sass" scoped>
	@import "./../../sass/colors"

	$border-width: 1px
	.select-item
		position: relative
		display: flex
		align-items: center
		justify-content: center
		min-height: 1.8em
		padding: 0
		font-size: 10pt
		border: $border-width solid $Gray300
		background-color: $Gray200
		cursor: pointer
		.label
			line-height: 1.2em
		&:hover
			background-color: $Gray100
	.select-item > .label:not(:first-child) > span
		font-size: 8pt
	
	.select-item.active:after
		position: absolute
		top: -$border-width
		left: -$border-width
		width: 100%
		height: 100%
		content: " "
		z-index: 5000

	.select-item
		color: $Gray500
		&.active
			background-color: $White
			color: $Green900
		&.active:after
			border: $border-width solid $Green300

	.column, .sidebyside
		.select-item
			text-align: center
			display: flex
			flex-direction: column

	$radius: 50px
	.column
		.select-item:not(:last-child)
			border-bottom: none
		.select-item:first-childcc
			border-radius: $radius $radius 0 0
		.select-item:last-child
			border-radius: 0 0 $radius $radius
		.select-item:first-child.active:after
			border-radius: $radius $radius 0 0
		.select-item:last-child.active:after
			border-radius: 0 0 $radius $radius
	
	.sidebyside
		display: flex
		width: 100%
		.select-item
			width: 50%
		.select-item:not(:last-child)
			border-right: none
		.select-item:first-child
			border-radius: $radius 0 0 $radius
		.select-item:last-child
			border-radius: 0 $radius $radius 0
		.select-item:first-child.active:after
			border-radius: $radius 0 0 $radius
		.select-item:last-child.active:after
			border-radius: 0 $radius $radius 0
	
	.select-item-useSubLabel
		padding-top: 5px
		padding-bottom: 2px
	
	.sidebyside
		.select-item.select-item-block, .select-item.select-item-block.active:after
			border-radius: 0
		.select-item-block
			flex-direction: column
			align-items: flex-start
			width: 120px
			padding: 10px
			background-color: $White
			border-color: $White
			.label:first-child
				padding-bottom: 3px
			&:hover
				background-color: $Gray100
			&.active
				background-color: $White
			&.active:after
				border: $border-width solid $Gray400
				border-bottom-color: $White

	.select-item-forkparam
		&.active
			background-color: $Green500
			color: $White
			&:after
				border: $border-width solid $Green700
</style>