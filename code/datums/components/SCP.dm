/datum/component/scp
	var/datum/scp/SCP

/datum/component/scp/New(datum/P, ...)
	. = ..()
	if(istype(args[2], /datum/scp))
		SCP = args[2]