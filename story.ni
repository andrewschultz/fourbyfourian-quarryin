"Fourbyfourian Quarryin'" by Andrew Schultz

the story headline is "Greed now has no need for speed. Indeed.".

the story description is "A sequel to Fivebyfivia, because queens and rooks shouldn't have all the fun.".

volume basics and definitions

section project settings

[cannot go into the common header]

release along with a website.

release along with the "Parchment" interpreter.

release along with cover art.

the release number is 1.

section modules

include Bypass Disambiguation by Climbing Stars.

include Chess Common by Andrew Schultz.

include Fourbyfourian Quarryin Tests by Andrew Schultz.

section stuff only changed in debug mode

jump-over is a truth state that varies.

section text shortcuts

to say q of (d - a direction):
	say "[printed name of d in title case] [4b]";

to say cq:
	say "[q of quest-dir]"

to say github: say "https://github.com/andrewschultz/fourbyfourian-quarryin"

section meta/option booleans

map-view is a truth state that varies.

map-notes-flag is a truth state that varies.

instructions-given is a truth state that varies.

walkthrough-hint is a truth state that varies.

section scoring

check requesting the score:
	say "This game doesn't keep a score, but to track your progress, you've helped 'reunite' [number of solved directions] of [number of questable directions] [4b]s so far[if number of solved directions > 0]: [list of solved directions][end if][if number of stalemated directions > 0].[paragraph break]You've gained the trust of [trusted-kings], as well[end if][one of].[paragraph break]This is all tracked in the upper-right status bar[or][stopping]." instead;

for printing the name of a direction (called d) while requesting-detail:
	say "[q of d]";

to decide whether requesting-detail:
	if current action is requesting the score, yes;
	if current action is examining map of the Fourbyfourias, yes;

to say trusted-kings:
	let SD be number of stalemated directions;
	say "the king[if SD > 1]s[end if] of ";
	say "[list of stalemated directions]";

section tricky endgame manual

does the player mean examining manual when player is not in ministry of unity: it is very likely.
does the player mean examining map when player is in ministry of unity: it is very likely.

rule for supplying a missing noun when examining:
	if player is in ministry of unity:
		now noun is map;
	else:
		now noun is tricky endgame manual;

The tricky endgame manual is a thing. The player carries the tricky endgame manual. description of tricky endgame manual is "Sadly, it's filled with a lot of rah-rah general concepts about believing in yourself and trusting your intuition (well, duh. If you didn't, you wouldn't have come this far in life) yet checking your work and not moving too quickly or too slowly. There's also a note to make sure every ally is doing their part, because nobody can do too much. Duh, again.[paragraph break]The worst bit is the flowery writing (including [your-pals]) but low on useful details. Irrelevant rubbish. Plus there's nothing like that about you."

after examining tricky endgame manual when player is not in Ministry:
	if quest-dir is secondary:
		say "Oh, wait. There is some note about how the [4n] king here is suspcious of being cornered these days, what with his neighbors disappearing mysteriously[if number of not irrelevant bishops is 2]. Also, he's a bit scared of being right next to a bishop who's right next to another monarch. He can't see the other king that way, but if the other king's even slightly off to the side, like on a diagonal, that's okay. Man, people have weird social phobias![else].[end if]";
		say "[line break]Also, there's a note about how you probably can't trap the [4n] king violently right away. Find a way to fake him out. Make him feel surrounded, not attacked, at the first meeting. Then go in for the kill[if quest-dir is stalemated]. Hey, first part completed[end if].";
	else:
		say "Oh, wait. There is some note about how you won't be able to trap the [4n] king without your traitorous accomplice.  And you probably can't trap him way out in the center of the board!";

to say your-pals:
	if quest-dir is primary:
		say "a gratuitous biography of the [first-piece of quest-dir] with no mention of your secret helper, the [second-piece of quest-dir]";
	else:
		say "gratuitous biographies of the [first-piece of quest-dir] and [second-piece of quest-dir] helping you here";

check examining manual when player is in Ministry of Unity:
	say "You read up on the basics of taking down an enemy king with [if number of solved directions > 4]one ally and one equally-strong traitor[else]two relatively inauspicious allies[end if]. But it's all a bit dry and technical, and you'll know what specifics apply better once you leave the Ministry of Unity." instead;

instead of doing something other than examining tricky endgame manual:
	say "You can really only [b]X[r] or [b]EXAMINE[r] the [manual]." instead;

check taking inventory:
	say "All you have on you, besides various expensive rings and medals designating your position as a prominent [12n], is a tricky endgame manual. You can type [b]X[r] at any time outside the Ministry to see what needs to be done. Inside, [b]X[r] will examine the map." instead;

chapter modules not for release

[add hyphen above to really Git Tuff on debug code]

include Debug Levels and Checks by Andrew Schultz.

volume starting

current-quest-snapshot is a list of rooms variable.

volume rooms

to decide which number is the parity of (r - a room):
	decide on the remainder after dividing (xval of r + yval of r) by 2;

to decide if (r1 - a room) and (r2 - a room) are samecolored:
	if parity of r1 is parity of r2, yes;
	no;

to decide which number is quests-left:
	decide on number of questable directions - number of solved directions.

chapter central

the Ministry of Unity is a not puzzly room. xval is 8. yval is 8. "The planning has been done. [can-leave][tried].[paragraph break]A map of [12b] and the surrounding [4b]s adorns one wall. You can [b]X[r] or [b]EXAMINE[r] it for details, if you want.".

to say can-leave:
	if number of to-solve directions > 3:
		say "While halls lead off in all directions, your main focus should be to the [list of primary not solved directions][if number of solved directions > 0]. There's no point in revisiting to the [list of solved directions][end if]";
	else:
		say "You've made good progress and only need to visit lands [list of to-solve directions] from here";

definition: a direction (called d) is near-checkmate:
	if d is solved, no;
	if already-solved of d is empty, no;
	yes;

to say tried:
	if number of tried not solved directions is 0, continue the action;
	let tried-unsolved be number of tried unsolved directions;
	let stalemates be number of stalemated directions;
	say ". You've[if  tried-unsolved > 0] been to [list of tried unsolved directions] before[end if][if tried-unsolved > 0 and stalemates > 0] and[end if][if stalemates > 0]made good progress to the [list of stalemated directions][end if]";

definition: a direction (called d) is solve-now:
	if d is solved, no;
	if d is unquestable, no;
	process the can-visit of d;
	if the rule failed, no;
	yes;

definition: a direction (called d) is not-yet:
	if d is solved, no;
	if d is unquestable, no;
	process the can-visit of d;
	if the rule failed, yes;
	no;

the hub check rule is listed first in the check going rulebook.

the note boundaries rule is listed before the can't go that way rule in the check going rulebook.

check going outside:
	try exiting instead;

check exiting (this is the blanket exit rule):
	if location of player is Ministry of Unity:
		if number of unsolved directions is 1:
			let D be a random unsolved direction;
			say "Only one direction to go out: [D]. So you do.";
			try going D instead;
		say "You need to specify a compass direction to go out from the Ministry of Unity." instead;
	say "You return to the Ministry of Unity. This conquest can wait for later.";
	repeat with P running through pieces:
		now P is irrelevant;
		move P to offsite;
	move player to Ministry of Unity;
	the rule succeeds;

the blanket exit rule is listed before the can't exit when not inside anything rule in the check exiting rulebook.

check going (this is the hub check rule):
	if noun is up or noun is down:
		say "Flying machines are a century or more away." instead;
	if player is in Ministry of Unity:
		let cur-row be 0;
		if noun is northwest:
			note-amusing-stuff "northwest";
			say "Alas, the vast lands northwest of [12b] are so unruly as to feature nonlinear borders. Some such borders are not even defined by rivers![paragraph break]Plus, they're vast enough, it'd take too long to get to their capitals. Oh, and the whole painful winters and large armies things, too." instead;
		if noun is unquestable, say "You can't go [noun] from the Ministry." instead;
		if noun is solved, say "You already conquered [noun] [4b]." instead;
		abide by visit-text of noun;
		now quest-dir is noun;
		say "You head to [cq]. Your allies for this quest are [summary-text of noun][if quest-dir is southeast and quest-dir is not tried]. A courtier whispers to you at the last moment: [q of southeast] has been split in two! There are rival kings fighting for supremacy. That means more to do. Well, this is the last land to conquer[end if].";
		new-quest;
		move player to c3;
		if quest-dir is stalemated and already-solved of quest-dir is not empty:
			say "Okay. You make a note of what you tried earlier, before you gained the enemy king's trust. It almost worked. It should work now.[paragraph break]Your king, [entry 1 of already-solved of quest-dir]. The [first-piece of quest-dir], [entry 2 of already-solved of quest-dir]. The [second-piece of quest-dir], [entry 3 of already-solved of quest-dir]. The king of [q of quest-dir], [entry 4 of already-solved of quest-dir].";
		the rule succeeds;
	if noun is inside:
		say "You need to go a planar direction.";

