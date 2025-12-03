/// Interacting with it creates a UI out of GLOB.glass_style_singletons
GLOBAL_LIST_INIT(glass_style_menu_data, initialize_drink_menu_styles())

/**
 * Makes a nested list of drink style data that we would be using for our menu
 *
 * Format:
 * list("[glass_style.type]" = list(
 * "name" = glass_style.name
 * "desc" = glass_style.desc
 * "recipe" = Recipe (if it exists) for glass_style reagent
 * "alcohol" = boozepwr ? boozepwr : 0
 * "icon" = glass_style.icon
 * "icon_state" = glass_style.icon_state
 * ))
 * The list uses glass_style.type instead of the name because some drinks might share the same name (i.e. Blood & Tomato Juice)
 *
 */
/proc/initialize_drink_menu_styles()
	var/list/singleton_containers = list(/obj/item/reagent_containers/cup/glass/drinkingglass, /obj/item/reagent_containers/cup/glass/drinkingglass/shotglass)
	for(var/container_type in singleton_containers)
		for(var/datum/glass_style/this_style in GLOB.glass_style_singletons[container_type])
			// Should HOPEFULLY return as null if it doesn't exist, otherwise this is a bit of an issue!
			var/drink_recipe = get_recipe_from_reagent_product(this_style.required_drink_type)
			// Assuming that all non-ethanol drinks are non-alcoholic
			var/alcoholism = 0
			if(istype(this_style.required_drink_type, /datum/reagent/consumable/ethanol))
				var/datum/reagent/consumable/ethanol/alcoholic_drink = this_style.required_drink_type
				alcoholism = alcoholic_drink.boozepwr

			GLOB.glass_style_menu_data["[this_style.type]"] = list(
				"name" = this_style.name,
				"desc" = this_style.desc,
				"recipe" = drink_recipe,
				"alcohol" = alcoholism,
				"icon" = this_style.icon,
				"icon_state" = this_style.icon_state,
				)

/obj/item/drink_menu
	name = "drinks menu"
	desc = "A fancy digital menu allowing for more effective inebriation."
	icon = 'maplestation_modules/icons/obj/service/kitchen.dmi'
	icon_state = "drink_menu"
	force = 2
	throwforce = 6
	w_class = WEIGHT_CLASS_SMALL

/obj/item/drink_menu/Initialize(mapload)
	. = ..()
	interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP
	AddElement(/datum/element/drag_pickup)


/obj/item/drink_menu/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(Adjacent(user))
		ui_interact(user)

/obj/item/drink_menu/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet_batched/drinks_menu),
	)

/datum/asset/spritesheet_batched/drinks_menu
	name = "drinks menu"

/datum/asset/spritesheet_batched/drinks_menu/create_spritesheets()
	for(var/list/style in GLOB.glass_style_menu_data)
		insert_icon("drinkmenu_asset_[style]", uni_icon(style["icon"], style["icon_state"]))

/obj/item/drink_menu/ui_interact(mob/user, datum/tgui/ui)
	. = ..()

	// Attempt to update tgui ui, open and update if needed.
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DrinkMenu", name)
		ui.open()

/obj/item/drink_menu/ui_data(mob/user)
	var/list/data = list()

	data["drinks"] = GLOB.glass_style_menu_data

	return data

