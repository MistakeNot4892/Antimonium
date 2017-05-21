/turf
	layer = TURF_LAYER
	luminosity = 1
	flags = FLAG_TEMPERATURE_SENSITIVE | FLAG_SIMULATED

/turf/proc/GetSimulatedAtoms()
	var/list/valid_targets = list()
	for(var/thing in contents)
		var/atom/target = thing
		if(istype(target) && (target.flags & FLAG_SIMULATED))
			valid_targets += target
	return valid_targets

/turf/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	HandleInteraction(clicker, slot)

/turf/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	HandleInteraction(clicker, slot)

/turf/proc/HandleInteraction(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	if(IsAdjacentTo(get_turf(clicker), src) && clicker.GetEquipped(slot))
		AttackedBy(clicker, clicker.GetEquipped(slot))

/turf/AttackedBy(var/mob/user, var/obj/item/prop)
	if(user.intent.selecting == INTENT_HARM)
		var/list/valid_targets = GetSimulatedAtoms()
		if(!valid_targets.len) return
		var/atom/thing = pick(valid_targets)
		thing.AttackedBy(user, prop)

/turf/GetWeight()
	return 10

/turf/proc/GetFootstepSound(var/mob/walker)
	return 'sounds/effects/footstep1.wav'

/turf/proc/GetSoundEnvironment()
	return -1
