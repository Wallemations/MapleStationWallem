/**
 * # The path of Moon.
 *
 * Goes as follows:
 *
 * Moonlight Troupe
 * Grasp of Lunacy
 * Smile of the moon
 * > Sidepaths:
 *   Mind Gate
 *   Ashen Eyes
 *
 * Mark of Moon
 * Ritual of Knowledge
 * Lunar Parade
 * Moonlight Amulette
 * > Sidepaths:
 *   Curse of Paralasys
 *   Unfathomable Curio
 * 	 Unsealed Arts
 *
 * Moonlight blade
 * Ringleaders Rise
 * > Sidepaths:
 *   Ashen Ritual
 *
 * Last Act
 */
/datum/heretic_knowledge/limited_amount/starting/base_moon
	name = "Moonlight Troupe"
	desc = "Opens up the Path of Moon to you. \
		Allows you to transmute 2 sheets of iron and a knife into an Lunar Blade. \
		You can only create two at a time."
	gain_text = "Under the light of the moon the laughter echoes."
	next_knowledge = list(/datum/heretic_knowledge/moon_grasp)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/iron = 2,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/moon)
	route = PATH_MOON
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "moon_blade"

/datum/heretic_knowledge/base_moon/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	add_traits(user ,TRAIT_EMPATH, REF(src))

/datum/heretic_knowledge/moon_grasp
	name = "Grasp of Lunacy"
	desc = "Your Mansus Grasp will cause them to hallucinate everyone as lunar mass, \
		and hides your identity for a short dur	ation."
	gain_text = "The troupe on the side of the moon showed me truth, and I took it."
	next_knowledge = list(/datum/heretic_knowledge/spell/moon_smile)
	cost = 1
	route = PATH_MOON
	depth = 3
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "grasp_moon"

/datum/heretic_knowledge/moon_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/moon_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK)

/datum/heretic_knowledge/moon_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER
	source.apply_status_effect(/datum/status_effect/moon_grasp_hide)

	if(!iscarbon(target))
		return
	var/mob/living/carbon/carbon_target = target
	to_chat(carbon_target, span_danger("You hear echoing laughter from above"))
	carbon_target.cause_hallucination(/datum/hallucination/delusion/preset/moon, "delusion/preset/moon hallucination caused by mansus grasp")
	carbon_target.mob_mood.set_sanity(carbon_target.mob_mood.sanity-20)

