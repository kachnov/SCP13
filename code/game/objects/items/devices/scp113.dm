/obj/item/device/scp113
	name = "jasper rock"
	desc = "The red piece of quartz gleams with unnatural smoothness."
	icon_state = "scp113"
	force = 10.0
	w_class = ITEM_SIZE_HUGE //temporary workaround until I can fix the nodrop code to include noplace in bags/tables
	throwforce = 10.0
	throw_range = 15
	throw_speed = 3
	candrop = 0

/obj/item/device/scp113/pickup(mob/living/user as mob)

	candrop = 0 //reset candrop for new pickup

	var/which_hand = BP_L_HAND //determine hand to burn
	if(!user.hand)
		which_hand = BP_R_HAND

	to_chat(user, "<span class='warning'>The rock begins to sear your hand, burning the skin on contact, and you feel yourself unable to drop it.</span>")

	user.apply_damage(10, BURN, which_hand, 0) //administer damage
	user.apply_damage(30, TOX, which_hand, 0)

	spawn(200)
		to_chat(user, "<span class='warning'>Bones begin to shift and grind inside of you, and every single one of your nerves seems like it's on fire.</span>")
	spawn(210)
		visible_message("<span class='notice'>\The [user] starts to scream and writhe in pain as their bone structure reforms.</span>")
	spawn(300)
		if(user.gender == FEMALE) //swap genders
			user.gender = MALE
		else
			user.gender = FEMALE
	spawn(350)
	to_chat(user, "<span class='warning'>The burning begins to fade, and you feel your hand relax it's grip on the jasper.</span>")
	spawn(360)
	candrop = 1 //transformation finished, you can let go now
