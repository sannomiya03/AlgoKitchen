Paper = require "./Paper.coffee"
module.exports = class Material
	constructor: (source) ->
		@base = if source?.base? then source.base else new Paper({height:1100, width:800, price: 100})
		@inside = if source?.inside? then source.inside else new Paper({height:1100, width:800, price: 300})
		@wrap = if source?.wrap? then source.wrap else new Paper({height:1100, width:800, price: 20})