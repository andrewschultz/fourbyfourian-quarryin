Version 1/210716 of Fourbyfourian Quarryin Tests by Andrew Schultz begins here.

"Fourbyfourian Quarryin Tests: a separate file so the main file is less cluttered."

volume testing - not for release

report metaing:
	say "DEBUG-ONLY NOTES:[line break]";
	say "[b]TL[r] lists the tests for the different directions.";
	say "[b]PIE[r] shows where all the pieces are.";
	say "[b]WIPE[r] wipes a direction, or all, with no arguments.";
	say "[b]SOL[r] solves a direction. No arguments chooses a random one.";
	say "[b]STA[r] stalemates a direction. No arguments chooses a random unstalemated one. Unstalemated includes solved.";

chapter when play begins

when play begins (this is the set debug state rule):
	now debug-state is true;

the set debug state rule is listed first in the when play begins rulebook.

chapter amuing

amuing is an action applying to nothing.

understand the command "amu" as something new.

understand "amu" as amuing.

carry out amuing:
	look-for-amuse false;
	the rule succeeds.

chapter harding

this is the dif-toggle rule:
	if number of tried directions > 0:
		say "WARNING: toggling normal/hard mode is risky after leaving the Ministry.";

harding is an action out of world.

understand the command "hard" as something new.

understand "hard" as harding.

carry out harding:
	abide by the dif-toggle rule;
	say "Normal mode is [if hard-mode is true]already[else]now[end if] set.";
	now hard-mode is true;
	the rule succeeds;

chapter normaling

normaling is an action out of world.

understand the command "normal" as something new.
understand the command "norm" as something new.

understand "normal" as normaling.
understand "norm" as normaling.

carry out normaling:
	abide by the dif-toggle rule;
	say "Normal mode is [if hard-mode is false]already[else]now[end if] set.";
	now hard-mode is false;
	the rule succeeds;

chapter pfing

pfing is an action out of world.

understand the command "pf" as something new.

understand "pf" as pfing.

carry out pfing:
	say "[if player is in ministry of unity]PASSED[else]FAILED--going back to Ministry[end if].";
	if player is not in ministry of unity:
		move player to ministry of unity, without printing a room description;
	new-quest;
	the rule succeeds;

chapter randdiring

randdiring is an action applying to one visible thing.

understand the command "rd" as something new.

understand "rd [direction]" as randdiring.

carry out randdiring:
	if noun is similar-early of noun:
		say "Since [noun] has no similar early direction, I'm just going [noun].";
	else if a random chance of 1 in 2 succeeds:
		now noun is similar-early of noun;
		say "Going [noun].";
	try going noun;
	the rule succeeds;

chapter solveing

to say by-force of (n - a number):
	say "[if n > 1]at random[else]by force[end if]"

rule for supplying a missing noun when solveing:
	if number of primary not solved directions > 0:
		now noun is a random primary not solved direction;
		say "Picking [noun] [by-force of number of primary not solved directions].";
	else if number of secondary not solved directions > 1:
		let X be the list of secondary not solved directions;
		if number of secondary solved directions is 0:
			remove southeast from X, if present;
		let Y be a random number from 1 to number of entries in X;
		now noun is entry Y in X;
		say "Picking [noun][by-force of number of entries in X].";
	else if number of secondary not solved directions is 1:
		say "That might break things. You only have one direction left: [a random secondary not solved direction].";
		reject the player's command;
	else:
		say "You should have won the game.";
		reject the player's command;
	reject the player's command;

solveing is an action applying to one visible thing.

understand the command "sol" as something new.

understand "sol [direction]" as solveing.
understand "sol" as solveing.

carry out solveing:
	if noun is solved, say "You've already solved [noun]." instead;
	say "Setting [noun] to solved.";
	now noun is solved;
	now already-solved of noun is {};
	if noun is secondary, now stalemate-recap of noun is {};
	now checkmate-recap of noun is {a1, a1, a1, a1};
	abide by the impractical game state check rule;
	the rule succeeds;

chapter staing