/datum/heretic_knowledge/spell/moon_smile
	name = "Smile of the moon"
	desc = "Grants you Smile of the moon, a ranged spell muting, blinding and deafening the target for a\
		duration based on their sanity."
	gain_text = "The moon smiles upon us all and those who see its true side can bring its joy."
	next_knowledge = list(
		/datum/heretic_knowledge/mark/moon_mark,
		/datum/heretic_knowledge/medallion,
		/datum/heretic_knowledge/spell/mind_gate,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/moon_smile
	cost = 1
	route = PATH_MOON
	depth = 4

/datum/heretic_knowledge/mark/moon_mark
	name = "Mark of Moon"
	desc = "Your Mansus Grasp now applies the Mark of Moon. The mark is triggered from an attack with your Moon Blade. \
		When triggered, the victim is confused, and when the mark is applied they are pacified \
		until attacked."
	gain_text = "The troupe on the moon would dance all day long \
		and in that dance the moon would smile upon us \
		but when the night came its smile would dull forced to gaze on the earth."
	next_knowledge = list(/datum/heretic_knowledge/knowledge_ritual/moon)
	route = PATH_MOON
	mark_type = /datum/status_effect/eldritch/moon

/datum/heretic_knowledge/mark/moon_mark/trigger_mark(mob/living/source, mob/living/target)
	. = ..()
	if(!.)
		return

	// Also refunds 75% of charge!
	var/datum/action/cooldown/spell/touch/mansus_grasp/grasp = locate() in source.actions
	if(grasp)
		grasp.next_use_time = min(round(grasp.next_use_time - grasp.cooldown_time * 0.75, 0), 0)
		grasp.build_all_button_icons()

/datum/heretic_knowledge/knowledge_ritual/moon
	next_knowledge = list(/datum/heretic_knowledge/spell/moon_parade)
	route = PATH_MOON

/datum/heretic_knowledge/spell/moon_parade
	name = "Lunar Parade"
	desc = "Grants you Lunar Parade, a spell that - after a short charge - sends a carnival forward \
		when hitting someone they are forced to join the parade and suffer hallucinations."
	gain_text = "The music like a reflection of the soul compelled them, like moths to a flame they followed"
	next_knowledge = list(
		/datum/heretic_knowledge/moon_amulette,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/unfathomable_curio,
		/datum/heretic_knowledge/curse/paralysis,
		/datum/heretic_knowledge/painting,
		)
	spell_to_add = /datum/action/cooldown/spell/pointed/projectile/moon_parade
	cost = 1
	route = PATH_MOON
	depth = 7


/datum/heretic_knowledge/moon_amulette
	name = "Moonlight Amulette"
	desc = "Allows you to transmute 2 sheets of glass, a pair of eyes, a brain and a tie \
			if the item is used on someone with low sanity they go berserk attacking everyone \
			, if their sanity isnt low enough it decreases their mood."
	gain_text = "At the head of the parade he stood, the moon condensed into one mass, a reflection of the soul."
	next_knowledge = list(/datum/heretic_knowledge/blade_upgrade/moon)
	required_atoms = list(
		/obj/item/organ/internal/eyes = 1,
		/obj/item/organ/internal/heart = 1,
		/obj/item/stack/sheet/glass = 2,
		/obj/item/clothing/neck/tie = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/heretic_focus/moon_amulette)
	cost = 1
	route = PATH_MOON
	depth = 8
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "moon_amulette"
	research_tree_icon_frame = 9

/datum/heretic_knowledge/blade_upgrade/moon
	name = "Moonlight Blade"
	desc = "Your blade now deals brain damage, causes  random hallucinations and does sanity damage."
	gain_text = "His wit was sharp as a blade, cutting through the lie to bring us joy."
	next_knowledge = list(/datum/heretic_knowledge/spell/moon_ringleader)
	cost = 1
	route = PATH_MOON
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_moon"

/datum/heretic_knowledge/blade_upgrade/moon/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target)
		return

	target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 100)
	target.cause_hallucination( \
			get_random_valid_hallucination_subtype(/datum/hallucination/body), \
			"upgraded path of moon blades", \
		)
	target.emote(pick("giggle", "laugh"))
	target.mob_mood.set_sanity(target.mob_mood.sanity - 10)

/datum/heretic_knowledge/spell/moon_ringleader
	name = "Ringleaders Rise"
	desc = "Grants you Ringleaders Rise, an aoe spell that deals more brain damage the lower the sanity of everyone in the AoE,\
			causes hallucinations with those who have less sanity getting more. \
			If their sanity is low enough turns them insane, the spell then halves their sanity."
	gain_text = "I grabbed his hand and we rose, those who saw the truth rose with us. \
		The ringleader pointed up and the dim light of truth illuminated us further."
	next_knowledge = list(
		/datum/heretic_knowledge/ultimate/moon_final,
		/datum/heretic_knowledge/summon/ashy,
	)
	spell_to_add = /datum/action/cooldown/spell/aoe/moon_ringleader
	cost = 1
	route = PATH_MOON
	depth = 10
	research_tree_icon_frame = 5

/datum/heretic_knowledge/ultimate/moon_final
	name = "The Last Act"
	desc = "The ascension ritual of the Path of Moon. \
		Bring 3 corpses with more than 50 brain damage to a transmutation rune to complete the ritual. \
		When completed, you become a harbinger of madness gaining and aura of passive sanity decrease \
		, confusion increase and if their sanity is low enough brain damage and blindness. \
		1/5th of the crew will turn into acolytes and follow your command, they will all recieve moonlight amulettes."
	gain_text = "We dived down towards the crowd, his soul splitting off in search of greater venture \
		for where the Ringleader had started the parade, I shall continue it unto the suns demise \
		WITNESS MY ASCENSION, THE MOON SMILES ONCE MORE AND FOREVER MORE IT SHALL!"
	route = PATH_MOON
	ascension_achievement = /datum/award/achievement/misc/moon_ascension

