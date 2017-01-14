module.exports = 
	task: [
			{ title: "生地裁断", aveTime:3.3, avePersons: 1, hourlyWage: null }
			{ title: "合紙", aveTime:3.3, avePersons: 2, hourlyWage: null }
			{ title: "自動罫線機", aveTime:5.3, avePersons: 1, hourlyWage: null }
			{ title: "手動罫線機", aveTime:8, avePersons: 1, hourlyWage: null }
			{ title: "自動角切り機", aveTime:8, avePersons: 1, hourlyWage: null }
			{ title: "コマ付け", aveTime:8.7, avePersons: 2, hourlyWage: null }
			{ title: "テープ止め（一段）", aveTime:4.6, avePersons: 1, hourlyWage: null }
			{ title: "テープ止め（二段）", aveTime:8.2, avePersons: 1, hourlyWage: null }
			{ title: "貼紙裁断", aveTime:1.5, avePersons: 1, hourlyWage: null }
			{ title: "はす切り", aveTime:1.7, avePersons: 1, hourlyWage: null }
			{ title: "天貼り", aveTime:4.2, avePersons: 5, hourlyWage: null }
			{ title: "底貼り", aveTime:4.2, avePersons: 5, hourlyWage: null }
			{ title: "ラッパー準備", aveTime:1, avePersons: 1, hourlyWage: null }
			{ title: "ラッパー", aveTime:4.7, avePersons: 3, hourlyWage: null }
			{ title: "くるみ機準備", aveTime:2, avePersons: 1, hourlyWage: null }
			{ title: "くるみ機", aveTime:5.6, avePersons: 5.2, hourlyWage: null }
			{ title: "くるみ（手作業）", aveTime:8.8, avePersons: 4, hourlyWage: null }
			{ title: "一本巻き", aveTime:14.6, avePersons: 4.25, hourlyWage: null }
			{ title: "二本巻き", aveTime:14.6, avePersons: 4.25, hourlyWage: null }
		]
	option: [
			{ title: "合口", price:5.2, num: 1, active: true }
			{ title: "結束", price:3.0, num: 1, active: true }
			{ title: "泊押し", price: 100, num: 1, active:false }
			{ title: "仕切り", price: 100, num: 1, active:false }
			{ title: "台付け", price: 100, num: 1, active:false }
			{ title: "マグネット", price: 100, num: 1, active:false }
		]
	fork: [
			{ 
				title: "合紙"
				params: [
					"合紙: する"
				]
				statements: [
					"if 合紙 is しない then return 0"
					"if 合紙 is する then return 1"
				]
				outputs: [
					[]
					["Task 合紙"]
				]
			}
			{ 
				title: "生地裁断"
				params: [
					"自動罫線機の使用: 可能"
				]
				statements: [
					"if 自動罫線機の使用 is 可能 then return 0"
					"if 自動罫線機の使用 is 不可 then return 1"
				]
				outputs: [
					["Task 生地裁断", "Task 自動罫線機"]
					["Task 生地裁断", "Task 手動罫線機", "Task 自動角切り機"]
				]
			}
			{
				title: "コマ付け"
				params: [
					"コマ付け: しない"
				]
				statements: [
					"if コマ付け is する then return 0"
					"if コマ付け is しない then return 1"
				]
				outputs: [
					["Task コマ付け"]
					[]
				]
			}
			{
				title: "テープ止め"
				params: [
					"テープ数: 1段打ち"
				]
				statements: [
					"if テープ数 is 止めない then return 0"
					"if テープ数 is 1段打ち then return 1"
					"if テープ数 is 2段打ち then return 2"
				]
				outputs: [
					[]
					["Task テープ止め（一段）"]
					["Task テープ止め（二段）"]
				]
			}
			{
				title: "貼紙裁断"
				params: [
					"コマ付け: しない"
				]
				statements: [
					"if コマ付け is する then return 0"
					"if コマ付け is しない then return 1"
				]
				outputs: [
					["Task 貼紙裁断"]
					["Task 貼紙裁断", "Task はす切り"]
				]
			}
			{
				title: "包み"
				params: [
					"包み方: 手作業"
				]
				statements: [
					"if 包み方 is ラッパー then return 0"
					"if 包み方 is くるみ機 then return 1"
					"if 包み方 is 手作業 then return 2"
				]
				outputs: [
					["Task ラッパー準備", "Task ラッパー"]
					["Task くるみ機準備", "Task くるみ機"]
					["Task くるみ（手作業）"]
				]
			}
			{
				title: "巻き"
				params: [
					"巻き方: 一本巻き"
				]
				statements: [
					"if 巻き方 is 一本巻き then return 0"
					"if 巻き方 is 二本巻き then return 1"
				]
				outputs: [
					["Task 一本巻き"]
					["Task 二本巻き"]
				]
			}
			{
				title: "天貼り"
				params: [
					"天貼り: しない"
				]
				statements: [
					"if 天貼り is しない then return 0"
					"if 天貼り is する then return 1"
				]
				outputs: [
					[]
					["Task 天貼り"]
				]
			}
			{
				title: "底貼り"
				params: [
					"底貼り: しない"
				]
				statements: [
					"if 底貼り is しない then return 0"
					"if 底貼り is する then return 1"
				]
				outputs: [
					[]
					["Task 底貼り"]
				]
			}
			{
				title: "紙貼り"
				params: [
					"貼り方: 巻き"
				]
				statements: [
					"if 貼り方 is 包み then return 0"
					"if 貼り方 is 巻き then return 1"
				]
				outputs: [
					["Fork 包み"]
					["Fork 巻き","Fork 天貼り","Fork 底貼り"]
				]
			}
		]
	flow: [
		title: "貼箱制作フロー"
		forks: ["合紙", "生地裁断", "コマ付け", "テープ止め", "貼紙裁断", "紙貼り"]
	]
	recipe: [
			{
				title: "ラッパー"
				flow: "貼箱制作フロー"
				fixedParams: ["貼り方: 包み", "包み方: ラッパー"]
			}
			{
				title: "くるみ機"
				flow: "貼箱制作フロー"
				fixedParams: ["貼り方: 包み", "包み方: くるみ機"]
			}
			{
				title: "手作業"
				flow: "貼箱制作フロー"
				fixedParams: ["貼り方: 包み", "包み方: 手作業"]
			}
			{
				title: "一本巻き"
				flow: "貼箱制作フロー"
				fixedParams: ["貼り方: 巻き", "巻き方: 一本巻き"]
			}
			{
				title: "二本巻き"
				flow: "貼箱制作フロー"
				fixedParams: ["貼り方: 巻き", "巻き方: 二本巻き"]
			}
		]