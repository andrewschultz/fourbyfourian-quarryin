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

test bvb with "n/place fb/e/place k/n/n/place eb/e/place k/pf". [BvB]
test qn with "test bvb".

test bvn with "ne/w/place k/n/place fb/n/place gn/w/place k/pf". [BvN]
test qne with "test bvn".

test bb1 with "e/place b/w/place k/se/place b/s/place king/pf". [KBBvK stalemate]
test bb2 with "e/e/place b/w/w/w/place k/se/place b/s/place king/pf". [KBBvK checkmate]
test qe with "test bb1/test bb2".

test bn1 with "se/place k/w/place b/w/place n/se/se/place k/pf". [KBNvK stalemate]
test bn2 with "se/place k/w/place n/se/place b/s/place k/pf". [KBNvK checkmate]
test qse with "test bn1/test bn2".

test nn1 with "s/place k/sw/place n/e/e/place n/sw/place k/pf". [KNNvK stalemate]
test nn2 with "s/e/place n/w/w/w/place n/se/se/e/e/place k/w/w/place k/pf". [KNNvK checkmate]
test qs with "test nn1/test nn2".

test nvb with "sw/n/place fn/n/place k/sw/w/place eb/n/place k/pf". [NvB]
test qsw with "test nvb".

test nvn with "w/w/place fn/ne/place k/w/w/place en/n/place k/pf". [NvN]
test qw with "test nvn".

section big picture tests

test a14 with "test bvb/test nvb/test nvn/test bvn".

test a56 with "test qe/test qs".

test a7 with "test qse".

test all with "test a14/test a56/test a7".

test roomlist with "test a14/test nn2/test nn1/s". [make sure a list of rooms pops up]

section amusing / special cases

[this tests BvB and B&B on both colored squares]
test bcolors1 with "n/place bishop/ne/place bishop/out/n/w/place bishop/ne/place bishop/out".
test bcolors2 with "jump/e/place bishop/ne/place bishop/out/e/w/place bishop/ne/place bishop/out"

test dc-bb with "jump/e/place k/a3/place b/e3/place b/c5/place k". [bb double check--note this must be done before stalemating]
test dc-bn with "jump/se/place k/w/place n/e3/place b/c5/place k". [bn double check]
test dc-nn with "jump/s/place k/w/place n/d3/place n/c5/place k". [nn double check]

test bvn1 with "ne/place bishop/w/place king/b5/place knight/w/place king".
test bvn2 with "ne/se/place bishop/b3/place king/b5/place knight/w/place king".

test orwell with "jump/s/place n/e/place n/e/place k/e1/place k"

test oneoffs with "nw/xyzzy/nnw/e/nnw/fail"

test amuse with "test bcolors1/test bcolors2/test dc-bb/test bvn1/test bvn2/test orwell/test oneoffs"

Fourbyfourian Quarryin Tests ends here.

---- DOCUMENTATION ----
