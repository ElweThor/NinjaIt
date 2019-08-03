# FF_NinjaIt
Very small utility to support Ninja characters into Final Fantasy XIV

#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author: Elwe Thor

 Script Function: allow to have "external macro" of Final Fantasy XIV Ninja
	ninjutsu special moves/spells.
	 As the minimum allowed Wait time, in FF, is 1 second, it's a waste of time
	to make an FF macro to cast ninjutsu (e.g. 3 whole seconds to cast Suiton).
	 As Autoit doesn't have such limitation, it can be used instead: every mudra
	element, Ten, Chi, and Jin, have a cast time of 0.5s (up to FFXIV 5.0)


___TECH: HOW IT WORKS IN FF___

	 To make NinjaIt working for you, in FF's PvE setup (PvP setup DON'T need
	it) you must:

	- define 4 "mudra keys" to be pressed by the automation:
		- F5 Ten
		- F6 Chi
		- F7 Jin
		- F8 Ninjutsu

	- add/modify a keybind, by using a feature you will never use, to dedicate
		to the Toggle function (enable/disable): the game's feature can be
		whichever, e.g. to show a Crafting Log if your ninja will never be a
		crafter (you can always open it by menu & mouse)
		Set the keybind to ctrl+alt+F5

	- add 7 "fake" macros, for the 7 combos, to place somewhere in the hotbars,
		where is more confortable for you: map (keybind) them to
		- CTRL+1 Fuma
		- CTRL+2 Katon
		- CTRL+3 Raiton
		- CTRL+4 Hyoton
		- CTRL+5 Huton
		- CTRL+6 Doton
		- CTRL+7 Suiton

		Each fake-macro (nearly-empty macro) will be like that
		.----------------------------------------.
		| (icon) | NINfuma (*)					 |
		|----------------------------------------|
		|/micon "Fuma Shuriken"					 |
		'----------------------------------------'
		(*) the name is an example only: you can use whatever you prefer

		.----------------------------------------.
		| (icon) | NINkaton 					 |
		|----------------------------------------|
		|/micon "Katon"					 		 |
		'----------------------------------------'

		.----------------------------------------.
		| (icon) | NINraiton 					 |
		|----------------------------------------|
		|/micon "Raiton"				 		 |
		'----------------------------------------'
		etc.

		 I suggest to place the (new) combos buttons outside the "most wanted" area
		(my most-wanted area is all around the left hand) as you won't have to press
		them in terms of milliseconds like before: NinjaIt will do it for you! :)
		 Also, you still have the original mudra keys available, if you want/need
		them by any chance.

	- when playing (PvE only) you'll have to
		- enable the automation (ctrl+alt+F5) otherwise you'll obtain nothing
		- use the new 1..7 buttons only: you'll see some little messages, near to
		 the mouse (or whatever pointer you have) telling you the combo is going on,
		 then NinjaIt will DO the thing: depending on your choice, it will "press"
		 the original mudras (it sends the keypresses like you do via keyboard),
		 with proper timings, ending with the Ninjutsu mudra to unleash it.


___(personal mumbles, rants, motivation explanation, blablabla: you can jump over it)___

Author's Note: so WHY I wrote this little automation?
	 To circumvent FinalFantasy anti-cheat checks? No
	 To "illegally empower" a Ninja above all other classes/jobs? No
	 It's mostly 'cause of my very scarce memory: into a Ninja realtime fight,
	generally seen, in dungeons or raids, one MUST follow the party main strategy,
	supporting the tank(s), avoiding to pull mobs, and doing the many chores and
	adopting the gaming behaviors you all probably know: this mostly means a good
	player must train his HANDS to "think" instead of his brain... if you want an
	informatic parallel, let's see that like the (GIANT) work a good graphic card
	does, instead of the main computer's CPU(s): if you ever tried to use the
	"GPU emulation" (graphic card software emulation ran in the main CPU) you saw
	it was thousands times slower than using the graphics card's hardware.
	 This is what a good gamer do, training his fingers to support him, so that
	his "main CPU" (the brain) is free to look at the general strategy... while
	the fingers fights.
	 Now... my fingers have a limited amount of "RAM" and, with the way FF
	implemented ninja's mudras, the combos can't be resolved (at least by me: I
	know there is plenty of players which does it without problems!) without a
	"call" to the "main CPU", so terribly slow... let me show an example:

	 We are in a dungeon, supporting a tank
	 my ninja is to the back of the boss the tank is holding the aggro (focus)
	 the main CPU (my brain) is busy in many tasks:
	 - keeping out of Boss' AoE shots
	 - avoiding the healer have to share his attention to me
	 - doing the max possible damage in the min possible time
	 - keeping an eye to the GCD (Global CoolDown) and interleaving the actions with
		independent CDs to burst the average damage dealt
	 - trying to self heal, if needed
	 - taking care of the adds, if possible
	 all this in realtime

	 at a given moment my CPU thinks "ah, wonderful, time to Huton, then Suiton"
	 this SHOULD mean my "extensions" (the fingers) should independently
	 - press the Huton's button
	 - keep fighting while the Ninjutsu's CD expires
	 - press the Suiton's button
	 - restart fighting by using other GCD actions (and doing all the abovementioned)

	 Pity that... there is NO "Huton's button" nor "Suiton's one" (btw: this is made
	on purpose, in the PvP setup THERE ARE such buttons, only the PvE setup lacks them)
	 So, replace the "press the Huton button" with a (SLOW) call to the main CPU (which
	is already overtasked) to remember HOW an Huton is made: this (at least on me)
	takes even more than the time to press Jin (wait 0.5) Chi (wait 0.5) Ten
	(wait 0.5) Ninjutsu.
	 We could even think I can really take profit of an FF macro (3 seconds instead
	of 1,5) as the "additional" 1,5 seconds I'm spending in remembering the combo
	sequences... well, as I'm not making gold, out of this, I thought to just write a
	little "interface" to help my fingers (see it like a piggy-back card, directly
	mounted on the main Gfx card, to extend it and avoid the slow call to the main
	CPU).
	 This interface doesn't automate the ingame ninja avatar (yes: I saw many and
	many doing, even using high-cost cheat services one can find in the net) it only
	implements the PvP's Ninjutsu's interface to the PvE side: I needed it, like
	many of you, I bet. :-)

	 The second (not that hidden) reason which pushed me to write such interface
	was the will to better know Ninjutsu's mudras and, believe me, there is no
	better way to learn something than to try implementing it.
	 I don't know if, with time, my fingers will become so independent to learn
	the combos by themselves, I doubt, nonetheless it was fun to develop, interesting
	to learn... and it works! :D

	 The third reason I wrote NinjaIt was... FOR FUN!
	(and I had a lot, by writing AND by using it ;-)))

		Elwe Thor,	August 2019

___Changelog___
20190802 - 1.0.1.6
.6 + Splash screen
.5 + mudra functions with integrated randomized timers
.4 + compiler-time version handling (pragma)
.3 + tech hot-to
.2 * name change Ninjutsu -> NinjaIt to better express my gratitude to AutoIt :)
.1 + keypress randomizer, to walk around the anti-cheat

20190801 - 1.0.0.0
.0 + initial "testing" release: only Fuma shuriken works, 'cause of FF anti-cheat

#ce ----------------------------------------------------------------------------
