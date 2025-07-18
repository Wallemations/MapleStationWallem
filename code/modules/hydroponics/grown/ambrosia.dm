// Ambrosia - base type
/obj/item/food/grown/ambrosia
	seed = /obj/item/seeds/ambrosia
	name = "ambrosia branch"
	desc = "This is a plant."
	icon_state = "ambrosiavulgaris"
	slot_flags = ITEM_SLOT_HEAD
	bite_consumption_mod = 3
	foodtypes = VEGETABLES
	tastes = list("ambrosia" = 1)
	drop_sound = 'maplestation_modules/sound/items/drop/herb.ogg'
	pickup_sound = 'maplestation_modules/sound/items/pickup/herb.ogg'

// Ambrosia Vulgaris
/obj/item/seeds/ambrosia
	name = "ambrosia vulgaris seed pack"
	desc = "These seeds grow into common ambrosia, a plant grown by and from medicine."
	icon_state = "seed-ambrosiavulgaris"
	plant_icon_offset = 0
	species = "ambrosiavulgaris"
	plantname = "Ambrosia Vulgaris"
	product = /obj/item/food/grown/ambrosia/vulgaris
	lifespan = 60
	endurance = 25
	yield = 6
	potency = 5
	instability = 30
	icon_dead = "ambrosia-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/ambrosia/deus)
	reagents_add = list(/datum/reagent/medicine/c2/aiuri = 0.1, /datum/reagent/medicine/c2/libital = 0.1 ,/datum/reagent/drug/space_drugs = 0.15, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/toxin = 0.1)

/obj/item/food/grown/ambrosia/vulgaris
	seed = /obj/item/seeds/ambrosia
	name = "ambrosia vulgaris branch"
	desc = "This is a plant containing various healing chemicals."
	wine_power = 30

// Ambrosia Deus
/obj/item/seeds/ambrosia/deus
	name = "ambrosia deus seed pack"
	desc = "These seeds grow into ambrosia deus. Could it be the food of the gods..?"
	icon_state = "seed-ambrosiadeus"
	species = "ambrosiadeus"
	plantname = "Ambrosia Deus"
	product = /obj/item/food/grown/ambrosia/deus
	mutatelist = list(/obj/item/seeds/ambrosia/gaia)
	reagents_add = list(/datum/reagent/medicine/omnizine = 0.15, /datum/reagent/medicine/synaptizine = 0.15, /datum/reagent/drug/space_drugs = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.05)
	rarity = 40

/obj/item/food/grown/ambrosia/deus
	seed = /obj/item/seeds/ambrosia/deus
	name = "ambrosia deus branch"
	desc = "Eating this makes you feel immortal!"
	icon_state = "ambrosiadeus"
	wine_power = 50

//Ambrosia Gaia
/obj/item/seeds/ambrosia/gaia
	name = "ambrosia gaia seed pack"
	desc = "These seeds grow into ambrosia gaia, filled with infinite potential."
	icon_state = "seed-ambrosia_gaia"
	species = "ambrosia_gaia"
	plantname = "Ambrosia Gaia"
	product = /obj/item/food/grown/ambrosia/gaia
	mutatelist = list(/obj/item/seeds/ambrosia/deus)
	reagents_add = list(/datum/reagent/medicine/earthsblood = 0.05, /datum/reagent/consumable/nutriment = 0.06, /datum/reagent/consumable/nutriment/vitamin = 0.05)
	rarity = 30 //These are some pretty good plants right here
	genes = list()
	weed_rate = 4
	weed_chance = 100

/obj/item/food/grown/ambrosia/gaia
	name = "ambrosia gaia branch"
	desc = "Eating this <i>makes</i> you immortal."
	icon_state = "ambrosia_gaia"
	light_system = MOVABLE_LIGHT
	light_range = 3
	seed = /obj/item/seeds/ambrosia/gaia
	wine_power = 70
	wine_flavor = "the earthmother's blessing"
