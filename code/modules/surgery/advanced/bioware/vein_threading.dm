/datum/surgery/advanced/bioware/vein_threading
	name = "Vein Threading"
	desc = "A surgical procedure which severely reduces the amount of blood lost in case of injury."
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/incise,
		/datum/surgery_step/thread_veins,
		/datum/surgery_step/close,
	)

	bioware_target = BIOWARE_CIRCULATION

/datum/surgery_step/thread_veins
	name = "thread veins (hand)"
	accept_hand = TRUE
	time = 125

/datum/surgery_step/thread_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start weaving [target]'s circulatory system."),
		span_notice("[user] starts weaving [target]'s circulatory system."),
		span_notice("[user] starts manipulating [target]'s circulatory system."),
	)
	display_pain(
		target = target,
		target_zone = BODY_ZONES_ALL,
		pain_message = "Your entire body burns in agony!",
		pain_amount = SURGERY_PAIN_MEDIUM,
		pain_type = BURN,
		pain_overlay_severity = 2,
		surgery_moodlet = /datum/mood_event/surgery/major,
	)
	target.cause_pain(BODY_ZONES_ALL, 25, BURN) // NON-MODULE CHANGE

/datum/surgery_step/thread_veins/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You weave [target]'s circulatory system into a resistant mesh!"),
		span_notice("[user] weaves [target]'s circulatory system into a resistant mesh!"),
		span_notice("[user] finishes manipulating [target]'s circulatory system."),
	)
	display_pain(
		target = target,
		target_zone = BODY_ZONES_ALL,
		pain_message = "You can feel your blood pumping through reinforced veins!",
		surgery_moodlet = /datum/mood_event/surgery/major,
	)
	new /datum/bioware/threaded_veins(target)
	return ..()

/datum/bioware/threaded_veins
	name = "Threaded Veins"
	desc = "The circulatory system is woven into a mesh, severely reducing the amount of blood lost from wounds."
	mod_type = BIOWARE_CIRCULATION

/datum/bioware/threaded_veins/on_gain()
	..()
	owner.physiology.bleed_mod *= 0.25

/datum/bioware/threaded_veins/on_lose()
	..()
	owner.physiology.bleed_mod *= 4