check going (this is the note boundaries rule):
	if the room noun of location of player is nowhere:
		say "You're at the [list of edged directions] edge[if number of edged directions > 1]s[end if], so you can only go away from, or along, [if number of edged directions is 1]this edge[else]those edges[end if]." instead;

definition: a direction (called d) is edged:
	unless d is cardinal, no;
	if the room d of the location of the player is nowhere, yes;
	no;

section map of the fourbyfourias

the map of the Fourbyfourias is scenery in Ministry of Unity. description is "See the check-rule.";

check examining map of the Fourbyfourias:
	if quests-left is 1:
		say "The only part of the map not x-ed out is [random to-solve direction]. Not much choice." instead;
	say "[if number of solved directions > 0]It's a 'before' map, not showing what you've annexed. [end if][12b] takes up most of the northwest--it's got more land mass than the seven tinier [4b]s combined. It's striped gold and yellow, the colors of each half of Fivebyfivia, and your allies['] colors.[paragraph break]Clockwise in varying shades of grey from the upper right are [north], [northeast], [east], [southeast], [south], [southwest] and [west]. To the northwest are lands too big to conquer.[paragraph break]";
	if number of solved directions > 0:
		say "Some titles are x-ed out, because you already unified them: [list of solved directions].";
	else:
		say "Nothing's x-ed out yet. You've unified nothing so far. That will change soon.";
	if number of stalemated directions > 0:
		say "[line break][list of stalemated directions] [if number of stalemated directions > 1]are[else]is[end if]half-crossed out, since you established trust there. But you still need to finish the job.";
	if number of solved directions < 4:
		say "[line break][if number of solved directions > 0]However, [end if]South and East and Southeast [4b] are greyed out a bit. It's not time, yet.";
	else if number of solved directions is 4:
		say "[line break]However, [southeast] is still greyed out. It only touches [12b] at a corner, so you need a path through [south] or [east] to get there.";
	the rule succeeds;

instead of doing something other than examining map of the fourbyfourias:
	say "You can really only [b]X[r] or [b]EXAMINE[r] the [map of the]." instead;

chapter the grid

a room has a number called xval. a room has a number called yval. a room has text called room-edge-text. the description of a room is usually "You are [room-edge-text of the item described] of the main hall of the royal [cq]n castle. You can go [if number of viable directions is 8]any which way[else][list of viable directions][end if]."

room-edge-text of a1 is "at the dangerously remote southwest corner".

room-edge-text of b1 is "west a bit on the south edge".

room-edge-text of c1 is "in the center of the south edge".

room-edge-text of d1 is "east a bit on the south edge".

room-edge-text of e1 is "at the dangerously remote southeast corner".

room-edge-text of a2 is "south a bit on the west edge".

room-edge-text of b2 is "in a southwest-ish area".

room-edge-text of c2 is "just south of the center".

room-edge-text of d2 is "in a southeast-ish area".

room-edge-text of e2 is "south a bit on the east edge".

room-edge-text of a3 is "at the center of the west edge".

room-edge-text of b3 is "just west of the center".

room-edge-text of c3 is "smack in the center".

room-edge-text of d3 is "just east of the center".

room-edge-text of e3 is "at the center of the east edge".

room-edge-text of a4 is "north a bit on the west edge".

room-edge-text of b4 is "in a northwest-ish area".

room-edge-text of c4 is "just north of the center".

room-edge-text of d4 is "in a northeast-ish area".

room-edge-text of e4 is "north a bit on the east edge".

room-edge-text of a5 is "at the dangerously remote northwest corner".

room-edge-text of b5 is "west a bit on the north edge".

room-edge-text of c5 is "in the center of the north edge".

room-edge-text of d5 is "east a bit on the north edge".

room-edge-text of e5 is "at the dangerously remote northeast corner".

to decide which number is basic-dist of (r1 - a room) and (r2 - a room):
	decide on absval of (xval of r1 - xval of r2) + absval of (yval of r1 - yval of r2)

to decide which number is basic-dist of (t1 - a thing) and (t2 - a thing):
	decide on basic-dist of location of t1 and location of t2;

to decide which number is diag-dist of (r1 - a room) and (r2 - a room):
	let x be absval of (xval of r1 - xval of r2);
	let y be absval of (yval of r1 - yval of r2);
	if x > y, decide on x;
	decide on y;

to decide which number is diag-dist of (t1 - a thing) and (t2 - a thing):
	decide on diag-dist of location of t1 and location of t2;

rule for printing the locale description when map-view is true and player is not in ministry of unity:
	show-the-board;

volume pieces

team is a kind of value. the teams are black and white.

a piece is a kind of person. a piece can be reserved, irrelevant or placed. a piece is usually irrelevant. a piece has text called short-text. description is usually "You don't really want to make eye contact. You might give the game away.".

a piece has a team called the color.

chapter whether attacks

to decide whether (p1 - a piece) attacks (p2 - a piece):
	if p1 attacks location of p2, yes;
	no;

to decide whether (p1 - a piece) attacks (r - a room):
	if location of p1 is offsite, no;
	if location of p1 is r, no;
	let x1 be xval of location of p1;
	let x2 be xval of r;
	let y1 be yval of location of p1;
	let y2 be yval of r;
	let dx be absval of (x1 - x2);
	let dy be absval of (y1 - y2);
	if p1 is a king:
		if dx > 1, no;
		if dy > 1, no;
		yes;
	if p1 is a bishop:
		if absval of (x1 - x2) is not absval of (y1 - y2), no;
		let temp-room be location of p1;
		let the way be the best route from temp-room to r;
		while 1 is 1:
			now temp-room is the room the way of temp-room;
			if temp-room is r, yes;
			if temp-room is nothing, no;
			if number of pieces in temp-room is 1, no;
		no;
	if p1 is a knight:
		if dx is 1 and dy is 2, yes;
		if dx is 2 and dy is 1, yes;
		no;

to decide whether (p1 - a piece) is checked:
	repeat with p2 running through pieces:
		if color of p1 is color of p2, next;
		if p2 attacks p1, yes;
	no;

to decide whether (p1 - a piece) is immobile:
	repeat with Q running through planar directions:
		let R2 be the room Q from location of p1;
		if R2 is nothing, next;
		let this-attack be false;
		repeat with p2 running through pieces:
			if location of p2 is offsite, next;
			if color of p1 is color of p2:
				if location of p2 is R2, now this-attack is true;
				next;
			if p2 attacks R2, now this-attack is true;
		if this-attack is false:
			[if debug-state is true, say "DEBUG:[R2] [q] of [location of p1] is an escapable square.";]
			no;
	yes;

chapter bishop

a bishop is a kind of piece.

the yellow bishop is a bishop. color of yellow bishop is white. understand "b" and "yb" and "by" and "y b" and "b y" and "y" and "fb" and "bf" and "b f" and "f b" as yellow bishop. description is "[minor-color]."

the purple bishop is a bishop. color of purple bishop is white. understand "b" and "pb" and "bp" and "p b" and "b p" and "p" and "fb" and "bf" and "b f" and "f b" as purple bishop. description is "[minor-color]."

the grey bishop is a bishop. color of grey bishop is black. understand "b" and "g" and "gb" and "bg" and "g b" and "b g" and "eb" and "be" and "b e" and "e b" as grey bishop. description is "[minor-color]."

