/datum/job/detective
	title = JOB_DETECTIVE
	description = "Investigate crimes, gather evidence, perform interrogations, \
		look badass, smoke cigarettes."
	title_options = list(
		"Investigator",
		"Inspector",
		"Sheriff" = /datum/outfit/job/detective/sheriff,
	)
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_HEAD_OF_SECURITY)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_HOS
	minimal_player_age = 7
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "DETECTIVE"

	base_outfit = /datum/outfit/job/detective
	plasmaman_outfit = /datum/outfit/plasmaman/detective
	departments_list = list(
		/datum/job_department/security,
		)

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_DETECTIVE

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes = 25,
		/obj/item/ammo_box/c38 = 25,
		/obj/item/ammo_box/c38/dumdum = 5,
		/obj/item/ammo_box/c38/hotshot = 5,
		/obj/item/ammo_box/c38/iceblox = 5,
		/obj/item/ammo_box/c38/match = 5,
		/obj/item/ammo_box/c38/trac = 5,
		/obj/item/storage/belt/holster/detective/full = 1
	)

	family_heirlooms = list(/obj/item/reagent_containers/cup/glass/bottle/whiskey)
	rpg_title = "Thiefcatcher" //I guess they caught them all rip thief...
	job_flags = STATION_JOB_FLAGS

	job_tone = "objection"


/datum/outfit/job/detective
	name = "Detective"
	jobtype = /datum/job/detective

	id_trim = /datum/id_trim/job/detective
	uniform = /obj/item/clothing/under/rank/security/detective
	suit = /obj/item/clothing/suit/jacket/det_suit
	backpack_contents = list(
		/obj/item/detective_scanner = 1,
		/obj/item/melee/baton = 1,
		/obj/item/storage/box/evidence = 1,
		)
	belt = /obj/item/modular_computer/pda/detective
	ears = /obj/item/radio/headset/headset_sec/alt
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/fedora/det_hat
	mask = /obj/item/clothing/mask/cigarette
	neck = /obj/item/clothing/neck/tie/detective
	shoes = /obj/item/clothing/shoes/sneakers/brown
	l_pocket = /obj/item/toy/crayon/white
	r_pocket = /obj/item/lighter

	chameleon_extras = list(
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/gun/ballistic/revolver/c38/detective,
		)
	implants = list(/obj/item/implant/mindshield)
	
	skillchips = list(/obj/item/skillchip/job/detectives_taste)

/datum/outfit/job/detective/pre_equip(mob/living/carbon/human/human, visualsOnly = FALSE)
	. = ..()
	if (human.age < AGE_MINOR)
		mask = /obj/item/clothing/mask/cigarette/candy
		head = /obj/item/clothing/head/fedora/det_hat/minor

/datum/outfit/job/detective/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	var/obj/item/clothing/mask/cigarette/cig = H.wear_mask
	if(istype(cig)) //Some species specfic changes can mess this up (plasmamen)
		cig.light("")

	if(visualsOnly)
		return

/datum/outfit/job/detective/sheriff
	name = "Sheriff"
	shoes = /obj/item/clothing/shoes/cowboy/sheriff
	head = /obj/item/clothing/head/cowboy/brown
	mask = /obj/item/clothing/mask/facescarf
	suit = /obj/item/clothing/suit/costume/poncho/sheriff
	id_trim = /datum/id_trim/job/detective/sheriff