this is the impractical game state check rule:
	if number of unsolved primary directions > 0 and number of not unsolved secondary directions > 0:
		say "NOTE: you're currently in a nonviable game state, because you have made progress on the secondary directions while not all the primary directions are solved.";

rule for supplying a missing noun when staing:
	if number of secondary not stalemated directions is 0:
		say "Nothing to change to stalemated.";
	else:
		say "Converting all secondary directions to stalemated.";
		now all secondary directions are stalemated;
	abide by the impractical game state check rule;
	reject the player's command;

staing is an action applying to one visible thing.

understand the command "sta" as something new.

understand "sta [direction]" as staing.
understand "sta" as staing.

carry out staing:
	if noun is stalemated, say "But [noun] is already stalemated." instead;
	if noun is not secondary, say "You can only set the secondary directions [list of secondary directions] to stalemated." instead;
	say "Setting [noun] to stalemated.";
	now noun is stalemated;
	abide by the impractical game state check rule;
	the rule succeeds;

chapter tsring

tsring is an action out of world.

understand the command "tsr" as something new.

understand "tsr" as tsring.

carry out tsring:
	now screen-reader is whether or not screen-reader is false;
	say "Screen reader mode is now [on-off of screen-reader].";
	the rule succeeds;

chapter wipeing

rule for supplying a missing noun when wipeing:
	if number of not unsolved directions is 0:
		say "Nothing to wipe.";
	else:
		say "Wiping your progress for [list of not unsolved directions].";
		repeat with D running through solved directions:
			now already-solved of D is {};
			now stalemate-recap of D is {};
			now checkmate-recap of D is {};
			now D is unsolved;
	reject the player's command;

wipeing is an action applying to one visible thing.

understand the command "wipe [directions]" as something new.

understand "wipe" as wipeing.
understand "wipe [direction]" as wipeing.

carry out wipeing:
	if noun is not questable, say "You can't wipe [q of noun], since it doesn't exist." instead;
	say "[if noun is unsolved](Wiping anyway, even though [noun] wasn't solved.)[else]Wiped defeating [q of noun] from the record.[end if]";
	now noun is unsolved;
	abide by the impractical game state check rule;
	the rule succeeds;

chapter testlisting

testlisting is an action out of world.

understand the command "tl" as something new.

understand "tl" as testlisting.

carry out testlisting:
	say "Current quest direction: [quest-dir].";
	repeat with D running through questable directions:
		say "[D][if d is solved] (solved)[end if]: [first-piece of D] + [second-piece of D].";
	the rule succeeds;

chapter pie

pieing is an action out of world.

understand the command "pie" as something new.

understand "pie" as pieing.

carry out pieing:
	repeat with P running through pieces:
		say "[P] [if p is irrelevant](irrelevant) [end if][location of P].";
	the rule succeeds;

chapter tests

section each area arranged clockwise

test bvk-r-s with "rd n/place k/s/place b/s/place k/pf". [random north or northeast]
test bvk-r-s-n with "rd n/w/place k/se/place b/a1/place k/pf". [random north or northeast]
test nvk-r-s with "rd w/place n/n/place k/a5/place k". [random west or southwest]

test bvb-s with "n/s/place b/nw/place k/a1/place k/pf". [KBvsK, stalemate]
test bvb-c with "n/place fb/e/place k/n/n/place eb/e/place k/pf". [BvB]
test qn with "test bvb-s/test bvb-c".

test bvn-s with "ne/s/place b/nw/place k/a1/place k/pf". [KBvsK, stalemate]
test bvn-c with "ne/w/place k/n/place fb/n/place gn/w/place k/pf". [BvN]
test qne with "test bvn-s/test bvn-c".

test bb-s-h with "e/place b/w/place k/se/place b/s/place king/pf". [KBBvK hard stalemate]
test bb-s-n with "e/place k/s/place b/nw/place b/a1/place k". [KBBvK normal stalemate]
test bb-c-n with "e/place b/w/place b/e3/place k/e1/place k". [KBBvK normal checkmate]
test bb-c-h with "e/e/place b/w/w/w/place k/se/place b/s/place king/pf". [KBBvK hard checkmate]
test qe-h with "test bb-s-h/test bb-c-h".
test qe-n with "test bb-s-n/test bb-c-n".