to say minor-color: say "The yellow and purple [if noun is a bishop]bishops[else]knights[end if] that will help you on your quest -- well, their outfits aren't VERY yellow, or VERY purple, but enough to tell them apart, which will help this whole operation quicker. Despite the yellow vs. purple squabbles that plague [12b], they're both equally effective.[paragraph break]It'd take a long time to describe the yellow vs. purple beefs and why things are the way they are. But if you're wondering why I chose these colors, type [b]YVP[r] or [b]PVY[r]."

check examining a piece:
	if the noun is examined, continue the action;
	now noun is examined;
	if the noun is the Twelvebytwelvian king:
		say "You and the [twelvebytwelvian] have a good working relationship that is not blemished by anything like friendship. You have nothing to say to each other, besides the obligatory flattery. He would nod pointedly at you to get back to work if you stared too long.";
	else:
		say "The [noun] avoids eye contact. That's probably for the best. You don't want to tip off any suspicions. When the time comes, you will nod, and your allies will act[if quest-dir is primary]--or not act, in the case of [the relevant traitor][end if].[paragraph break]";

to decide which piece is the relevant traitor:
	if grey knight is not irrelevant, decide on grey knight;
	decide on Fourbyfourian king;

to say waits-here: say "waits here, seemingly relaxed, but ready to spring to action"

chapter knight

a knight is a kind of piece.

the yellow knight is a knight. color of yellow knight is white. understand "n" and "yn" and "ny" and "n y" and "y n" and "y" and "fn" and "nf" and "f n" and "n f" as yellow knight. "The yellow knight [waits-here]."

the purple knight is a knight. color of purple knight is white. understand "n" and "pn" and "np" and "p n" and "n p" and "p" and "fn" and "nf" and "n f" and "f n" as purple knight. "The purple knight [waits-here]."

the grey knight is a knight. color of grey knight is black. understand "n" and "g" and "gn" and "ng" and "g n" and "n g" and "en" and "ne" and "e n" and "n e" as grey knight. "The traitorous grey knight waits here, expressionless."

chapter king

a king is a kind of piece.

the Twelvebytwelvian King is a king. color of Twelvebytwelvian king is white. understand "k" and "k12" and "12k" and "12" and "fk" and "kf" as twelvebytwelvian king. "Your king waits here for you to set everything just so."

the Fourbyfourian King is a king. color of Fourbyfourian king is black. understand "k" and "4k" and "k4" and "ke" and "ek" and "4" and "k e" and "e k" and "k 4" and "4 k" as fourbyfourian king. description is "Any sort of eye contact might cause the [fourbyfourian] to get suspicious. You can't have that.". "You shouldn't be able to see the Fourbyfourian king."

volume directions

quest-dir is a direction that varies. quest-dir is inside.

last-solved is a direction that varies. last-solved is inside.

chapter properties for quests

