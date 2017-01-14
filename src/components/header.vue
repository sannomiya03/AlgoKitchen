<template lang="pug">
	header.app-header
		h1
			router-link( :to="{name:'top'}" ) Algo Kitchen
		nav
			ul
				li
					router-link( :to="{name:'new_recipe'}", :class="{active: $route.fullPath=='/recipe/new'}") レシピを作る
				li
					router-link( :to="{name:'recipe'}", :class="{active: $route.fullPath!='./recipe/new' && $route.name=='recipe'}" ) みんなのレシピ
</template>
<style lang="sass">
	@import "./../sass/colors"
	$headerHeight: 50px
	.app-header
		position: fixed
		top: 0
		left: 0
		width: 100%
		height: $headerHeight
		display: flex
		align-items: center
		background-color: $White
		border-bottom: 1.5px solid #D2C8BE
		z-index: 8000
			
	.app-header
		background-color: $White
		nav
			height: 100%
			ul
				display: flex
				align-items: center
				margin-left: 1em
				height: 100%
				li
					height: 100%
		a
			display: block
			width: 100%
			height: 100%
			text-decoration: none
			font-size: 10pt
			padding: 0 1.5em
			color: $Gray400
			line-height: $headerHeight
			&:hover
				background-color: $Gray200
			&.active
				color: $Teal800
		h1
			a
				font-size: 11pt
				color: $Black
				font-weight: bold
				&.active
					color: $Black
				&:hover
					background-color: transparent
					color: $Gray700
</style>