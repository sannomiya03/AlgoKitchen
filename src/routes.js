import Top from "./pages/top"
import Recipe from "./pages/recipe"
import RecipeNew from "./pages/recipe/new"

export default {
	mode: "history",
	routes: [
		{ path: "/", component: Top, name: "top" },
		{ path: "/recipe", component: Recipe, name: "recipe" },
		{ path: "/recipe/:recipe_id", component: Recipe, name: "recipe" },
		{ path: "/recipe/new", component: RecipeNew, name: "new_recipe" },
	]
}