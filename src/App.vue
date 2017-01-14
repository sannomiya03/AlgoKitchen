<template lang="pug">
	section#app
		header.app-header
			h1 Algo Kitchen
		main.app-body
			router-view
</template>

<style lang="sass">
	@import "./sass/colors"
	@import "./sass/base"
	@import "./sass/module"
	
	$app-bg-color: #FBFCFF
	$headerHeight: 50px

	html, body, #app
		position: relative
		width: 100%
		height: 100%
		background-color: $app-bg-color

	.app-header
		position: fixed
		top: 0
		left: 0
		width: 100%
		height: $headerHeight
		display: flex
		align-items: center
		background-color: $White
		border-bottom: 1.5px solid $Gray300
		z-index: 8000

	.app-body
		position: relative
		height: 100%
		padding-top: $headerHeight
		overflow: hidden

	.app-header
		padding-left: 20px
		// background-color: #A1DCE6
		nav
			height: 100%
			ul
				display: flex
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
						&.router-link-active
							// background-color: #72D4E5
							// background-color: transparent
							color: $Teal800
	.logo
		position: relative
		top: 3px
		height: 30px
</style>