/datum/heretic_knowledge/ultimate/moon_final/is_valid_sacrifice(mob/living/sacrifice)

	var/brain_damage = sacrifice.get_organ_loss(ORGAN_SLOT_BRAIN)
	// Checks if our target has enough brain damage
	if(brain_damage < 50)
		return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/moon_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	priority_announce("[generate_heretic_text()] Laugh, for the ringleader [user.real_name] has ascended! \
					The truth shall finally devour the lie! [generate_heretic_text()]","[generate_heretic_text()]", ANNOUNCER_SPANOMALIES)

	ADD_TRAIT(user, TRAIT_MADNESS_IMMUNE, REF(src))

	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))

	// Roughly 1/5th of the station will rise up as lunatics to the heretic
	for (var/mob/living/carbon/human/crewmate as anything in GLOB.human_list)
		// How many lunatics we have
		var/amount_of_lunatics = 0
		// Where the crewmate is, used to check their z-level
		var/turf/crewmate_turf = get_turf(crewmate)
		var/crewmate_z = crewmate_turf?.z
		if(isnull(crewmate.mind))
			continue
		if(crewmate.stat != CONSCIOUS)
			continue
		if(!is_station_level(crewmate_z))
			continue
		// Heretics, lunatics and monsters shouldn't become lunatics because they either have a master or have a mansus grasp
		if(IS_HERETIC_OR_MONSTER(crewmate))
			to_chat(crewmate, span_boldwarning("[user]'s rise is influencing those who are weak willed. Their minds shall rend." ))
			continue
		// Mindshielded and anti-magic folks are immune against this effect because this is a magical mind effect
		if(HAS_TRAIT(crewmate, TRAIT_MINDSHIELD) || crewmate.can_block_magic(MAGIC_RESISTANCE))
			to_chat(crewmate, span_boldwarning("You feel shielded from something." ))
			continue
		if(amount_of_lunatics > length(GLOB.human_list) * 0.2)
			to_chat(crewmate, span_boldwarning("You feel uneasy, as if for a brief moment something was gazing at you." ))
			continue
		var/datum/antagonist/lunatic/lunatic = crewmate.mind.add_antag_datum(/datum/antagonist/lunatic)
		lunatic.set_master(user.mind, user)
		var/obj/item/clothing/neck/heretic_focus/moon_amulette/moon_amulette = new
		crewmate.put_in_active_hand(moon_amulette)
		crewmate.emote("laugh")
		amount_of_lunatics += 1

/datum/heretic_knowledge/ultimate/moon_final/proc/on_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	visible_hallucination_pulse(
		center = get_turf(source),
		radius = 7,
		hallucination_duration = 60 SECONDS
	)

	for(var/mob/living/carbon/carbon_view in view(5, source))
		var/carbon_sanity = carbon_view.mob_mood.sanity
		if(carbon_view.stat != CONSCIOUS)
			continue
		if(IS_HERETIC_OR_MONSTER(carbon_view))
			continue
		carbon_view.adjust_confusion(2 SECONDS)
		carbon_view.mob_mood.set_sanity(carbon_sanity - 5)
		if(carbon_sanity < 30)
			if(SPT_PROB(20, seconds_per_tick))
				to_chat(carbon_view, span_warning("you feel your mind beginning to rend!"))
			carbon_view.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
		if(carbon_sanity < 10)
			if(SPT_PROB(20, seconds_per_tick))
				to_chat(carbon_view, span_warning("it echoes through you!"))
			visible_hallucination_pulse(
				center = get_turf(carbon_view),
				radius = 7,
				hallucination_duration = 50 SECONDS
			)
			carbon_view.adjust_temp_blindness(5 SECONDS)
