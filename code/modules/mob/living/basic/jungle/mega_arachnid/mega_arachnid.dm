//Large and powerful, but timid. It won't engage anything above 50 health, or anything without legcuffs.
//It can fire fleshy snares that legcuff anyone that it hits, making them look especially tasty to the arachnid.
/mob/living/basic/mega_arachnid
	name = "mega arachnid"
	desc = "Though physically imposing, it prefers to ambush its prey, and it will only engage with an already crippled opponent."
	icon = 'icons/mob/simple/jungle/arachnid.dmi'
	icon_state = "arachnid"
	icon_living = "arachnid"
	icon_dead = "arachnid_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	melee_damage_lower = 30
	melee_damage_upper = 30
	maxHealth = 300
	health = 300

	pixel_x = -16
	base_pixel_x = -16

	habitable_atmos = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	faction = list(FACTION_JUNGLE)
	obj_damage = 30
	environment_smash = ENVIRONMENT_SMASH_WALLS
	bodytemp_cold_damage_limit = T0C
	bodytemp_heat_damage_limit = T0C + 450
	status_flags = NONE
	lighting_cutoff_red = 5
	lighting_cutoff_green = 20
	lighting_cutoff_blue = 25
	mob_size = MOB_SIZE_HUGE

	speak_emote = list("chitters")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	sharpness = SHARP_EDGED
	wound_bonus = 0
	ai_controller = /datum/ai_controller/basic_controller/mega_arachnid
	alpha = 40

/mob/living/basic/mega_arachnid/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/mob_cooldown/secrete_acid = BB_ARACHNID_SLIP,
		/datum/action/cooldown/spell/pointed/projectile/flesh_restraints = BB_ARACHNID_RESTRAIN,
	)
	grant_actions_by_list(innate_actions)

	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MEGA_ARACHNID, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	AddComponent(/datum/component/seethrough_mob)
	AddComponent(/datum/component/appearance_on_aggro, alpha_on_aggro = 255, alpha_on_deaggro = alpha)
	AddComponent(/datum/component/tree_climber, climbing_distance = 15)

/mob/living/basic/mega_arachnid/Login()
	. = ..()
	if(!. || !client)
		return FALSE

	animate(src, alpha = 255, time = 2 SECONDS) //make them visible
