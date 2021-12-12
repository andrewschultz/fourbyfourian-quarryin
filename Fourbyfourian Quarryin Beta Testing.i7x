Version 1/211019 of Fourbyfourian Quarryin Beta Testing by Andrew Schultz begins here.

"Fourbyfourian Quarryin beta-testing instructions."

volume beta testing

book starting stuff

include Start With Transcripts by Andrew Schultz.

when play begins (this is the beta 4x4 instruction rule):
	say "For testers: do what you can. I'm mainly curious how the first four quests work out. My hope is that they get easier the more you do, so you're ready for the final three.";
	say "[line break]Also, I am wondering about if you found the mnemonic for what quests are in which direction useful or sensible or not.";
	say "[line break]I have general concerns about the text too. I hope the text when someone makes an errant try is funny, and I want it there for chess players. But I don't want to discourage non-players. I also suspect I have forgotten a few descriptions in my notes.";
	say "[line break]The hinting can probably be adjusted, too.";
	say "[line break]Oh yes! The [b]JUMP[r] command can be used to jump over restrictions.";
	say "[wfak]";

the beta 4x4 instruction rule is listed after the prompt transcript when starting rule in the when play begins rulebook.

book verbs stuff

chapter jumping

jumpovering is an action out of world.

understand the command "jump" as something new.
understand the command "j" as something new.

understand "jump" as jumpovering.
understand "j" as jumpovering.

carry out jumpovering:
	say "You can [if jump-over is true]already[else]now[end if] jump over boundary conditions to visit any quest.";
	now jump-over is true;
	the rule succeeds;

chapter jumptoggleing

jumptoggleing is an action out of world.

understand the command "jt" as something new.

understand "jt" as jumptoggleing.

carry out jumptoggleing:
	now jump-over is whether or not jump-over is false;
	say "Jumping over boundary conditions so you can visit anywhere is now toggled to [on-off of jump-over].";
	the rule succeeds;

Fourbyfourian Quarryin Beta Testing ends here.

---- DOCUMENTATION ----
