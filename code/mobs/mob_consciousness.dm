/mob/proc/PassOut(var/outside_life_loop)
	if(!prone)
		ToggleProne()
	if(outside_life_loop)
		UpdateVision()
