<template lang="pug">
	svg( :width="width", :height="height" )
		g
			polygon( :points="points(arr)")
			circle( :cx="width/2", :cy="height/2", :r="width*0.4" )
			axis-label( v-for="(nutrient, index) in arr",
				:stat="nutrient",
				:index="index",
				:total="arr.length")
</template>
<script lang="coffee">
	module.exports =
		props: ["width", "height","arr"]
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
</script>
<style lang="sass">
	polygon
		fill: #42b983
		opacity: .75
	circle
		fill: transparent
		stroke: #999
	text
		font-family: Helvetica Neue, Arial, sans-serif
		font-size: 10px
		fill: #666
	label
		display: inline-block
		margin-left: 10px
		width: 20px
</style>