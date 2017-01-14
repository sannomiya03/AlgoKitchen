<template lang="pug">
	svg.rader( :width="width", :height="height" )
		g
			polygon( :points="points(arr)")
			circle( :cx="width/2", :cy="height/2", :r="width*0.4" )
			text( v-if="showLabel==true" v-for="(value,key) in arr", :x="getLabelPos(value,key).x", :y="getLabelPos(value,key).y" ) {{key}}

</template>
<script lang="coffee">
	module.exports =
		props: ["width", "height","arr","showLabel"]
		methods:
			points: (nutrients)->
				total = 8
				points = ""
				index = 0
				for key, value of nutrients
					x = 0
					y = -value * this.width/100*0.4
					angle = Math.PI * 2 / total * index
					cos = Math.cos(angle)
					sin = Math.sin(angle)
					tx = x * cos - y * sin + this.width/2
					ty = x * sin + y * cos + this.height/2
					points += tx+","+ty
					if index < total - 1 then points += ","
					index++
				return points
			
			getLabelPos: (value, key) ->
				index = this.getIndex key
				total = 8
				x = 0
				y = -110 * this.width/100*0.4
				angle = Math.PI * 2 / total * index
				cos = Math.cos(angle)
				sin = Math.sin(angle)
				tx = x * cos - y * sin + 100
				ty = x * sin + y * cos + 100
				if index > 3
					tx -= 20
				return { x: tx, y: ty }
			
			getIndex: (value) ->
				if value is "calorie" then return 0
				if value is "ash" then return 1
				if value is "cholesterol" then return 2
				if value is "protein" then return 3
				if value is "water" then return 4
				if value is "fiber" then return 5
				if value is "fat" then return 6
				if value is "carb" then return 7
				return 0
</script>
<style lang="sass">
	@import "./../sass/mixins"
	.rader
		+animate()
	polygon
		fill: #42b983
		opacity: .75
		+animate()
	circle
		fill: transparent
		stroke: #ddd
		+animate()
	text
		font-family: Helvetica Neue, Arial, sans-serif
		font-size: 10px
		fill: #666
	label
		display: inline-block
		margin-left: 10px
		width: 20px
</style>