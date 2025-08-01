//Head surgery to fix the ears organ
/datum/surgery/ear_surgery
	name = "Ear surgery"
	requires_bodypart_type = NONE
	organ_to_manipulate = ORGAN_SLOT_EARS
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/fix_ears,
		/datum/surgery_step/close,
	)

//fix ears
/datum/surgery_step/fix_ears
	name = "fix ears (hemostat)"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_SCREWDRIVER = 45,
		/obj/item/pen = 25)
	time = 64

/datum/surgery/ear_surgery/can_start(mob/user, mob/living/carbon/target)
	return target.get_organ_slot(ORGAN_SLOT_EARS) && ..()

/datum/surgery_step/fix_ears/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to fix [target]'s ears..."),
		span_notice("[user] begins to fix [target]'s ears."),
		span_notice("[user] begins to perform surgery on [target]'s ears."),
	)
	display_pain(
		target = target,
		target_zone = target_zone,
		pain_message = "You feel a dizzying pain in your [parse_zone(target_zone)]!",
		pain_amount = SURGERY_PAIN_TRIVIAL,
	)

/datum/surgery_step/fix_ears/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/organ/internal/ears/target_ears = target.get_organ_slot(ORGAN_SLOT_EARS)
	display_results(
		user,
		target,
		span_notice("You succeed in fixing [target]'s ears."),
		span_notice("[user] successfully fixes [target]'s ears!"),
		span_notice("[user] completes the surgery on [target]'s ears."),
	)
	display_pain(
		target = target,
		target_zone = target_zone,
		pain_message = "Your [parse_zone(target_zone)] swims, but it seems like you can feel your hearing coming back!",
		pain_amount = SURGERY_PAIN_TRIVIAL,
	)
	target_ears.adjustEarDamage(-INFINITY, rand(16, 24))
	return ..()

/datum/surgery_step/fix_ears/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_by_type(/obj/item/organ/internal/brain))
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(
			target = target,
			target_zone = target_zone,
			pain_message = "You feel a visceral stabbing pain right through your head, [parse_zone(target_zone)] into your brain!",
			pain_amount = SURGERY_PAIN_TRIVIAL,
		)
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
	else
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(
			target = target,
			target_zone = target_zone,
			pain_message = "You feel a visceral stabbing pain right through your head [parse_zone(target_zone)]!",
			pain_amount = SURGERY_PAIN_TRIVIAL,
		)
	return FALSE
