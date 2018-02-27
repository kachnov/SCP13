#define SAFE 1
#define EUCLID 2
#define KETER 3
#define THAUMIEL 4
#define NEUTRALIZED 5

/datum/scp
	var/name = "SCP-NULL"
	var/designation = "0"
	var/classification = SAFE
	var/datum/component/scp/component //You don't have to use this, but it's really nice for smaller SCP's so you can make them SCP whenever you want
	var/atom/owner

/datum/scp/proc/SCPinit(atom/A)
	world << "12"
	if(!isatom(A))
		return
	owner = A
	world << "13"

	if(component)
		world << "14"
		component = A.AddComponent(component,src)

/datum/scp/proc/isCompatible(atom/A)
	return 1

/datum/scp/proc/Remove()

	if(owner)
		onLose()
		owner.TakeComponent(component.type)
		owner.SCP = null
		qdel(src)
	else
		qdel(src)

/datum/scp/proc/onGain()

/datum/scp/proc/onLose()

/atom/proc/makeSCP(var/A)
	world << "1"
	if(A && !ispath(A))
		world <<  "2"
		if(ispath(GLOB.SCP_list[A]))
			world << "4"
			SCP = GLOB.SCP_list[A]
		else
			world << "5"
			return
	world << "6"
	if(ispath(SCP))
		world << "7"
		SCP = new SCP()
		world << "8 . [SCP]"
	if(!isdatum(SCP) || !canBeSCP(SCP)) //One last isdatum to check if someone didnt fuck the path
		world << "9"
		qdel(SCP)
		return
	world << "10"
	SCP.SCPinit(src)
	SCP.onGain()
	world << "11"
	return 1

/atom/proc/canBeSCP(datum/scp/SCP_)
	return SCP_.isCompatible(src)

/atom/proc/isSCP(var/A)
	if(A)
		if(SCP.designation == A)
			return 1
	else
		if(SCP)
			return 1

/atom/proc/removeSCP(var/A)
	if(!SCP)
		return 0
	if(A)
		if(ispath(A) && (SCP.type == A))
			SCP.Remove()
			return 1
		if(ispath(GLOB.SCP_list[A] && (SCP.type == GLOB.SCP_list[A])))
			SCP.Remove()
			return 1
	else
		SCP.Remove()
		return 1