a direction can be unquestable, primary, or secondary. a direction is usually unquestable. [okay, number crunchers will note it's usually primary, but we want to set questable directions explicitly.]

a direction can be tried or untried. a direction is usually untried.

a direction can be unsolved, solved or stalemated. a direction is usually unsolved.

a direction has a piece called first-piece.

a direction has a piece called second-piece.

a direction has a rule called visit-text. visit-text of a direction is usually the trivially ignorable rule.

a direction has a rule called can-visit. can-visit of a direction is usually the trivially ignorable rule.

a direction has a rule called king-place. king-place of a direction is usually the trivially ignorable rule.

a direction has a rule called right-checkmate. right-checkmate of a direction is usually the trivially ignorable rule.

a direction has a rule called misc-checks. misc-checks of a direction is usually the trivially ignorable rule.

a direction has a list of rooms called already-solved.

a direction has a list of rooms called stalemate-recap.

a direction has a list of rooms called checkmate-recap.

a direction has text called quest-details.

a direction has text called hint-text.

a direction has text called quick-text.

a direction has text called summary-text.

a direction has text called recap-text.

section direction definitions

definition: a direction (called d) is questable: [ We can say "not unquestable" but I'd like to make clear code when necessary. ]
	if d is unquestable, no;
	yes;

definition: a direction (called d) is to-solve:
	if d is unquestable, no;
	if d is solved, no;
	yes;

section individual quest properties -- initial directions first

to say first-hints:
	say "You probably need [the second-piece of the item described] to block the enemy king's fleeing path"

first-piece of north is yellow bishop. second-piece of north is grey bishop. north is primary. hint-text of north is "[first-hints].". quick-text of north is "B vs. B". summary-text of north is "two bishops, one traitorous". recap-text of north is "In [q of north], you used the enemy bishop and your own king to wall in the enemy king.".

first-piece of northeast is yellow bishop. second-piece of northeast is grey knight. northeast is primary. hint-text of northeast is "[first-hints]. But this one's a bit different from the other three--one more thing to look for.". quick-text of northeast is "B vs. N". misc-checks of northeast is knight blocks bishop rule. summary-text of northeast is "a bishop and a traitorous knight". recap-text of northeast is "In [q of northeast], you had to put everyone in a Tetris L-shaped block, enemy king in the corner, to conquer him. If your bishop had been further away, the traitor knight would've had to save the king."

first-piece of west is yellow knight. second-piece of west is grey knight. west is primary. hint-text of west is "[first-hints].". quick-text of west is "N vs. N". summary-text of west is "two knights, one traitorous". recap-text of west is "In [q of west], you linked everyone in a sort of fish-hook to trap the enemy king, with the [twelvebytwelvian] farthest away. You couldn't keep the king two squares from the enemy king, as the enemy knight would be attacking."

first-piece of southwest is yellow knight. second-piece of southwest is grey bishop. southwest is primary. hint-text of southwest is "[first-hints].". quick-text of southwest is "N vs. B". summary-text of southwest is "a knight and a traitorous bishop". recap-text of southwest is "In [q of southwest], your king and knight faced the enemy king and bishop, each two squares away."

section individual quest properties -- advanced directions next

first-piece of south is yellow knight. second-piece of south is purple knight. king-place of south is two-knights-silly rule. visit-text of south is traitors-all-used rule. can-visit of south is traitors-all-used-bare rule. south is secondary. quest-details of south is "The bishop and knight checkmate is a tricky one. It took me a while to figure. I walked away saying, 'Hey, look, here's proof that the two bishops are better than a bishop and knight if pawns aren't in the way.' But one night I was able to put it together: you have to push the enemy king to the corner your bishop can't cover, then push the king to the other corner. Having the bishop two squares from your knight puts a lock on critical escape squares, and the checkmate taught me a lot about square control.". hint-text of south is "[piece-cooperation]". quick-text of south is "2 N's". summary-text of south is "two knights". recap-text of south is "In [q of south], knights were three squares away from each other, and you were off to the side of them, enough to trap the enemy king."

first-piece of east is yellow bishop. second-piece of east is purple bishop. king-place of east is no-corner-no-close rule. visit-text of east is traitors-all-used rule. can-visit of east is traitors-all-used-bare rule. east is secondary. quest-details of east is "Checkmate with two bishops and nothing else isn't too bad to figure out. You push the enemy king to the side of the board, where he has only two moves. Then you lose a move with one of the bishop as you roll him into the corner. However, I was shocked to learn one Chicago area master I respected greatly (I had a Learning Experience against him) was unable to convert the advantage in a tournament with long time controls.". hint-text of east is "[piece-cooperation]". quick-text of east is "2 B's". summary-text of east is "two bishops". right-checkmate of east is two-bishops-formation rule. recap-text of east is "In [q of east], you placed one bishop next to the king and the other on a diagonal. The king guarded the bishop close by."

first-piece of southeast is yellow bishop. second-piece of southeast is yellow knight. king-place of southeast is no-corner-no-close rule. visit-text of southeast is corner-cleared rule. can-visit of southeast is corner-cleared-bare rule. southeast is secondary. quest-details of southeast is "Checkmate with two knights against a king is impossible unless the opponent cooperates. However, two knights against a pawn may be very possible indeed, depending on where the pawn is. You can Google Troitsky Line for more on that. I remember reading an article about the endgame at math camp in high school. We were all pretty smart, but we didn't get far with it. Years later I read a blog post describing the strategies in an actual tournament game and remembered math camp. I felt pretty smart understanding the concept. Then I found out the person with the two knights ... wasn't in high school yet. I felt less smart.". hint-text of southeast is "[piece-cooperation]". quick-text of southeast is "B & N". summary-text of southeast is "a bishop and a knight". recap-text of southeast is "In [q of southeast], you positioned everyone in an L with the knight giving check, and you also positioned the king between his bishop and knight, to block out the enemy king on the edge."

to say hint-minor-vs of (d - a direction):
	say "You'll need to restrict the squares the enemy king can run to. Also, your [if yellow bishop is irrelevant]knight can check but not cover escape squares[else]bishop can check and cover an escape square, but your king can't cover the rest[end if]. How can you cover that final square?"

to say piece-cooperation:
	say "You want your king to cover two escape squares, with one minor piece checking and covering an escape square, and another covering two escape squares. There may be multiple solutions. If one fails you, it is probably used somewhere else. I just didn't want to let the player get through with too-similar solutions."

section quest solve rules

to decide whether half-final:
	if boolval of bn-close + boolval of bn-far is 1, yes;
	no;

bn-close is a truth state that varies. [NKBK all crowded together]

bn-far is a truth state that varies. [BKN on top row, K on bottom]

dupe-noted-yet is a truth state that varies. [ if you found, say, the same BB and NN mates ]

to poss-dupe-note:
	if dupe-noted-yet is false:
		now dupe-noted-yet is true;
		say "(NOTE: your solution was fully valid, but I'm being a bit of a stickler about finding different ways for the south and east [4b]s. Hope it's not too much inconvenience, or maybe that you find the additional challenge interesting.)";

definition: a piece (called p) is double-adjacent:
	if basic-dist of p and Fourbyfourian king is 1 and basic-dist of p and Twelvebytwelvian king is 1:
		yes;
	no;

this is the two-bishops-formation rule:
	if diag-dist of yellow bishop and purple bishop is 3 and basic-dist of yellow bishop and purple bishop is 3:
		say "[if south is solved]The Fourbyfourian king notices something is up. You remember that you had everyone in roughly the same place over in [q of south] with the two knights.  Perhaps you need to find a new way to corner the Fourbyfourian king. Too many similar moves may lead to proof of your activities[else]Something's up. The bishops cough at you, a bit confused. You shake your head, but they both shake their heads back. They wouldn't do this to you unless something was up.  So after the diplomatic meeting, you ask. They mention perhaps ... perhaps this specific maneuver may be more useful somewhere else.[paragraph break]They almost look satisified with that bit of thoughtful dialogue. So much of their work is just intimidating people into what to believe that a bit of logical futzing is refreshing. They seem to be thinking back wistfully to the good old days of dreaming about gaining vast power--so different from having to wield it constantly[end if].";
		poss-dupe-note instead;
	let temp be boolval of (whether or not yellow bishop is double-adjacent) + boolval of (whether or not purple bishop is double-adjacent);
	if temp > 0:
		say "The Fourbyfourian king feels a bit squished in by [if temp is 2]your two bishops[else]one of your bishops being THAT close--and, well, your king, for that matter, no offense. He makes an excuse to wriggle out just before you can close the net.";
		poss-dupe-note instead;

this is the knight blocks bishop rule:
	if Fourbyfourian king is not placed, continue the action;
	let Q be diag-dist of first-piece of quest-dir and Fourbyfourian King;
	say "[Q] diagonal distance.";
	if Q < 2, continue the action;
	note-amusing-stuff "bvn-miss";
	say "The enemy knight, who wants to cooperate with your cunning plan, unfortunately has no choice. The king being in danger, and the knight in obvious position to prevent it, jumps to action![paragraph break]";
	if Q is 2:
		say "A big fight ensues! A fake one, to impress the Fourbyfourian king and not really raise suspicions.[paragraph break]Eh well. There's more bishops where THEY came from.";
	else:
		say "The knight throws itself in front of the bishop. You have no choice but to dismiss the bishop in disgrace and assure the Fourbyfourian king you had nothing to do with it, and if you can help yourself, it won't happen again. The bishop looks ... less than happy. But you mention it is divine will, which the bishop can't argue with. After all, he's used that argument on some unlucky doomed unfortunates, himself.";
	retreat-to-unity;
	the rule succeeds;

section quest start rules

fourth-wall-warn is a truth state that varies.

this is the corner-cleared rule:
	consider the corner-cleared-bare rule;
	if the rule failed:
		say "You will need to conquer [q of south] or [q of east] to gain passage to [q of southeast][if number of primary not solved directions > 0], and for those, you'll need to ramp up with [q of random primary not solved direction][end if].";
		if jump-over is true:
			say "[line break]But since you enabled jumping-over as a beta tester, I'll let you by.[paragraph break]";
			continue the action;
		the rule fails;

this is the corner-cleared-bare rule:
	if east is unsolved and south is unsolved, the rule fails;
	the rule succeeds;

this is the traitors-all-used rule:
	consider the traitors-all-used-bare rule;
	if the rule failed:
		say "Tackling [q of noun] seems tactically unwise at the moment. You'll want to do as much as you can diplomatically. You still have [if number of solved directions is 3]a traitor[else]traitors[end if] willing to aid you elsewhere. Once the traitors helped you, [i]then[r] you can conquer the south and east with a bit more force. So you'll wan to take care of things to the [list of primary unsolved directions] first.";
		if fourth-wall-warn is false:
			now fourth-wall-warn is true;
			say "[line break]And, yes, this is totally not me saying that I believe certain [4b]s are easier to conquer than others, or at least, they have more similar themes, so you'll get off to a quicker start.";
		if jump-over is true:
			say "[line break]But since you enabled jumping-over as a beta tester, I'll let you by.[paragraph break]";
			continue the action;
		the rule fails;

this is the traitors-all-used-bare rule:
	if number of solved directions < 4, the rule fails;
	the rule succeeds;

volume verbs

chapter going to

rule for supplying a missing noun when gotoing:
	if player is in Ministry of Unity, try going outside instead;
	say "There are twenty-four other squares, so you'll need to be more specific.";
	reject the player's command;

carry out gotoing:
	abide by the already-here rule;
	if player is in Ministry:
		say "You need to depart from the Ministry before going anywhere." instead;
	if noun is Ministry:
		try going outside instead;
	let bd be diag-dist of location of player and noun;
	say "You take a [if bd is 1]brief[else if bd is 2]moderate[else if bd is 3]nice long[else]serious[end if] walk...";
	move player to noun;
	the rule succeeds;

chapter calling

does the player mean calling a reserved piece which is not the Fourbyfourian king: it is very likely.

does the player mean calling first-piece of quest-dir when first-piece of quest-dir is reserved: it is likely.

does the player mean calling second-piece of quest-dir when first-piece of quest-dir is placed and second-piece of quest-dir is reserved: it is likely.

does the player mean calling a placed piece: it is unlikely.

does the player mean calling an irrelevant piece: it is very unlikely.

this is the same-colored-bishops rule:
	unless number of placed bishops is 1, continue the action;
	let Q be a random placed bishop;
	unless location of Q and location of player are samecolored, continue the action;
	if grey bishop is irrelevant:
		note-amusing-stuff "bb-colors-second";
		if quest-dir is stalemated:
			say "But wait! You realize that you are about to place both your bishops on the same-colored square. You may break a lot of stuffy old rules in [12b], but that's not one of them, especially since breaking that rule gives no practical benefit. Okay, it actually harms you.[paragraph break]Somewhere else, maybe.";
		else:
			say "One of your bishops looks confused. The other looks very impressed. Each doesn't like the other being on their turf, but your unconventional approach of putting them on the same color square just might work ... this time. Or it might fail spectacularly.";
			continue the action;
	else:
		note-amusing-stuff "bb-colors-first";
		say "Your bishop and the enemy bishop look over at each other. They then both glare at you, as if in slight doubt of your leadership. They can't actually ... risk crossing paths, which might happen, since they're on the same color square.";
	the rule succeeds;

to decide which number is check-total:
	let temp be 0;
	repeat with Q running through placed pieces:
		if color of Q is black, next;
		if Q is Twelvebytwelvian king, next;
		if Q attacks the Fourbyfourian king, increment temp;
	say "[list of placed pieces] [temp].";
	decide on temp;

this is the excessive beatdown rule:
	if check-total is 2:
		note-amusing-stuff "beatdown";
		say "The pieces under your command look over at you questioningly. While they recognize what fun it is to both be attacking the Fourbyfourian king at once, they also consider such fun is not strategically sound. Still, you're the boss...";

rule for supplying a missing noun when calling:
	if location of player is Ministry of Unity:
		now noun is Twelvebytwelvian king;
		the rule succeeds; [doesn't matter. Same reaction for them all!]
	if Fourbyfourian king is reserved and number of reserved pieces is 1:
		say "(the Fourbyfourian king is last)[line break]";
		now noun is Fourbyfourian king;
		the rule succeeds;
	if Fourbyfourian king is reserved and number of reserved pieces is 2: [ maybe redundant but let's make sure ]
		now noun is a random reserved piece that is not the Fourbyfourian king;
		say "([the noun] before the Fourbyfourian king)[line break]";
		the rule succeeds;
	if Fourbyfourian king is placed and number of reserved pieces is 2: [ e.g. placed king, have BB or NN left so it doesn't matter ]
		if quest-dir is east or quest-dir is south:
			now noun is first-piece of quest-dir;
			say "([the noun], since it is functionally equivalent to [the second-piece of quest-dir])[line break]";
			the rule succeeds;
	say "I'll need something more specific, since I can't decide which piece to place of the remaining ones.";
	reject the player's command;

to decide whether you-stalemated:
	if Fourbyfourian king is checked, no;
	if Fourbyfourian king is immobile, yes;
	no;

to decide whether you-checkmated:
	unless Fourbyfourian king is checked, no;
	unless Fourbyfourian king is immobile, no;
	yes;

this is the stalemate dialogue rule:
	if debug-state is true, say "DEBUG: Stalemate achieved!";
	if quest-dir is primary:
		say "Oh no! You managed to trap the king but not attack him. I don't think there's a way to find this sort of stalemate, so it's impressive that you did.";
	else if quest-dir is stalemated:
		say "Again, you pretty much cornered the Fourbyfourian king without attacking him. Awkward laughter resonates in this diplomatic meeting. It only sort of builds up his trust. You know how it is, when someone oversells something? You might be risking that here. The Fourbyfourian king (fool) already trusts you enough. Next time, you can go fully on offense.";
	else:
		now quest-dir is stalemated;
		say "Oh my! The Fourbyfourian king is trapped, but not too trapped. After a lot of verbal manipulation, you manage to convince him that this show of almost-force is just standard negotiating technique, and if he can't trust you, who can he trust?[paragraph break]The diplomatic maneuver is thus a success. After a few hours, you take leave, confident your little feint will keep the Fourbyfourian king off-guard enough, you will get him next time.";
		now stalemate-recap of quest-dir is current-quest-snapshot;
	retreat-to-unity;
	the rule succeeds;

this is the checkmate dialogue rule:
	if quest-dir is secondary and quest-dir is not stalemated:
		say "But wait! The Fourbyfourian king feels a LITTLE too under attack. He excuses himself for ... well, a family emergency, an important jousting tournament to judge, another one of those banquets, you know.[paragraph break]";
		if number of solved secondary directions > 0:
			say "Ye Olde Bummeur. You mixed things up. You should have slow-walked it a bit more, as in [q of random solved secondary direction].";
		else if number of stalemated secondary directions > 0:
			say "Man! You felt like you had something there. But you didn't gain the king's trust as in [q of random stalemated secondary direction]. You'll need to do that.";
		else:
			say "Drat! You were a bit too aggressive. Perhaps if there were a way to make the Fourbyfourian king feel almost-trapped but let him off the hook ... then he could be suckered. But not now.";
		if already-solved of quest-dir is empty:
			say "Perhaps this will work later. You note the position in your head. Some scribe will write it down. Perhaps once you've gained the Fourbyfourian king's trust you won't attack him. Then, you can even say 'Ha, if I were going to fool you, I wouldn't use this exact same formation you'd been suspicious of, earlier.' People fall for that, even when they should know better.";
			now checkmate-recap of quest-dir is current-quest-snapshot;
			now already-solved of quest-dir is {};
		else:
			say "So that's another way to take down [q of quest-dir] when the time is right. Nice, though you only need one.";
		retreat-to-unity;
		the rule succeeds;

to decide which number is status-index of noun:
	if noun is Twelvebytwelvian king, decide on 1;
	if noun is first-piece of quest-dir, decide on 2;
	if noun is second-piece of quest-dir, decide on 3;
	decide on 4;

carry out calling:
	if location of player is Ministry of Unity, say "You don't need to call allies until you're away from the Ministry." instead;
	if noun is irrelevant, say "You don't need to call [the noun]." instead;
	if noun is Fourbyfourian king and number of reserved pieces > 1, say "You will want to call [the noun] last." instead;
	if number of pieces in location of player is 1, say "But [the random piece in location of player] is already there." instead;
	if noun is placed, say "But [the noun] is already at [location of the noun]." instead;
	say "You place [the noun] at [location of player].";
	move noun to location of player;
	if noun is a bishop:
		abide by the same-colored-bishops rule;
	now noun is placed;
	if Twelvebytwelvian king is placed:
		if Twelvebytwelvian king is checked:
			say "But wait. Your king would be under attack from the enemy there. You'll need to try again.";
			move noun to offsite;
			now noun is reserved;
			the rule succeeds;
	now entry (status-index of noun) of current-quest-snapshot is location of player;
	update-guarded;
	if noun is Fourbyfourian king:
		if number of reserved pieces > 1:
			say "You'll want to place the Fourbyfourian king last." instead;
		if diag-dist of Twelvebytwelvian king and Fourbyfourian king <= 1, say "You can't really place the enemy kings that close to each other. Oh, sure, they'll perform all the proper diplomacy ... but they really don't WANT to. At least, your king doesn't want to. He doesn't want his fingerprints on any ... disappearances." instead;
		consider the excessive beatdown rule;
		abide by the king-place of quest-dir;
		if you-stalemated, abide by the stalemate dialogue rule;
		unless Fourbyfourian king is checked:
			say "But the [4n] king is not checked. So nothing really happens.";
			if quest-dir is secondary:
				say "[line break]And unfortunately this [if quest-dir is stalemated]doesn't put the enemy king any more at ease[else]is not enough to put the enemy king at ease. You'll need to get them into a seemingly tougher situation, then let them slip out[end if].";
			say "[line break]You're able to blow it off as the sort of diplomatic meeting people have to have. You even put some backhanded blame on the enemy monarch for wasting YOUR king's time and not providing the sort of hospitality you expect. It doesn't really hurt them, but it does cover up your far more serious intent. So there'll be another chance. Just got to plan a bit better, next time.";
			if quest-dir is secondary:
				say "";
			if screen-reader is false, show-the-board;
			move player to Ministry of Unity;
			the rule succeeds;
		abide by misc-checks of quest-dir;
		if you-checkmated:
			abide by the checkmate dialogue rule;
			abide by right-checkmate of quest-dir;
			if debug-state is true, say "DEBUG: Checkmate achieved.";
			now quest-dir is solved;
			now checkmate-recap of quest-dir is current-quest-snapshot;
			now last-solved is quest-dir;
			if number of to-solve directions is 0:
				say "You win, yay!";
				end the story finally;
				the rule succeeds;
		else:
			say "Oh no! The Fourbyfourian king escapes.";
		retreat-to-unity;
		the rule succeeds;
	if screen-reader is false, continue the action;
	show-the-board;
	if map-notes-flag is false:
		now map-notes-flag is true;
		say "Now that you've placed a piece, you can toggle seeing maps in the room description with [b]TOGGLE[r] or [b]T[r].";
	the rule succeeds;

to retreat-to-unity:
	move player to Ministry of Unity;
	new-quest;

to new-quest:
	now quest-dir is tried;
	reset-guard;
	now all pieces are irrelevant;
	now all kings are reserved;
	now first-piece of quest-dir is reserved;
	now second-piece of quest-dir is reserved;
	now current-quest-snapshot is { Ministry, Ministry, Ministry, Ministry };
	reset-board;

to reset-board:
	repeat with P running through pieces:
		move P to offsite;
	repeat with P running through placed pieces:
		now P is reserved;

definition: a piece (called p) is not-last:
	if p is Fourbyfourian king, no;
	if p is reserved, yes;

section rules for what's guarded

to knight-mark (p - a piece):
	let myx be xval of location of p;
	let myy be yval of location of p;
	repeat through table of knight offsets:
		let newx be myx + the-x entry;
		let newy be myy + the-y entry;
		let RR be room-from-nums of newx and newy;
		if RR is offsite, next;
		now RR is guarded;

to bishop-mark (p - a piece):
	repeat with Q running through diagonal directions:
		let temp-room be the room Q of location of P;
		while temp-room is not nothing:
			now temp-room is guarded;
			if number of pieces in temp-room is 1, break;
			now temp-room is the room Q of location of temp-room;

table of knight offsets
the-x	the-y
2	1
2	-1
-2	1
-2	-1
1	2
1	-2
-1	2
-1	-2

to update-guarded:
	repeat with Q running through placed pieces:
		if color of Q is black, next;
		if Q is a bishop, bishop-mark Q;
		if Q is a knight, knight-mark Q;

section rules for placing

this is the no-corner rule:
	if location of player is cornery:
		say "The [fourbyfourian], alas, knows your tricks. He won't be snuck into some corner, at least not without any allies. You'll have to find somewhere else to 'invite' him.";
		the rule fails;

this is the no-corner-no-close rule:
	abide by the no-corner rule;

this is the two-knights-silly rule:
	if location of player is cornery and you-checkmated:
		say "While the [fourbyfourian] sees what's up and booms 'You can't force me there,' you have an idea. You technically ... really ... couldn't, even if everyone alternated moves. But if you could make someone, or a whole society, think that way ... what power you would have! Perhaps you could tie it up with some 2+2=5 motivational nonsense as well.[paragraph break]Also, you recall some egghead advisor rambling on about how a traitorous pawn or page could help you conquer [cq] effortlessly, but it seemed too nonsensically far out for you. Easier just to tackle the [fourbyfourian] on the edge.";
		note-amusing-stuff "orwell";
		retreat-to-unity;
		the rule fails;

section disambiguating when nothing is relevant

Include (-
[ FindInParseList obj i k marker;
marker = 0;
for (i=1 : i<=number_of_classes : i++) {
while (((match_classes–>marker) ~= i) && ((match_classes–>marker) ~= -i)) marker++;
k = match_list–>marker;
if (k==obj) rtrue;
}
rfalse;
];
-)

To decide whether (N - an object) fits the parse list: (- (FindInParseList({N})) -)

definition: a thing is matched if it fits the parse list.

rule for asking which do you mean when everything matched is irrelevant (this is the bypass disambiguation rule):
	if the current action is calling:
		say "Everyone matching that request isn't part of the current maneuvers, so I can't figure anyone to call.";
		bypass disambiguation;
		the rule succeeds;
	continue the action;

rule for asking which do you mean when everything matched is not reserved (this is the bypass disambiguation 2 rule):
	if the current action is calling:
		say "Everyone matching that request is either placed or not part of the current maneuvers, so I can't figure anyone to call.";
		bypass disambiguation;
		the rule succeeds;
	continue the action;

chapter maps

carry out boarding:
	if location of player is ministry of unity, say "There is no map to look at right now." instead;
	say "STRATEGIC MAP OF [printed name of quest-dir in upper case] FOURBYFOURIA SO FAR:[line break]";
	if screen-reader is true, say "Since you are using a screen reader, text maps are disabled. You'll need to restart if you want to use them." instead;
	show-the-board;
	the rule succeeds.

to show-the-board:
	if screen-reader is true:
		repeat with Q running through placed pieces:
			say "[Q] is at [location of Q].";
		continue the action;
	say "[fixed letter spacing]  a b c d e[line break]";
	say "5[pie of a5][pie of b5][pie of c5][pie of d5][pie of e5] 5[line break]";
	say "4[pie of a4][pie of b4][pie of c4][pie of d4][pie of e4] 4[line break]";
	say "3[pie of a3][pie of b3][pie of c3][pie of d3][pie of e3] 3[line break]";
	say "2[pie of a2][pie of b2][pie of c2][pie of d2][pie of e2] 2[line break]";
	say "1[pie of a1][pie of b1][pie of c1][pie of d1][pie of e1] 1[line break]";
	say "  a b c d e[variable letter spacing][paragraph break]";

to say pie of (rm - a room):
	say " ";
	if grey bishop is in rm:
		say "b";
	else if yellow bishop is in rm or purple bishop is in rm:
		say "B";
	else if grey knight is in rm:
		say "n";
	else if yellow knight is in rm or purple knight is in rm:
		say "N";
	else if twelvebytwelvian king is in rm:
		say "K";
	else if Fourbyfourian king is in rm:
		say "k";
	else if rm is guarded:
		say "+";
	else if location of player is rm:
		say "*";
	else:
		say "-";

volume meta-verbs

chapter colorchating

colorchating is an action out of world.

understand the command "pvy" as something new.
understand the command "yvp" as something new.

understand "pvy" as colorchating.
understand "yvp" as colorchating.

carry out colorchating:
	say "I wanted to choose 'opposite' colors from the red/yellow/blue primary and secondary colors. Blue and orange is only nice if you're a Chicago Bears fan or, worse, you actually enjoyed going to the high school I attended, you utter bum, you. Red and green is for, well, Red Green or Santa Claus, both of whom are cool and all, but not for this game. I considered brown and tan, to underscore that there wasn't any difference, but it didn't work. But I wanted to avoid the white/black seen in chess.[paragraph break]I also wanted to avoid words that started with N, B or K, because I wanted the color abbreviations to make things clearer, not confuse people.";
	the rule succeeds;

chapter abbing

ironic-ab is a truth state that varies.

carry out abbing:
	say "You can use abbreviations while placing pieces. They were meant to be relatively intuitive. [4n] traitor pieces are always grey. Your [12n] allies can be either yellow or purple.";
	say "[line break]You can also abbreviate pieces with K for king, N for knight, and B for bishop. Combining these with the piece color abbreviations Y for yellow and P for purple ([12n],) and G for grey ([4n],) you can refer to any piece in two characters, you can refer to a piece specifically. In addition, if you have the same type of yellow and purple piece on the board, and you just say B, the game picks one, because they are functionally equivalent.";
	say "[line break]So this means you can type something short like [b]P YB[r] or [b]P BY[r] to place a yellow bishop. Combined with being able to type a square to visit it, this hopefully reduces the need to fight with the parser.";
	say "[line break]While kings don't have colors, the enemy king is always the final one to call, so the game knows what you mean if you type K. But you can also say [b]FK[r], [b]KF[r], [b]12K[r], [b]K12[r] for the friendly king explicitly, or [b]EK[r], [b]KF[r], [b]4K[r], [b]K4[r] for the enemy king.";
	say "[line break]You can also use spaces in these abbreviations, if you don't like the weird nonsense words or whatever.";
	if ironic-ab is false:
		now ironic-ab is true;
		say "[line break]And yes, it's also worth noting and snickering at, if you wish, how [b]ABB[r] is not as abbreviated as [b]A[r] for about. But I figure people will see [b]ABOUT[r] first.";
	the rule succeeds;

chapter abouting

carry out abouting:
	say "[this-game] is a sequel to [5b], my entry in the 2021 ParserComp. I first had the idea for [this-game] a week or so before the deadline. Obviously, I couldn't do much with it besides write out the basic stuff. Most of the puzzles revolve around checkmates with very few pieces left on the board. I wondered how many I could find. I had some problems with solutions being too similar. But it seemed there was enough for a challenging game.";
	the rule succeeds;

chapter ching

carry out chessing:
	say "The rules of chess are that each player gets alternate turns, but here, you get to move as much as you want.";
	say "[line break]The only pieces you need to worry about are the knight, bishop and king.";
	say "[line break]The king can move one square in any direction, straight or diagonally. While you'll probably want to put the [4n] king in check (a bishop or knight can attack it,) you don't want the [12n] king in check. You also can't place opposing kings next to each other.";
	say "[line break]Bishops can move diagonally across the length of the board, but they can't jump over other pieces. You'll usually want bishops on the same color squares, to maximize the total squares they cover.";
	say "[line break]Knights move one square vertically and two squares horizontally, or two horizontally and one vertically. Even if other pieces, enemy or friendly, are in the way.";
	say "[line break]After placing a friendly piece, you should be able to use [b]MAP[r] to see what squares are attacked.";
	the rule succeeds;

chapter creditsing

carry out creditsing:
	say "Thanks to chess.com, lichess.org, chessgames.com, and everyone who helped chess streaming become popular during the pandemic. It saved my sanity enough to write [this-game], which will hopefully not take too much of yours. Thanks to Adam Sommerfield for ParserComp, which led to this game.";
	say "[line break]Thanks to Robin Johnson, whose technical suggestion for [5b] paid quick dividends in [this-game].";
	say "[line break]If you find a bug or have a transcript, mail me at [email]. Or you can report bugs at [github].";
	the rule succeeds;

chapter detailing

rule for supplying a missing noun when detailing:
	if player is in Ministry of Unity:
		say "There are no specific fourth-wall technical details for the Ministry of Unity. You should specify a directional [4b] here or go out in the field to see more.";
		reject the player's command;
	now noun is quest-dir;

detailing is an action applying to one visible thing.

understand the command "details" as something new.
understand the command "detail" as something new.
understand the command "d" as something new.

understand "details" as detailing.
understand "details [direction]" as detailing.
understand "detail" as detailing.
understand "detail [direction]" as detailing.
understand "d" as detailing.
understand "d [direction]" as detailing.

carry out detailing:
	if noun is primary:
		say "I remember discovering a minor piece vs. minor piece checkmate many years ago. Then I discovered a couple others. It always amused me. A post on chess.stackexchange brought old memories of this. You may be amused to note that, because of the possibility of checkmate even with cooperative play, professional blitz-chess play may allow participants to claim a forfeit with minor piece vs. minor piece, but they could not with minor piece vs. king." instead;
	if noun is secondary and number of solved directions < 4, say "You'll be able to see what's [noun] soon enough, but it's not open yet." instead;
	if noun is southeast and number of solved directions < 5, say "You'll be able to see what's [noun] soon enough, but it's not open yet." instead;
	if noun is not questable, say "There are no quests [noun]." instead;
	if quest-details of noun is empty, say "There are no details for [noun], but there should be." instead;
	say "[quest-details of noun][line break]";
	the rule succeeds;

chapter failing

carry out failing:
	if player is in Ministry of Unity, say "Get ahold of yourself! Positive thinking and all that sort of thing! It won't do to admit failure." instead;
	say "You walk away, feigning boredom, pretending to the [4n] King it was HIS fault the negotiations, or whatever ... failed. This gaslighting doesn't work often, but it's worth the (lack of) effort.";
	try going outside instead;

chapter hinting

carry out helping:
	if walkthrough-hint is false:
		now walkthrough-hint is true;
		say "NOTE: if you want full hints, the walkthrough.txt file that came with this binary should have the details. This command tries to give you hints without spoiling anything." instead;
	if player is in Ministry of Unity, say "You have nothing to do in the [unity], but you can hint a direction if you want, for specific [4b]s." instead;
	if debug-state is false:
		abide by the visit-text of noun;
	try hintdiring quest-dir;
	the rule succeeds;

section hintdiring

hintdiring is an action applying to one visible thing.

understand "h [direction]" as hintdiring.

carry out hintdiring:
	if noun is not questable, say "No [4b] exists that way to conquer." instead;
	if noun is untried, say "You haven't been to [q of noun] yet, so I don't want to give any hints." instead;
	if noun is solved, say "You've already conquered [q of noun], so I won't show these hints. You can restart the game or look at the source if you really want to see them, or you can [b]R[r] or [b]RECAP[r] to see details." instead;
	if noun is primary:
		say "[hint-text of noun][line break]";
	else if noun is secondary:
		say "[piece-cooperation][line break]";
	else:
		say "Note that since [q of southeast] is your final conquest, you need to solve it two ways.";
	the rule succeeds;

chapter metaing

metaing is an action out of world.

understand the command "meta" as something new.
understand the command "met" as something new.
understand the command "me" as something new.

understand "meta" as metaing.
understand "met" as metaing.
understand "me" as metaing.

carry out metaing:
	say "Here is a list of meta-verbs and options you can use. None are necessary to complete the game, but they can all be useful.";
	say "[line break][b]ABOUT[r] or [b]A[r] tells about the game. [b]CREDITS[r] or [b]C[r] tells more technical details and thanks testers. [b]CHESS[r] or [b]CH[r] gives the relevant rules of chess. [b]DETAILS[r]/[b]DETAIL[r]/[b]D[r] gives some fourth-wall meta-details.";
	say "[line break][b]MAP[r] or [b]M[r] or [b]BOARD[r] or [b]B[r] shows the current map. [b]TOGGLE[r] or [b]T[r] toggles the map.";
	say "[line break][b]HINT[r] or [b]H[r] hints your current area or, if you give a direction, an area you've tried but haven't beaten yet.";
	if number of solved directions > 0, say "[line break][b]R[r] or [b]RECAP[r] is available to recap areas you've solved. By default, it goes to the last one, but you can specify a direction.";
	the rule succeeds;

chapter recaping

recaping is an action applying to one visible thing.

understand the command "recap" as something new.
understand the command "r" as something new.

understand "recap [direction]" as recaping.
understand "r [direction]" as recaping.
understand "recap" as recaping.
understand "r" as recaping.

rule for supplying a missing noun when recaping:
	now the noun is last-solved;

to say list-out of (L - a list of rooms) and (d - a direction):
	say "[the Twelvebytwelvian king] at [entry 1 of L], [the first-piece of D] at [entry 2 of L], [the second-piece of D] at [entry 3 of L], and [the Fourbyfourian king] at [entry 4 of L]";

carry out recaping:
	if number of solved directions is 0, say "You have no conquers to recap. Yet." instead;
	if noun is not questable, say "That's not a [4b] to conquer." instead;
	if noun is not solved:
		say "You haven't taken over [q of noun] yet[if noun is untried]. In fact, you haven't even been there[end if].";
		if noun is primary, say "[line break]In [q of noun], you'll need the help of [the first-piece of noun] and [the second-piece of noun].";
		the rule succeeds;
	if recap-text of noun is empty, say "[q of noun] needs recap text." instead;
	say "[recap-text of noun]";
	say "[paragraph break]Here are specifics of conquering [q of noun]:";
	if noun is secondary:
		say "[line break]  [if noun is solved]Y[else]So far, y[end if]ou gained the enemy king's trust (stalemated) with [list-out of stalemate-recap of noun and noun].";
	say "[line break]  You [if noun is secondary]then [end if]captured the enemy king (checkmated) with [list-out of checkmate-recap of noun and noun].";
	the rule succeeds;

chapter toggleing

carry out toggleing:
	if screen-reader is true, say "Since you are using a screen reader, text maps are disabled. You'll need to restart if you want to use them or change their options." instead;
	now map-view is whether or not map-view is false;
	say "Map view toggled to [on-off of map-view].";
	if map-view is false, the rule succeeds;
	say "[line break]";
	if player is in ministry of unity, say "Maps won't be shown until you leave the [Ministry], however." instead;
	say "Showing the map.";
	show-the-board;
	the rule succeeds;

chapter verbs

carry out verbsing:
	say "[this-game] uses a simplified parser. The main commands are the planar directions: [b]N[r], [b]S[r], [b]E[r], [b]W[r], [b]NW[r], [b]NE[r], [b]SW[r], [b]SE[r]. [b]U[r] and [b]D[r], for up and down, aren't used. [b]OUT[r] anywhere but the [ministry] returns you to the [ministry].[paragraph break]You can also ignore directions to jump to a square when you're not in the Ministry of Unity. So typing [b]a1[r] sends you to a1, etc.[paragraph break]You can also [b]CALL[r]/[b]C[r] or [b]PLACE[r]/[b]P[r] a piece, enemy or friendly. These have abbreviations, too: [b]ABB[r] finds them.[paragraph break]Meta-verbs and options are discussed in [b]META[r] ([b]MET[r]/[b]ME[r]).";
	the rule succeeds;

chapter xyzzy

carry out xyzzying:
	note-amusing-stuff "xyzzy";
	if player is in Ministry of Unity:
		say "The x-y plane provides enough challenges, thank you very much. You don't want or need to deal with 3-d visualization. Maybe some younguns with fresher brains could figure it out. Oh, and tackle the toughies in the underworld.";
	else:
		say "You wouldn't want to pick a fight with any 26-wide country, that's for sure. Also, there are no secret doors on the west side of the castle."

volume amusing post-game

Rule for amusing a victorious player:
	look-for-amuse false;
	look-for-amuse true;

to look-for-amuse (t - a truth state):
	let any-flagged-yet be false;
	let any-unflagged-yet be false;
	repeat through table of amusing stuff:
		if done-yet entry is t:
			if any-flagged-yet is false:
				now any-flagged-yet is true;
				say "YOU [if t is true]ALREADY TRIED[else]COULD TRY[end if]:[line break]";
			say "    ----[amuse-list entry][line break]";
		else:
			now any-unflagged-yet is true;
	if t is true and any-unflagged-yet is true, continue the action;
	if debug-state is false, continue the action;
	if t is false:
		if any-flagged-yet is true or game-over, continue the action;
	say "Impressive! You found all my cheap jokes. Thanks for exploring so diligently."

to note-amusing-stuff (t - text):
	repeat through table of amusing stuff:
		if t is code entry:
			now done-yet entry is true;
			continue the action;
	say "WARNING: tried to note you already did amusing stuff with code [t] but couldn't find it in the table. Let me know at [email].";

table of amusing stuff
code	done-yet	amuse-list
"beatdown"	false	"Constructing a double check (both allies, no traitors, attacking the Fourbyfourian king)"
"bvn-miss"	false	"Placing the bishop too far from the king when you have the traitor knight"
"bb-colors-first"	false	"Placing two opposing bishops on the same color tile"
"bb-colors-second"	false	"Placing your two bishops on the same color tile"
"northwest"	false	"Going northwest in the [ministry]"
"orwell"	false	"Checkmating with two knights and a king in the corner"
"xyzzy"	false	"Everyone's favorite* text-adventure in-joke, XYZZY"

volume parser rules and errors

rule for printing a parser error:
	say "I didn't recognize that command. Type [verbs] to see the full list of commands. If you're confused what to do, [b]X[r] your manual again[if player is not in ministry of unity], or refer to the current [b]MAP[r][end if]."

volume beta testing - not for release

when play begins:
	if debug-state is false, say "Note you can use the J command to jump to areas that might be too advanced in release mode.";

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

volume meta

report undoing an action:
	say "Undone[if number of placed pieces is 0 and player is not in Ministry of Unity], though until you've placed a piece, there's nothing worth undoing[end if]. Note you can always undo everything by going [b]OUT[r][if player is in Ministry of Unity] once you're in a [4b][end if].";

volume when play begins

the player is in Ministry of Unity. description of player is "You're ... distinguished. A distinguished spy. Or people say you are. Distinguished, that is. Anyone saying you were a spy, even as a joke ... no. No. They would not."

to say stalemate-ticks:
	repeat with Q running through secondary directions:
		if Q is stalemated, say "+";

when play begins (this is the assign variables and check for skips rule):
	now left hand status line is "[if player is in Ministry of Unity][location of player][else][q of quest-dir], [location of player] ([quick-text of quest-dir])";
	now right hand status line is "[number of solved directions][stalemate-ticks]/[number of questable directions]";
	repeat with xval running from 0 to 4:
		repeat with yval running from 0 to 4:
			let r be room-from-nums of xval and yval;
			let rn be room-from-nums of xval and yval + 1;
			let re be room-from-nums of xval + 1 and yval;
			let rne be room-from-nums of xval + 1 and yval + 1;
			if rn is not offsite:
				now rn is mapped north of r;
				now r is mapped south of rn;
			if re is not offsite:
				now re is mapped east of r;
				now r is mapped west of re;
			if rne is not offsite:
				now rne is mapped northeast of r;
				now r is mapped southwest of rne;
			if rn is not offsite and re is not offsite:
				now rn is mapped northwest of re;
				now re is mapped southeast of rn;
	if debug-state is false:
		process the check-skip-intro rule;
		unless the rule succeeded, print-intro;

when play begins (this is the screen read check rule):
	if debug-state is true, continue the action;
	say "[this-game] has an option to use text maps in some places. This may cause problems with a screen reader. Are you using a screen reader?";
	if the player consents:
		now screen-reader is true;

when play begins (this is the randomizing colors rule):
	if a random chance of 1 in 2 succeeds:
		now first-piece of north is purple bishop;
	else::
		now first-piece of northeast is purple bishop;
	if a random chance of 1 in 2 succeeds:
		now first-piece of southwest is purple knight;
	else::
		now first-piece of west is purple knight;
	if a random chance of 1 in 2 succeeds:
		now first-piece of southeast is purple bishop;
	else:
		now second-piece of southeast is purple knight;
	if a random chance of 1 in 2 succeeds:
		now first-piece of south is purple knight;
		now second-piece of south is yellow knight;
	if a random chance of 1 in 2 succeeds:
		now first-piece of east is purple bishop;
		now second-piece of east is yellow bishop;

after printing the locale description when instructions-given is false:
	say "[bracket][b]NOTE[r]: to get you started, [b]ABOUT[r] or [b]A[r] will give general information about [this-game]. [verbs] will show common verbs, which usually have abbreviations, and [b]CHESS[r] or [b]CH[r] will give the relevant rules of chess.[close bracket][line break]";
	now instructions-given is true;
	continue the action;

to print-intro:
	say "The treaty was signed at the first Council of Sensibly Bordered Nations. After [12b] annexed [5b], you, who had risen to the office of Cheap Diplomat, assured the seven [4n] ministates that of COURSE there would be no further conquests. While swooping up the seven of them would increase [12b]'s size almost doubly, why, you'd have to rename yourself Sixteenbysixteenia in the process, and that was just too awkward a name.";
	wfak;
	say "That was good enough for them, but not really. They established border patrols. They improved their spying. You brought up their paranoia, their spying, at future Councils, mentioning how [12b] has more landmass than the [4b]s combined, but who got seven times the votes? Not this guy! If there was anyone not to trust, it was those rinky-dink kingdoms whispering among each other. And with each year that passed, you expected to gain trust you wouldn't attack and gobble them up, but they only seemed to suspect you more. Even as you built up armies in the northwest frontier, against bigger, tougher countries!";
	say "You'd let them bait you long enough. You see, after the first council, a courtier suggested in private that, perhaps, Sixteenbysixteenia wasn't the only possible name if the [4b] ministates were vacuumed up. Largeboxica! Doubleboardistan! Foursquaresquareland! Even Twofiftysixia!";
	wfak;
	say "Obviously a much more level-headed fellow than that nutcase who claimed the sun and moon didn't follow [12b] ... or whatever [12b]'s real name should be. Well, level-headed until he expected an advanced title. He should have just let you buy his silence. It would have been more than generous. And the ex-nations newly in the fold? Why, they could vote on the favorite name!";
	wfak;
	say "And if those full-square-worldists wanted to oppose your forging a bit of unity that actually made [i]sense[r], well, you would expose their inconsistencies! Still, there is a matter of diplomacy. No all-out wars. A mission, between high-ranking officers of each state. You've had time to culivate some allies in the ranks of some of the outer realms. Not quite the inner ones, yet.";
	wfak;
	say "You've gotten too old and fat, I mean distinguished, to ride your super-speedy horse that served so well annexing [5b]. It's slowed down quicker than you did. But no matter. Business can be conducted in castles -- five-by-five affairs, proof the [4b]s are a bit too big for their britches.";
	wfak;
	say "In the Ministry of Unity, the final touches are laid on the plans. Four of the satellite nations have traitors, waiting for power, who will help you. The others--well, you will need to strike quickly and not be too obvious. You flip an ocataroon towards the scribe who applies the finishing touches of an odd script, made just for you, called 'BASIC ENDGAME MANUAL.' And off you go!";
