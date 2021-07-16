Version 1/210716 of Fourbyfourian Quarryin Tests by Andrew Schultz begins here.

"Fourbyfourian Quarryin Tests: a separate file so the main file is less cluttered."

volume testing - not for release

report metaing:
	say "DEBUG-ONLY NOTES:[line break]";
	say "[b]TL[b] lists the tests for the different directions.";
	say "[b]PIE[b] shows where all the pieces are.";
	say "[b]WIPE[b] wipes a direction, or all, with no arguments.";

chapter when play begins

when play begins (this is the set debug state rule):
	now debug-state is true;

the set debug state rule is listed first in the when play begins rulebook.

chapter wipeing

rule for supplying a missing noun when wipeing:
	if number of not unsolved directions is 0:
		say "Nothing to wipe.";
	else:
		say "Wiping your progress for [list of not unsolved directions].";
		now all directions are unsolved;
	reject the player's command;

wipeing is an action applying to one visible thing.

understand the command "wipe [directions]" as something new.

understand "wipe" as wipeing.
understand "wipe [direction]" as wipeing.

carry out wipeing:
	if noun is not questable, say "You can't wipe [q of noun], since it doesn't exist." instead;
	say "[if noun is unsolved](Wiping anyway, even though [noun] wasn't solved.)[else]Wiped defeating [q of noun] from the record.[end if]";
	now noun is unsolved;
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

test bvb with "sw/place friendly bishop/ne/n/place enemy bishop/se/s/place friendly king/n/n/place enemy king". [BvB]
test qsw with "test qsw".

test nvb with "n/n/place friendly knight/n/place friendly king/sw/w/place enemy bishop/n/place enemy king". [NvB]
test qn with "test nvb".

test nvn with "ne/w/place friendly knight/ne/place friendly king/w/w/place enemy knight/n/place enemy king". [NvN]
test qne with "test nvn".

test bvn with "w/w/place friendly king/n/place friendly bishop/n/place enemy knight/w/place enemy king". [BvN]
test qw with "test bvn".

test bb1 with "e/place friendly bishop/w/place k/se/place bishop/s/place king". [KBBvK stalemate]
test bb2 with "e/place friendly bishop/w/w/w/place k/se/place bishop/s/place king". [KBBvK checkmate]
test qe with "test bb1/test bb2".

test nn1 with "s/place k/sw/place friendly knight/e/e/place second n/sw/place k". [KNNvK stalemate]
test nn2 with "s/e/place friendly knight/w/w/w/place n/se/se/e/e/place k/w/w/place k". [KNNvK checkmate]
test qs with "test nn1/test nn2".

test bn1 with "se/place k/w/place b/w/place n/se/se/place k". [KBNvK stalemate]
test bn2 with "se/place k/w/place n/se/place b/s/place k". [KBNvK checkmate]
test qse with "test bn1/test bn2".

test a14 with "test bvb/test nvb/test nvn/test bvn".

test a56 with "test qe/test qs".

test a7 with "test qse".

test all with "test a14/test a56/test a7".

test roomlist with "test a14/test nn2/test nn1/s". [make sure a list of rooms pops up]

section amusing / special cases

test bcolors with "jump/sw/place bishop/ne/place bishop/out/e/place bishop/ne/place bishop/out"

test bvn1 with "w/place bishop/w/place king/n/n/place knight/w/place king".
test bvn2 with "w/se/place bishop/nw/w/place king/n/n/place knight/w/place king".

Fourbyfourian Quarryin Tests ends here.

---- DOCUMENTATION ----
