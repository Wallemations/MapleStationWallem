/obj/projectile/energy/net
	name = "energy netting"
	icon_state = "e_netting"
	damage = 10
	damage_type = PAIN
	hitsound = 'sound/weapons/taserhit.ogg'
	range = 10

/obj/projectile/energy/net/Initialize(mapload)
	. = ..()
	SpinAnimation()

/obj/projectile/energy/net/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isliving(target))
		var/turf/Tloc = get_turf(target)
		if(!locate(/obj/effect/nettingportal) in Tloc)
			new /obj/effect/nettingportal(Tloc)
	..()

/obj/projectile/energy/net/on_range()
	do_sparks(1, TRUE, src)
	..()

/obj/effect/nettingportal
	name = "DRAGnet teleportation field"
	desc = "A field of bluespace energy, locking on to teleport a target."
	icon = 'icons/effects/effects.dmi'
	icon_state = "dragnetfield"
	light_range = 3
	anchored = TRUE

/obj/effect/nettingportal/Initialize(mapload)
	. = ..()
	var/obj/item/beacon/teletarget = null
	for(var/obj/machinery/computer/teleporter/com as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/computer/teleporter))
		var/atom/target = com.target_ref?.resolve()
		if(target)
			if(com.power_station && com.power_station.teleporter_hub && com.power_station.engaged)
				teletarget = target
		else
			com.target_ref = null

	addtimer(CALLBACK(src, PROC_REF(pop), teletarget), 3 SECONDS)

/obj/effect/nettingportal/proc/pop(teletarget)
	if(teletarget)
		for(var/mob/living/L in get_turf(src))
			do_teleport(L, teletarget, 2, channel = TELEPORT_CHANNEL_BLUESPACE)//teleport what's in the tile to the beacon
	else
		for(var/mob/living/L in get_turf(src))
			do_teleport(L, L, 15, channel = TELEPORT_CHANNEL_BLUESPACE) //Otherwise it just warps you off somewhere.

	qdel(src)

/obj/effect/nettingportal/singularity_act()
	return

/obj/effect/nettingportal/singularity_pull()
	return

/obj/projectile/energy/trap
	name = "energy snare"
	icon_state = "e_snare"
	hitsound = 'sound/weapons/taserhit.ogg'
	range = 4

/obj/projectile/energy/trap/on_hit(atom/target, blocked = 0, pierce_hit)
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - drop a trap
		new/obj/item/restraints/legcuffs/beartrap/energy(get_turf(loc))
	else if(iscarbon(target))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy(get_turf(target))
		B.spring_trap(target)
	. = ..()

/obj/projectile/energy/trap/on_range()
	new /obj/item/restraints/legcuffs/beartrap/energy(loc)
	..()

/obj/projectile/energy/trap/cyborg
	name = "Energy Bola"
	icon_state = "e_snare"
	hitsound = 'sound/weapons/taserhit.ogg'
	range = 10

/obj/projectile/energy/trap/cyborg/on_hit(atom/target, blocked = 0, pierce_hit)
	if(!ismob(target) || blocked >= 100)
		do_sparks(1, TRUE, src)
		qdel(src)
	if(iscarbon(target))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy/cyborg(get_turf(target))
		B.spring_trap(target)
	QDEL_IN(src, 10)
	. = ..()

/obj/projectile/energy/trap/cyborg/on_range()
	do_sparks(1, TRUE, src)
	qdel(src)