test bn-s-h with "se/place k/w/place b/w/place n/se/se/place k/pf". [KBNvK hard stalemate]
test bn-s-n with "se/place n/w/place k/w/place b/a1/place k/pf". [KBNvK normal stalemate]
test bn-c-n with "se/place b/w/place k/w/place n/a1/place k/pf". [KBNvK normal checkmate]
test bn-c-h with "se/place k/w/place n/se/place b/s/place k/pf". [KBNvK hard checkmate]
test qse-h with "test bn-s-h/test bn-c-h".
test qse-n with "test bn-s-n/test bn-c-n".

test nn-s-h with "s/place k/sw/place n/e/e/place n/sw/place k/pf". [KNNvK hard stalemate]
test nn-s-n with "s/place n/e/place n/a3/place k/a1/place k". [KNNvK normal stalemate]
test nn-c-n with "s/place n/w/place n/w/place k/a1/place k". [KNNvK normal checkmate]
test nn-c-h with "s/e/place n/w/w/w/place n/se/se/e/e/place k/w/w/place k/pf". [KNNvK hard checkmate]
test qs-h with "test nn-s-h/test nn-c-h".
test qs-n with "test nn-s-n/test nn-c-n".

test nvb-s with "sw/place n/n/place k/a5/place k". [KNvsK, stalemate]
test nvb-c with "sw/n/place fn/n/place k/sw/w/place eb/n/place k/pf". [NvB]
test qsw with "test nvb-s/test nvb-c".

test nvn-s with "w/place n/n/place k/a5/place k". [KNvsK, stalemate]
test nvn-c with "w/w/place fn/ne/place k/w/w/place en/n/place k/pf". [NvN]
test qw with "test nvn-s/test nvn-c".

section big picture tests

test a14h with "test bvk-r-s/test nvk-r-s/test bvb-c/test nvb-c/test nvn-c/test bvn-c".
test a14n with "test bvk-r-s-n/test nvk-r-s/test bvb-c/test nvb-c/test nvn-c/test bvn-c".

test a57h with "test qe-h/test qs-h/test qse-h".
test a57n with "test qe-n/test qs-n/test qse-n".

test normal with "normal/test a14n/test a57n".

test hard with "hard/test a14h/test a57h".

test roomlist with "hard/test a14h/test qs-h/s". [make sure a list of rooms pops up]

section amusing / special cases

[this tests BvB and B&B on both colored squares]
test bcolors1 with "n/place bishop/ne/place bishop/out/n/w/place bishop/ne/place bishop/out".
test bcolors2 with "jump/e/place bishop/ne/place bishop/out/e/w/place bishop/ne/place bishop/out"

test dc-bb with "jump/e/place k/a3/place b/e3/place b/c5/place k". [bb double check--note this must be done before stalemating]
test dc-bn with "jump/se/place k/w/place n/e3/place b/c5/place k". [bn double check]
test dc-nn with "jump/s/place k/w/place n/d3/place n/c5/place k". [nn double check]

test bvn-take with "ne/place bishop/w/place king/b5/place knight/w/place king".
test bvn-block with "ne/se/place bishop/b3/place king/b5/place knight/w/place king".

test nvb-take with "sw/n/place k/sw/place n/nw/place b/n/place k".

test nn-check1 with "w/n/place fn/n/place k/a4/place n/fail".
test nn-check2 with "w/n/place fn/a4/place n/c5/place k/fail".

test orwell with "jump/s/place n/e/place n/e/place k/e1/place k"

test oneoffs with "nw/xyzzy/nnw/e/nnw/fail"

test amuse with "test bcolors1/test bcolors2/test dc-bb/test bvn1/test bvn2/test orwell/test oneoffs"

Fourbyfourian Quarryin Tests ends here.

---- DOCUMENTATION ----
