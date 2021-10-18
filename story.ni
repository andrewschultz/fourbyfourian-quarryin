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

to say 5d:
	say "[i]Fivebyfivia Delenda Est[r]"

to say q of (d - a direction):
	say "[printed name of d in title case] [4b]";

to say cq:
	say "[q of quest-dir]"

to say k of (d - a direction): [?? we can replace more text with this]
	say "[printed name of d in title case] [4n] King"

to say ck:
	say "[k of quest-dir]"

to say github: say "https://github.com/andrewschultz/fourbyfourian-quarryin"

section meta/option booleans

map-view is a truth state that varies. map-view is true.

map-notes-flag is a truth state that varies.

instructions-given is a truth state that varies.

walkthrough-hint is a truth state that varies.

hard-mode is a truth state that varies.

section scoring

check requesting the score:
	say "This game doesn't keep a score, but to track your progress, you've helped 'reunite' [number of solved directions] of [number of questable directions] [4s] so far[if number of solved directions > 0]: [list of solved directions][end if][if number of stalemated directions > 0].[paragraph break]You've gained the trust of [trusted-kings], as well[end if][one of].[paragraph break]This is all tracked in the upper-right status bar[or][stopping].";
	if debug-state is true:
		say "=============DEBUG DETAILS[line break]";
		say "Normal checkmates: [list of normal-checkmated directions].";
		say "Hard checkmates: [list of hard-checkmated directions].";
		say "=============DEBUG DETAILS[line break]";
		say "Normal stalemates: [list of normal-stalemated directions].";
		say "Hard stalemates: [list of hard-stalemated directions].";
	the rule succeeds;

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
	if player is in observation grounds:
		say "Here you could be examining anyone or anything, so you'll have to be more specific.";
		reject the player's command;

The tricky endgame manual is a thing. The player carries the tricky endgame manual. description of tricky endgame manual is "Sadly, it's filled with a lot of rah-rah general concepts about believing in yourself and trusting your intuition (well, duh. If you didn't, you wouldn't have come this far in life) yet checking your work and not moving too quickly or too slowly. There's also a note to make sure every ally is doing their part, because nobody can do too much. Duh, again.[paragraph break]The worst bit is the flowery writing (including [your-pals]) but low on useful details. Irrelevant rubbish. If anyone deserves a hagiography, it's you. You're quite good at telling people you don't really deserve all this praise, and yet they insist anyway!"

after examining tricky endgame manual when player is not in Ministry:
	if quest-dir is secondary:
		say "Oh, wait. There is some note about how the [4n] king here is suspicious of being cornered these days, what with his neighbors disappearing mysteriously[if number of not irrelevant bishops is 2]. Also, he's a bit scared of being right next to a bishop who's right next to another monarch. He can't see the other king that way, but if the other king's even slightly off to the side, like on a diagonal, that's okay. Man, people have weird social phobias![else].[end if]";
		say "[line break]Also, there's a note about how you probably can't trap the [4n] king violently right away. Find a way to fake him out. Make him feel surrounded, not attacked, at the first meeting. Then go in for the kill[if quest-dir is stalemated]. Hey, first part completed[end if].";
	else:
		say "Oh, wait. There is some note about general procedure: first, you will want to make the [4n] king feel surrounded but not attacked. Stalemate, they call it. Then, once you've forced a bit of trust out of him, a traitorous courtier will help you attack and trap him for good.  And you probably can't trap him way out in the center of the board!";
	say "[line break]Of course, it can't mention any incriminating specifics: [who-coop]."

to say who-coop: say "you need the cooperation of [the list of cooperative pieces] to take down the [k of quest-dir]"

definition: a piece (called p) is cooperative:
	if color of P is black and quest-dir is primary and quest-dir is unsolved, no;
	if P is fourbyfourian king, no;
	if P is irrelevant, no;
	yes;

to say your-pals:
	if quest-dir is primary:
		say "a gratuitous biography of the [first-piece of quest-dir][if quest-dir is stalemated] with no mention of your secret helper, the [second-piece of quest-dir][end if]";
	else:
		say "gratuitous biographies of the [first-piece of quest-dir] and [second-piece of quest-dir] helping you here";

check examining manual when location of player is not puzzly:
	say "You read up on the basics of taking down an enemy king with [if number of solved directions > 4]one ally and one equally-strong traitor[else]two relatively inauspicious allies[end if]. But it's all a bit dry and technical, and you'll know what specifics apply better once you leave the the planning areas.";
	if player is in observation grounds, say "[line break]You may also want to [xbold] your allies here for refreshers on how they work alone or together.";
	the rule succeeds;

instead of doing something other than examining tricky endgame manual:
	say "You can really only [xbold] the [manual]." instead;

check taking inventory:
	say "All you have on you, besides various expensive rings and medals designating your position as a prominent [12n], is a tricky, yet very dry, endgame manual. It simply wouldn't do to be found with any incriminating plans on you! Or even to have them turn up later.[paragraph break]You can type [b]X[r] at any time outside the Ministry and Observation Grounds to see what needs to be done. Inside, [b]X[r] will examine the map of the [4s].";
	if player is not in Ministry of Unity, say "[line break]Here, [who-coop].";
	the rule succeeds;

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

chapter unity

the Ministry of Unity is a not puzzly room. xval is 8. yval is 8. "The planning has been done. [can-leave][tried]. For refreshers on who does what, you can go [b]IN[r] or [b]INSIDE[r] to the observation grounds.[paragraph break]A map of [12b] and the surrounding [4s] adorns one wall[one of]. You can [xbold] it for details, if you want[or][stopping].".

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
	say ". You've[if tried-unsolved > 0] been to [list of tried unsolved directions] before[end if][if tried-unsolved > 0 and stalemates > 0] and[end if][if stalemates > 0] made good progress to the [list of stalemated directions][end if]";

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

the knight move check rule is listed first in the check going rulebook.

the note boundaries rule is listed before the can't go that way rule in the check going rulebook.

check going outside:
	if location of player is not observation grounds, try exiting instead;

check exiting (this is the blanket exit rule):
	if location of player is Ministry of Unity:
		if number of unsolved directions is 1:
			let D be a random unsolved direction;
			say "Only one direction to go out: [D]. So you do.";
			try going D instead;
		say "You need to specify a compass direction to go out from the Ministry of Unity.";
		the rule succeeds;
	say "You return to the Ministry of Unity. The conquest of [cq] can wait for later.";
	repeat with P running through pieces:
		now P is irrelevant;
		move P to offsite;
	move player to Ministry of Unity;
	the rule succeeds;

the blanket exit rule is listed before the can't exit when not inside anything rule in the check exiting rulebook.

check going (this is the knight move check rule):
	if noun is normal, continue the action;
	say "You don't have your fast horse any more. It's been long moved to the great pasture in the sky.[paragraph break]";
	if location of player is not puzzly:
		note-amusing-stuff "knight-moves-1";
		say "Besides, seven [4s] are enough to conquer. You can only take over so many before bigger countries consider an alliance against you." instead;
	let to-room be room-from-nums of (xval of location of player + xness of noun) and (yval of location of player + yness of noun);
	if to-room is offsite:
		say "That's outside the castle bounds, and there are no secret doors to [square of noun]. As a youngster, you've had enjoyed imagining just [i]visiting[r] such a place, but now that you're grown up and responsible, such daydreams are an impractical extravagance that disrupt your duty to your country.";
	else:
		say "Besides, if you want to go to [to-room], you can just type [to-room] at the command prompt. You'll save 33% of keystrokes that way. Okay, 25% if you count the carriage return. But ... you don't need your horse, though you miss it, of course, of course.";
	note-amusing-stuff "knight-moves-2";
	the rule fails;

check going (this is the reject verticals rule):
	if noun is up or noun is down:
		say "Flying machines are a century or more away." instead;

check going when location of player is not puzzly (this is the hub check rule):
	let cur-row be 0;
	if noun is northwest:
		note-amusing-stuff "northwest";
		say "Alas, the vast lands northwest of [12b] are so unruly as to feature nonlinear borders. Some such borders are not even defined by rivers![paragraph break]Plus, they're vast enough, it'd take too long to get to their capitals. Oh, and the whole painful winters and large armies things, too." instead;
	if noun is inside or noun is outside, continue the action;
	if noun is unquestable, say "There's nothing to conquer to the [noun]." instead;
	if noun is solved, say "Of course, it would be pleasant to return to the scene of your success at [q of noun]. You will, eventually. There will be a great banquet and everything, the most unsurprising surprise party there ever was! And quite bluntly, the regents you installed need to spruce up the palace a bit. Not so much that it drains the [12b] treasury, of course.[paragraph break]So the fun can wait. There is still business." instead;
	abide by visit-text of noun;
	now quest-dir is noun;
	say "[if player is in grounds]Rushing through the [ministry] with a quick good-bye, y[else]Y[end if]ou head to [cq]. [unless noun is primary and noun is unsolved]Your allies for this quest are [summary-text of noun][else]You only have [the twelvebytwelvian king] and [the first-piece of noun] with you[end if].";
	new-quest;
	move player to c3;
	if quest-dir is stalemated and already-solved of quest-dir is not empty:
		say "Okay. You make a note of what you tried earlier, before you gained the enemy king's trust. It almost worked. It should work now.[paragraph break]Your king, [entry 1 of already-solved of quest-dir]. The [first-piece of quest-dir], [entry 2 of already-solved of quest-dir]. The [second-piece of quest-dir], [entry 3 of already-solved of quest-dir]. The king of [q of quest-dir], [entry 4 of already-solved of quest-dir].";
	the rule succeeds;

check going (this is the note boundaries rule):
	if the room noun of location of player is nowhere:
		say "You're at the [corner-or-edge], so you can only go away from, or along, [if number of edged directions is 1]this edge[else]those edges[end if]." instead;

to say corner-or-edge:
	if number of edged directions is 2:
		let Q be a random viable diagonal direction; [ there can be only one, if you are in the corner]
		say "[opposite of Q] corner";
	else:
		say "[list of edged directions] edge[if number of edged directions > 1]s[end if]";

definition: a direction (called d) is edged:
	unless d is cardinal, no;
	if the room d of the location of the player is nowhere, yes;
	no;

section map of the fourbyfourias

the map of the Fourbyfourias is scenery in Ministry of Unity. description is "[big-map]";

understand "map of 12b/12b12/12" and "12 map/12b map/12b12 map" and "12/12b/12b12" as map of the fourbyfourias.
understand "map of 4b/4b4/4" and "4 map/4b map/4b4 map" and "4/4b/4b4" as map of the fourbyfourias.

carry out examining map of the Fourbyfourias when map-view is false:
	if screen-reader is false:
		say "[if number of solved directions > 0]It's a 'before' map, not showing what you've annexed. [end if][12b] takes up most of the northwest--it's got more land mass than the seven tinier [4s] combined. It's striped purple and yellow, the colors of each half of [5b], and your allies['] colors.[paragraph break]Clockwise in varying shades of grey from the upper right are [north], [northeast], [east], [southeast], [south], [southwest] and [west]. To the northwest are sprawling lands too big and unprofitable to annex.[paragraph break]The map has some mnemonics you can study with [mne].";
		the rule succeeds;

after examining map of the fourbyfourias:
	if quests-left is 1:
		say "The only part of the map not x-ed out is [random to-solve direction]. Not much choice." instead;
	if number of solved directions > 0:
		say "Some titles are x-ed out, because you already unified them: [list of solved directions].";
	else:
		say "Nothing's x-ed out yet. You've unified nothing so far. That will change soon.";
	if number of stalemated directions > 0:
		say "[line break][list of stalemated directions] [if number of stalemated directions > 1]are[else]is[end if] half-crossed out, since you established trust there. But you still need to finish the job.";
	if number of solved directions < 4:
		say "[line break][if number of solved directions > 0]However, [end if]South and East and Southeast [4b] are only written in very lightly. It's not time, yet.";
	else if number of solved directions is 4:
		say "[line break]However, [southeast] is still greyed out. It only touches [12b] at a corner, so you need a path through [south] or [east] to get there.";
	if player-knows-toggle is false:
		say "[line break]You can use [tog] to toggle viewing a text description of the map and a text map. While most testers and players seem to prefer the text map, I still want to give you the options.";
		now player-knows-toggle is true;
	the rule succeeds;

instead of doing something with map of the fourbyfourias:
	if current action is examining, continue the action;
	say "You can really only [b]X[r] or [b]EXAMINE[r] the [map of the]." instead;

chapter observation grounds

definition: a piece (called p) is observable:
	if color of p is white, yes;
	no;

check going inside in Ministry of Unity:
	now all pieces are off-stage;
	move Twelvebytwelvian King to Observation Grounds;
	move a random observable bishop to Observation Grounds;
	move a random observable knight to Observation Grounds;
	now all pieces are not init-observed;

the Observation Grounds are inside of the Ministry of Unity. "The [unity] just back outside is for big-picture planning. Here, you can (X)amine people to determine how and when and why they will act. Though you can also head in a direction to start a quest."

the Observation Grounds are not puzzly.

check going in Observation Grounds:
	if noun is outside, continue the action;
	if noun is inside, say "Yes, you have even more secret quarters inside the Observation Grounds, but they aren't open in this game." instead;

for printing a locale paragraph about a piece (called p) when location of player is observation grounds:
	if p is not mentioned:
		now all pieces are mentioned;
		say "The [list of touchable pieces] are milling around here near the center of the room, because there's lots more space to move around in the center than at the sides. You can [xbold] any of them for a refresher on their roles and how they'll execute said roles.";

chapter the grid

a room has a number called xval. a room has a number called yval. a room has text called room-edge-text. the description of a room is usually "You are [room-edge-text of the item described] of the main hall of the royal [cq]n castle. You can go [if number of viable directions is 8]any which way[else][list of viable directions][end if]. [room-color]."

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

rule for printing the locale description when map-view is true and location of player is puzzly:
	show-the-board;
	if c3 is not visited:
		show-pieces;

chapter c3 explaining 4 vs 5

after printing the locale description for c3 when c3 is unvisited:
	say "[line break]It has not escaped your notice that the castle was, in fact, five by five and not four by four as you expected. You can review the likely reasons why with [45][if hard-mode is true], which may be slightly spoilery[end if].";
	say "[line break]Technical note(s): ";
	if player-knows-toggle is true:
		say "You already know about [tog], but just in case, it can change between text maps and text descriptions.";
	else:
		say "The [tog] command can change from the text map you see above to a text description, though most testers and players seem to prefer text map.";

volume pieces

team is a kind of value. the teams are black and white.

a piece has text called short-text. description is usually "You don't really want to make eye contact. You might give the game away.".

a piece has a table name called piece-tutorial.

a piece has a team called the color.

a piece can be init-observed. a piece is usually not init-observed.

a piece can be tutored. a piece is usually not tutored.

note-move-help is a truth state that varies.

a piece can be gen-help-examined. a piece is usually not gen-help-examined.

after examining a piece in Observation Grounds:
	if noun is not gen-help-examined, say "NOTE: next time you examine [the noun][if rival of noun is not noun] or their rival, [the rival of noun][end if], you'll get a tutorial about how they move[if screen-reader is false], with text graphics[end if].";
	now noun is gen-help-examined;
	now rival of noun is gen-help-examined;

section tutorials

to tutorial-process (tn - a table name):
	let need-wait be false;
	let riv be rival of noun;
	let broke-tutorial be false;
	now riv is placed;
	repeat through tn:
		if there is a the-text entry:
			if debug-state is false and need-wait is true:
				say "See more of the tutorial? Y means yes, and any other key means no.";
				let Q be the chosen letter;
				unless Q is 89 or Q is 121:
					now broke-tutorial is true;
					break;
			say "[the-text entry][paragraph break]";
			now need-wait is true;
		move riv to the-square entry;
		if screen-reader is false, show-one-tutorial;
	if broke-tutorial is false, say "That's all of the tutorial for [the noun].";
	move riv to offsite;
	now riv is irrelevant;

to show-one-tutorial:
	update-guarded;
	show-the-board;
	reset-guard;

to say in-corner:
	say "in the corner ([list of cornery rooms])"

to say in-center:
	say "in the corner ([list of central rooms])"

table of bishop tutorials
the-square	the-text
a1	"A bishop [in-corner] can guard only four squares."
e3	--
b2	"A bishop in the inner ring [list of inner-ring rooms] can guard six squares if it is not blocked."
c4	--
c3	"A bishop [in-center] can guard eight squares if not blocked."

table of knight tutorials
the-square	the-text
e1	"A knight [in-corner] can only guard two squares."
e4	"A knight next to the corner ([list of edgeside rooms]) can only guard three squares."
a3	"A knight in the center of the edge ([list of edgecentral rooms]) can guard four squares."
d2	"A knight at the corner of the inner ring ([list of inner-ring-corner rooms]) can guard four squares."
d3	"A knight on the side of the inner ring ([list of inner-ring-side rooms]) can guard six squares."
c3	"A knight [in-center] can guard eight squares if not blocked."

table of king tutorials
the-square	the-text
a5	"A king in the corner can only move to or guard three squares."
a3	"A king anywhere on the edge but not in the corner can move to or guard five squares."
b4	"A king in the center or inner ring ([list of not edgy rooms]) can move to or guard all eight squares."
c3	--

section relations

Rivalry relates one piece to another (called the rival).

The verb to rival (it rivals, they rival, it rivaled) implies the rivalry relation.

when play begins:
	now the yellow bishop rivals the purple bishop;
	now the yellow knight rivals the purple knight;
	now the twelvebytwelvian king rivals the twelvebytwelvian king;

chapter whether attacks

to decide whether (p1 - a piece) attacks (p2 - a person):
	if location of p1 is not puzzly or location of p2 is not puzzly, no;
	if p1 attacks location of p2, yes;
	no;

to decide whether (p1 - a piece) attacks (rm - a room):
	if location of p1 is offsite, no;
	if location of p1 is rm, no;
	let x1 be xval of location of p1;
	let x2 be xval of rm;
	let y1 be yval of location of p1;
	let y2 be yval of rm;
	let dx be absval of (x1 - x2);
	let dy be absval of (y1 - y2);
	if p1 is a king:
		if dx > 1, no;
		if dy > 1, no;
		yes;
	if p1 is a bishop:
		if absval of (x1 - x2) is not absval of (y1 - y2), no;
		let temp-room be location of p1;
		let the way be the best route from temp-room to rm;
		while 1 is 1:
			now temp-room is the room the way of temp-room;
			if temp-room is rm, yes;
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

to say dont-attack-own: say ".[paragraph break]The [item described] sees you staring and quickly reassures you he would never attack his own king, and neither would his [4n] contempraries. But perhaps they could get in the way just enough"

chapter bishop

a bishop is a kind of piece. description of a bishop is usually "Like [the rival of item described], [the item described] moves diagonally across boards. They can move as far as they want until the board ends. They are also limited to squares of one color. They can't jump over anyone else[dont-attack-own]."

the yellow bishop is a bishop. color of yellow bishop is white. understand "b" and "yb" and "by" and "y b" and "b y" and "y" and "fb" and "bf" and "b f" and "f b" and "yellow b" and "y bishop" as yellow bishop. "The yellow bishop [bishop-shuffle].".

the purple bishop is a bishop. color of purple bishop is white. understand "b" and "pb" and "bp" and "p b" and "b p" and "p" and "fb" and "bf" and "b f" and "f b" and "purple b" and "p bishop" as purple bishop. "The purple bishop [bishop-shuffle].".

the grey bishop is a bishop. color of grey bishop is black. understand "b" and "g" and "gb" and "bg" and "g b" and "b g" and "eb" and "be" and "b e" and "e b" and "grey b" and "g bishop" as grey bishop. "The grey bishop [bishop-shuffle].".

to say minor-color: say "The yellow and purple [if noun is a bishop]bishops[else]knights[end if] that will help you on your quest -- well, their outfits aren't VERY yellow, or VERY purple, but enough to tell them apart, which will help this whole operation quicker. Despite the yellow vs. purple squabbles that plague [12b], they're both equally effective.[paragraph break]It'd take a long time to describe the yellow vs. purple beefs and why things are the way they are. But if you're wondering why I chose these colors, type [b]YVP[r] or [b]PVY[r]"

to say bishop-shuffle: say "shuffles around here, never quite moving in a straight line. Religion is weird"

piece-tutorial of a bishop is usually table of bishop tutorials.

chapter knight

a knight is a kind of piece. description of a knight is usually "Like [the rival of item described], [the item described] moves in an L, two shapes vertically and one square horizontally, or one square vertically and two squares horizontally. They can jump over anyone else to get there.[paragraph break]You were a knight once. It was such fun to be able to move in an L. But it got tiring, and you suppose you could still do it, you guess, if you had to, and you got in shape. But now you're focused on moving straight and getting to the point[dont-attack-own]."

the yellow knight is a knight. color of yellow knight is white. understand "n" and "yn" and "ny" and "n y" and "y n" and "y" and "fn" and "nf" and "f n" and "n f" and "y knight" and "yellow n" as yellow knight. "The yellow knight [waits-here].".

the purple knight is a knight. color of purple knight is white. understand "n" and "pn" and "np" and "p n" and "n p" and "p" and "fn" and "nf" and "n f" and "f n" and "p knight" and "purple n" as purple knight. "The purple knight [waits-here].".

the grey knight is a knight. color of grey knight is black. understand "n" and "g" and "gn" and "ng" and "g n" and "n g" and "en" and "ne" and "e n" and "n e" and "grey n" and "g night" as grey knight. "The traitorous grey knight waits here, expressionless.".

piece-tutorial of a knight is usually table of knight tutorials.

chapter king

a king is a kind of piece.

the Twelvebytwelvian King is a king. color of Twelvebytwelvian king is white. understand "k" and "k12" and "12k" and "12" and "fk" and "kf" as twelvebytwelvian king. "Your king waits here for you to set everything just so.". description of twelvebytwelvian king is "The king can move in any directions, though it just wouldn't do to have him zipping across the board. He'd be too exhausted to lead, but he could. Of course he could, even if he isn't as spry as when he was younger!".

the Fourbyfourian King is a king. color of Fourbyfourian king is black. understand "k" and "4k" and "k4" and "ke" and "ek" and "4" and "k e" and "e k" and "k 4" and "4 k" as fourbyfourian king. description is "Any sort of eye contact might cause the [fourbyfourian] to get suspicious. You can't have that.". "You shouldn't be able to see the Fourbyfourian king.".

piece-tutorial of a king is usually table of king tutorials.

chapter examining pieces in the field

examine-yet is a truth state that varies.

pvy-note is a truth state that varies.

carry out examining a piece when location of player is puzzly (this is the alternate stories on examining rule):
	if pvy-note is false:
		if color of noun is white and noun is not fourbyfourian king:
			say "[minor-color].";
			now pvy-note is true;
	if the noun is examined, the rule succeeds;
	now the noun is examined;
	if the noun is the Twelvebytwelvian king:
		say "You and the [twelvebytwelvian] have a good working relationship that is not blemished by anything like friendship. You have nothing to say to each other, besides the obligatory flattery. He would nod pointedly at you to get back to work if you stared too long.";
	else:
		say "The [noun] avoids eye contact. That's probably for the best. You don't want to tip off any [4n] suspicions, and you don't want to seem like you're playing favorites--indeed, you want bishops and knights of every color to kiss up to you equally, because equality is important.[paragraph break]Besides, when the time comes, you will nod, and your allies will act[if quest-dir is simple-dumb]--or not act, in the case of [the relevant traitor][end if].[paragraph break]";
	the rule succeeds;

carry out examining a piece when location of player is not puzzly (this is the check for tutorials rule):
	if noun is init-observed:
		tutorial-process piece-tutorial of noun;
		the rule succeeds;
	now noun is init-observed;

after examining a piece when location of player is puzzly (this is the general quest piece description rule):
	say "You think more generally of your relations with [the list of cooperative pieces] that led you to [q of quest-dir].[paragraph break][piece-bio of quest-dir][line break]";
	if examine-yet is false:
		now examine-yet is true;
		say "[line break][i][bracket]NOTE: examining any ally will give you the same story for your current quest, except in the case of the southeastern [4s], where you get the same story for each.[close bracket][line break][r]"

to decide which piece is the relevant traitor:
	if grey knight is not irrelevant, decide on grey knight;
	decide on Fourbyfourian king;

to say waits-here: say "waits here, seemingly relaxed, but ready to spring to action"

volume directions

quest-dir is a direction that varies. quest-dir is inside.

last-solved is a direction that varies. last-solved is inside.

chapter properties for quests

a direction can be unquestable, primary, or secondary. a direction is usually unquestable. [okay, number crunchers will note it's usually primary, but we want to set questable directions explicitly.]

a direction can be tried or untried. a direction is usually untried.

a direction can be unsolved, solved or stalemated. a direction is usually unsolved.

a direction can be stalemate-bypassed. a direction is usually not stalemate-bypassed.

a direction can be normal-stalemated, hard-stalemated or stalemate-neutral. a direction is usually stalemate-neutral.

a direction can be normal-checkmated, hard-checkmated or checkmate-neutral. a direction is usually checkmate-neutral.

a direction has a piece called first-piece.

a direction has a piece called second-piece.

a direction has a rule called visit-text. visit-text of a direction is usually the trivially ignorable rule.

a direction has a rule called can-visit. can-visit of a direction is usually the trivially ignorable rule.

a direction has a rule called king-place. king-place of a direction is usually the trivially ignorable rule.

a direction has a rule called right-checkmate. right-checkmate of a direction is usually the trivially ignorable rule.

a direction has a rule called misc-checks. misc-checks of a direction is usually the trivially ignorable rule.

a direction has a rule called hard-stalemate-check. hard-stalemate-check of a direction is usually the trivially ignorable rule.

a direction has a rule called hard-checkmate-check. hard-checkmate-check of a direction is usually the trivially ignorable rule.

a direction has a list of rooms called already-solved.

a direction has a list of rooms called stalemate-recap.

a direction has a list of rooms called checkmate-recap.

a direction has text called quest-details.

a direction has text called hint-text.

a direction has text called quick-text.

a direction has text called summary-text.

a direction has text called recap-text.

a direction has text called piece-bio.

a direction has text called map-abbrev.

map-abbrev of north is " n ". map-abbrev of northeast is " ne". map-abbrev of east is " e ".

map-abbrev of west is " w ". map-abbrev of southwest is " sw". map-abbrev of south is " s ".

map-abbrev of southeast is " se".

to decide which direction is similar-early of (d - a direction):
	if d is north, decide on northeast;
	if d is northeast, decide on north;
	if d is west, decide on southwest;
	if d is southwest, decide on west;
	decide on d;

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
	if the item described is stalemated:
		say "You probably need [the second-piece of the item described] to block the enemy king's fleeing path";
		if the item described is northeast, say ". But this one's a bit different from the other three--one more thing to look for";
	else:
		say "You probably need [the twelvebytwelvian] and [the first-piece of the item described] to push [the fourbyfourian] where he can't move at all, even if he's not attacked"

first-piece of north is yellow bishop. second-piece of north is grey bishop. north is primary. hard-stalemate-check of north is the hard-bishop-stalemate rule. hint-text of north is "[first-hints].". quick-text of north is "[if north is stalemated]B vs. B[else]B[end if]". summary-text of north is "two bishops, one traitorous". recap-text of north is "In [q of north], you used the enemy bishop and your own king to wall in the enemy king.".

first-piece of northeast is yellow bishop. second-piece of northeast is grey knight. northeast is primary. hard-stalemate-check of northeast is the hard-bishop-stalemate rule. hint-text of northeast is "[first-hints].". quick-text of northeast is "[if northeast is stalemated]B vs. N[else]B[end if]". misc-checks of northeast is knight blocks bishop rule. summary-text of northeast is "a bishop and a traitorous knight". recap-text of northeast is "In [q of northeast], you had to put everyone in a Tetris L-shaped block, enemy king in the corner, to conquer him. If your bishop had been further away, the traitor knight would've had to save the king."

first-piece of west is yellow knight. second-piece of west is grey knight. west is primary. hint-text of west is "[first-hints].". quick-text of west is "[if west is stalemated]N vs. N[else]N[end if]". summary-text of west is "two knights, one traitorous". recap-text of west is "In [q of west], you linked everyone in a sort of fish-hook to trap the enemy king, with the [twelvebytwelvian] farthest away. You couldn't keep the king two squares from the enemy king, as the enemy knight would be attacking."

first-piece of southwest is yellow knight. second-piece of southwest is grey bishop. southwest is primary. hint-text of southwest is "[first-hints].". quick-text of southwest is "[if southwest is stalemated]N vs. B[else]N[end if]". misc-checks of southwest is bishop takes knight rule. summary-text of southwest is "a knight and a traitorous bishop". recap-text of southwest is "In [q of southwest], your king and knight faced the enemy king and bishop, each two squares away."

section individual quest properties -- advanced directions next

first-piece of south is yellow knight. second-piece of south is purple knight. king-place of south is two-knights-silly rule. visit-text of south is traitors-all-used rule. can-visit of south is traitors-all-used-bare rule. south is secondary. quest-details of south is "The bishop and knight checkmate is a tricky one. It took me a while to figure. I walked away saying, 'Hey, look, here's proof that the two bishops are better than a bishop and knight if pawns aren't in the way.' But one night I was able to put it together: you have to push the enemy king to the corner your bishop can't cover, then push the king to the other corner. Having the bishop two squares from your knight puts a lock on critical escape squares, and the checkmate taught me a lot about square control.". hint-text of south is "[piece-cooperation]". quick-text of south is "2 N's". summary-text of south is "two knights". recap-text of south is "In [q of south], knights were three squares away from each other, and you were off to the side of them, enough to trap the enemy king."

first-piece of east is yellow bishop. second-piece of east is purple bishop. king-place of east is no-corner-no-close rule. visit-text of east is traitors-all-used rule. can-visit of east is traitors-all-used-bare rule. east is secondary. quest-details of east is "Checkmate with two bishops and nothing else isn't too bad to figure out. You push the enemy king to the side of the board, where he has only two moves. Then you lose a move with one of the bishop as you roll him into the corner. However, I was shocked to learn one Chicago area master I respected greatly (I had a Learning Experience against him) was unable to convert the advantage in a tournament with long time controls.". hint-text of east is "[piece-cooperation]". quick-text of east is "2 B's". summary-text of east is "two bishops". right-checkmate of east is two-bishops-formation rule. recap-text of east is "In [q of east], you placed one bishop next to the king and the other on a diagonal. The king guarded the bishop close by."

first-piece of southeast is yellow bishop. second-piece of southeast is yellow knight. king-place of southeast is no-corner-no-close rule. visit-text of southeast is corner-cleared rule. can-visit of southeast is corner-cleared-bare rule. southeast is secondary. quest-details of southeast is "Checkmate with two knights against a king is impossible unless the opponent cooperates. However, two knights against a pawn may be very possible indeed, depending on where the pawn is. You can Google Troitsky Line for more on that. I remember reading an article about the endgame at math camp in high school. We were all pretty smart, but we didn't get far with it. Years later I read a blog post describing the strategies in an actual tournament game and remembered math camp. I felt pretty smart understanding the concept. Then I found out the person with the two knights ... wasn't in high school yet. I felt less smart.". hint-text of southeast is "[piece-cooperation]". quick-text of southeast is "B & N". summary-text of southeast is "a bishop and a knight". recap-text of southeast is "In [q of southeast], you positioned everyone in an L with the knight giving check, and you also positioned the king between his bishop and knight, to block out the enemy king on the edge."

to say hint-minor-vs of (d - a direction):
	say "You'll need to restrict the squares the enemy king can run to. Also, your [if yellow bishop is irrelevant]knight can check but not cover escape squares[else]bishop can check and cover an escape square, but your king can't cover the rest[end if]. How can you cover that final square?"

to say piece-cooperation:
	say "You want your king to cover two escape squares, with one minor piece checking and covering an escape square, and another covering two escape squares. There may be multiple solutions. If one fails you, it is probably used somewhere else. I just didn't want to let the player get through with too-similar solutions."

section individual quest properties -- piece biographies

definition: a direction (called d) is simple-dumb:
	if d is secondary, no;
	if hard-mode is false, yes;
	if d is unsolved, yes;
	no;

to say lone-stale: say "You managed to persuade [the first-piece of quest-dir] that [q of quest-dir] was the TRUE plum assignment, here. Of course, this and [similar-early of quest-dir] are about the same, but he doesn't need to know that. "

piece-bio of north is "[if north is simple-dumb][lone-stale]His list of reasons to tax everyone except the church was a truly brilliant piece of public relations and a windfall for the treasury. It also allowed enough leeway to tax (eventually) the church. You know a few knights very willing to advocate for that.[else]You're impressed with how [the first-piece of quest-dir] reached out to the grey bishop at the every-decade international ecumenical conference to lay the groundwork for the imminent betrayal, as well as the reasons they gave to justify said betrayal. But of course you can't show it.[end if]".

piece-bio of northeast is "[if northeast is simple-dumb][lone-stale]His insights into keeping the populace divided between 'the monarchy deserves all the power' and 'the clergy deserves all the power' are thoughtful indeed. You just don't quite agree on the respective ratios of who believes what. Perhaps a sabotaged crusade, seemingly ordered by the clergy, will tip the balance the right way.[else]You can't deny [the first-piece of quest-dir] did well to tap into [the second-piece of quest-dir]'s natural resentment of their own monarchs. Perhaps [the first-piece of quest-dir] did a bit too well.[end if]".

piece-bio of east is "The two bishops simply do not like each other, but they know better than to show it. You had such a fight arguing over things: who would get the final blow in on the [ck]? Who would take the light squares, of which there are 13 in an X-by-Xian castle, with only 12 dark squares? Who was better at getting pawns out of their way so they could move about and get stuff done? And you didn't want to get them started on arcane ecumenical matters. Fortunately, they know to shelve their hostility until the job is done, and you were able to placate them enough so they would get the job done. You think. There's always the worry of some bizarre religious edict that dovetails with the current popular superstitions that could rob you of power.".

piece-bio of southeast is "The trip up to [ck] was brutal. You'd heard all the rehashes of why bishops were better than knights, and vice versa, and by the end, THEY suggested THEY were getting tired of YOU saying 'Why yes, you both have thoughtful points.' The nerve! The bishop always starts by saying the knight takes too long to get places, then the knight laughs at the bishop for only being able to go certain places, then there's the whole kerfuffle of 'You let pawns get in the way' and 'You don't really appreciate pawns. You just leap over them and one day when you're older and less agile you'll trip over one.' Then the bishop insisting they deserve more prestige because a bigger Twelvebytwelvia or whatever means more squares they can go to immediately, but the knight claims that's more squares a bishop can never touch. That sort of thing. Or the arguments over why only knights get to search for holy grails. Is it that bishops are too corrupt, or knights are too dumb to be properly overwhelmed by the meaning of such an artifact?[paragraph break]Well, you managed to convince them that if one of them bungles their role, you will have a pretty good idea how all these questions should be answered. That shut them up, sort of."

piece-bio of south is "The two knights really can't stand each other, but fortunately, taunting from bishops that they couldn't do the job alone, or they could only do it by accident, inspired teamwork. You managed to convince the knights they don't need to guard each other--in fact, that's inefficient--and they wouldn't have to wait for a traitorous pawn after seventy maneuvers. The knights believe they are good at diplomacy, and truth be told, they work together well: the dumb strong one and the smart weak one. All the promises of yes, we will go off to war and no, we won't go off to war--so difficult to keep straight. But thankfully knights are easy to distract.".

piece-bio of southwest is "[if southwest is simple-dumb][lone-stale]He's quite the leader, and his charisma expands well beyond other knights. You are impressed at his ability to mock knights more able than himself without showing his own weaknesses.[else]. You weren't surprised when [the first-piece of quest-dir] and [the second-piece of quest-dir] hit it off at a formal banquet in Great Centroidia. When [the second-piece of quest-dir] complained about [cq], you arranged a return banquet to make sure [the first-piece of quest-dir] did not do the same about [12b]. A few sneaky meeting later, and he was on your side.".

piece-bio of west is "[if west is simple-dumb][lone-stale]His physical abilities cannot be denied, but his leadership? Well, you can't have it all. Still, you sort of had to take him along, especially after he grumbled that his squire was a worthless spoiled brat who only got the position due to noble birth.[else]You're fortunate that skills and jousting tournament just occurred and that it was rigged. Having placed in a tie for second, below a clearly inferior knight from distant lands, [the first-piece of quest-dir] and [the second-piece of quest-dir] bonded over the unfairness of the judges. A quick word with [the second-piece of quest-dir], and suddenly they wanted so much more than [cq] could give.[end if]".

section quest solve rules

to decide whether might-self-check:
	unless quest-dir is primary, no;
	unless quest-dir is stalemated, no;
	let sp be second-piece of quest-dir;
	let fp be second-piece of quest-dir;
	unless sp is placed or sp is noun, no;
	unless fp is placed or fp is noun, no;
	yes;

to decide whether half-final:
	if boolval of bn-close + boolval of bn-far is 1, yes;
	no;

bn-close is a truth state that varies. [NKBK all crowded together]

bn-far is a truth state that varies. [BKN on top row, K on bottom]

dupe-noted-yet is a truth state that varies. [ if you found, say, the same BB and NN mates ]

to poss-dupe-note:
	if dupe-noted-yet is false:
		now dupe-noted-yet is true;
		say "(NOTE: your solution was fully valid, but this being hard mode, I'm being a bit of a stickler about finding different ways for the south and east [4s]. Hope it's not too much inconvenience, or maybe that you find the additional challenge interesting.)";
	retreat-to-unity;
	the rule succeeds;

definition: a piece (called p) is double-adjacent:
	if basic-dist of p and Fourbyfourian king is 1 and basic-dist of p and Twelvebytwelvian king is 1:
		yes;
	no;

this is the two-bishops-formation rule:
	if diag-dist of yellow bishop and purple bishop is 3 and basic-dist of yellow bishop and purple bishop is 3:
		if hard-mode is false:
			now quest-dir is normal-checkmated;
			continue the action;
		say "[if south is solved]The [fourbyfourian] notices something is up. You remember that you had everyone in roughly the same place over in [q of south] with the two knights.  Perhaps you need to find a new way to corner the [ck]. Too many similar moves may lead to proof of your activities[else]Something's up. The bishops cough at you, a bit confused. You shake your head, but they both shake their heads back. They wouldn't do this to you unless something was up.  So after the diplomatic meeting, you ask. They mention perhaps ... perhaps this specific maneuver may be more useful somewhere else.[paragraph break]They almost look satisfied with that bit of thoughtful dialogue. So much of their work is just intimidating people into what to believe that a bit of logical futzing is refreshing. They seem to be thinking back wistfully to the good old days of dreaming about gaining vast power--so different from having to wield it constantly[end if].";
		poss-dupe-note instead;
	let temp be boolval of (whether or not yellow bishop is double-adjacent) + boolval of (whether or not purple bishop is double-adjacent);
	if temp > 0:
		if hard-mode is false:
			now quest-dir is normal-checkmated;
			continue the action;
		say "The [fourbyfourian] feels a bit squished in by [if temp is 2]your two bishops[else]one of your bishops being THAT close--and, well, your king, for that matter, no offense. He makes an excuse to wriggle out just before you can close the net.";
		poss-dupe-note instead;

this is the bishop takes knight rule:
	say "Checking if [second-piece of quest-dir] at [location of second-piece of quest-dir] attacks [first-piece of quest-dir] at [location of first-piece of quest-dir].";
	if second-piece of quest-dir attacks first-piece of quest-dir:
		say "Things seem perfect! Until ... until ... [the second-piece of quest-dir] nudges [the first-piece of quest-dir]. It's ... well, it had to be done. It would have been too obvious to let that slip. People might have asked questions. But [the first-piece of quest-dir] takes quite a few lumps before glaring at you. You smack [the second-piece of quest-dir] around a bit before apologizing for what must be a big giant misunderstanding. (They have to sit there and not blow their cover, after all!) You apologize profusely and hope there can be a less untoward diplomatic meeting in the future ... all the while suggesting it is the enemy king's fault.[paragraph break]On the ride home, [the first-piece of quest-dir] grumbles a bit. You mention it's all part of a greater plan. No details. That-all is top-secret!";
		note-amusing-stuff "nvb-miss";
		retreat-to-unity;
		the rule succeeds;

this is the knight blocks bishop rule:
	if Fourbyfourian king is not placed, continue the action;
	let Q be diag-dist of first-piece of quest-dir and Fourbyfourian King;
	if Q < 2, continue the action;
	note-amusing-stuff "bvn-miss";
	say "The enemy knight, who wants to cooperate with your cunning plan, unfortunately has no choice. The king being in danger, and the knight in obvious position to prevent it, jumps to action![paragraph break]";
	if Q is 2:
		say "A big fight ensues! A fake one, to impress the [fourbyfourian] and not really raise suspicions. But the grey knight, being traitorous, gets a cheap shot in or two. The [first-piece of quest-dir] isn't happy, but they know better to complain. You'll get [']em next time. You must've been close.";
	else:
		say "The knight throws itself in front of the bishop. You have no choice but to call out [the first-piece of quest-dir] for a shocking appearance of aggression and assure the [fourbyfourian] you had nothing to do with it, and if you can help yourself, it won't happen again. The [first-piece of quest-dir] looks ... less than happy. But you mention some failures are, like, divine will and stuff, which the bishop can't argue with. After all, he's used that argument on some unlucky doomed unfortunates, himself. So he's still on the team.";
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
		say "Tackling [q of noun] seems tactically unwise at the moment. You'll want to do as much as you can diplomatically. You still have [if number of solved directions is 3]a traitor[else]traitors[end if] willing to aid you elsewhere. Once the traitors have helped you, [i]then[r] you can conquer the south and east with a bit more force. So you'll want to take care of things to the [list of primary not solved directions] first.";
		if fourth-wall-warn is false:
			now fourth-wall-warn is true;
			say "[line break]And, yes, this is totally not me saying that I believe certain [4s] are easier to conquer than others, or at least, they have more similar themes, so you'll get off to a quicker start.";
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
	if location of player is grounds:
		say "Nowhere to go but out...";
		now noun is ministry of unity;
	else if location of player is ministry of unity:
		if number of not solved directions is 1:
			now quest-dir is a random not solved direction;
			now noun is c3;
		else:
			say "You'll have to be more specific, as you have more than one [4b] left to conquer. If you want to visit [the grounds], type IN.";
			reject the player's command;
	else:
		say "There are twenty-four other squares here in [cq], so you'll need to be more specific.";
		reject the player's command;

carry out gotoing:
	abide by the already-here rule;
	if location of noun is not puzzly and location of player is puzzly:
		say "Just go OUT to leave [cq]." instead;
	if location of player is not puzzly and location of noun is puzzly:
		say "You need to travel to a Fourbyfouria to go to a specific square on its map." instead;
	if location of player is puzzly:
		let bd be diag-dist of location of player and noun;
		say "You take a [if bd is 1]brief[else if bd is 2]moderate[else if bd is 3]nice long[else]serious[end if] walk...";
	move player to noun;
	the rule succeeds;

chapter calling

does the player mean calling the Fourbyfourian King when number of reserved pieces > 1:
	it is unlikely.

does the player mean calling first-piece of quest-dir when first-piece of quest-dir is reserved:
	it is likely.

does the player mean calling second-piece of quest-dir when first-piece of quest-dir is placed and second-piece of quest-dir is reserved:
	it is likely.

does the player mean calling a placed piece:
	it is unlikely.

does the player mean calling an irrelevant piece:
	it is very unlikely.

this is the same-colored-bishops rule:
	unless number of placed bishops is 1, continue the action;
	let Q be a random placed bishop;
	unless location of Q and location of player are samecolored, continue the action;
	if grey bishop is irrelevant:
		note-amusing-stuff "bb-colors-second";
		if quest-dir is stalemated or hard-mode is false:
			say "But wait! You realize that you are about to place both your bishops on the same-colored square. You may break a lot of stuffy old rules in [12b], but that's not one of them, especially since breaking that rule gives no practical benefit. Okay, it actually harms you.[paragraph break]Somewhere else, maybe.";
			the rule succeeds;
		else:
			say "One of your bishops looks confused. The other looks very impressed. Each doesn't like the other being on their turf, but your unconventional approach of putting them on the same color square just might work ... this time. Or it might fail spectacularly.";
	else:
		note-amusing-stuff "bb-colors-first";
		say "Your bishop and the enemy bishop look over at each other. They then both glare at you and shrug, as if to say well, you're the boss here. You'll take flak if and when things don't work out.";
	continue the action;

to decide which number is check-total:
	let temp be 0;
	repeat with Q running through placed pieces:
		if color of Q is black, next;
		if Q is Twelvebytwelvian king, next;
		if Q attacks the Fourbyfourian king, increment temp;
	decide on temp;

this is the excessive beatdown rule:
	if check-total is 2:
		note-amusing-stuff "beatdown";
		say "The pieces under your command look over at you questioningly. While they recognize what fun it is to both be attacking the [fourbyfourian] at once, they also consider such fun is not strategically sound. Still, you're the boss...";

rule for supplying a missing noun when calling:
	if location of player is not puzzly:
		now noun is Twelvebytwelvian king;
		the rule succeeds; [doesn't matter. Same reaction for them all!]
	if Fourbyfourian king is reserved and number of reserved pieces is 1:
		say "(the [fourbyfourian] is last)[line break]";
		now noun is Fourbyfourian king;
		the rule succeeds;
	if Fourbyfourian king is reserved and number of reserved pieces is 2: [ maybe redundant but let's make sure ]
		now noun is a random reserved piece that is not the Fourbyfourian king;
		say "([the noun] before the [fourbyfourian])[line break]";
		the rule succeeds;
	if Fourbyfourian king is placed and number of reserved pieces is 2: [ e.g. placed king, have BB or NN left so it doesn't matter ]
		if quest-dir is east or quest-dir is south:
			now noun is first-piece of quest-dir;
			say "([the noun], since it is functionally equivalent to [the second-piece of quest-dir])[line break]";
			the rule succeeds;
	say "I'll need something more specific, since I can't decide which piece to place of the remaining ones. You have [the list of reserved pieces] still to call.";
	reject the player's command;

to decide whether you-stalemated:
	if quest-dir is primary and quest-dir is stalemated, no;
	if Fourbyfourian king is checked, no;
	if Fourbyfourian king is immobile, yes;
	no;

to decide whether king-cornered-not-stalemated:
	unless second-piece of quest-dir is placed and color of second-piece of quest-dir is black, no;
	if Fourbyfourian king is checked, no;
	if Fourbyfourian king is immobile, yes;
	no;

to decide whether you-checkmated:
	unless Fourbyfourian king is checked, no;
	unless Fourbyfourian king is immobile, no;
	yes;

to say normal-ok:
	say "[line break][i][bracket]NOTE: you found a solution that would've worked in normal mode, but hard mode forces you to be a bit more creative in some areas, often to avoid multiple similar solutions. There should be clues as to an alternate solution.[close bracket][r][line break]";

this is the hard-bishop-stalemate rule:
	if location of player is cornery:
		if hard-mode is true:
			say "It should have worked. It [if west is stalemated or south is stalemated]already did off in [q of west] and [q of southwest], but maybe you need a new approach here[else]might work somewhere else, because things feel basically right[end if].";
			say "[line break]For whatever reason, the [ck] doesn't feel comfortable backed in that way, at least not without an ally next to them. He chickens out with a maddeningly plausible excuse.[paragraph break]There's got to be a way to trap him away from the corner--then, surely, [cq] will be better off ruled by someone much braver, a non-corner-fearing (but still center-seizing) leader like ... your very own king! Or, perhaps, a regent such as yourself.";
			if basic-dist of first-piece of quest-dir and player is 1 and basic-dist of first-piece of quest-dir and twelvebytwelvian king is 1:
				say "[line break]The formation had to be right, though. It just HAD to. But the positioning -- not so much. Yet.";
			say "[normal-ok]";
			retreat-to-unity;
			the rule succeeds;
		now quest-dir is normal-stalemated;

this is the hard-advanced-stalemate rule:
	if hard-mode is true:
		if location of player is cornery:
			now quest-dir is normal-stalemated;

this is the stalemate dialogue rule:
	if debug-state is true, say "DEBUG: Stalemate achieved.";
	if quest-dir is primary:
		if quest-dir is stalemated:
			say "You shouldn't be able to re-stalemate [the fourbyfourian king]. This is a BUG.";
		else:
			abide by hard-stalemate-check of quest-dir;
			let q2 be similar-early of quest-dir;
			let other-guy be rival of first-piece of quest-dir;
			say "You and [the first-piece of quest-dir] corner the [ck] and manage to convince him that you're really all just about the diplomacy these days, and they'd better trust you now and in the future. It ... seems to work![paragraph break]Once back at the Ministry of Unity, you realize your plans for [q of similar-early of quest-dir] are more or less identical. But so as not to show any yellow/purple favoritism, you go through the paces with [the rival of the first-piece of quest-dir].[paragraph break]Your trips to [q of q2] and [q of quest-dir] will include [the other-guy] who is not as loyal to their King as they should be. They won't attack their own king. They'll only obstruct him. And their help should be just enough.";
			now quest-dir is stalemated;
			now last-solved is quest-dir;
			if quest-dir is not normal-stalemated, now quest-dir is hard-stalemated;
			if q2 is stalemated:
				say "[line break]NOTE: you should not have been able to stalemate here, since you already did so in [q of q2]. This is a BUG.";
			now q2 is stalemated;
			now q2 is stalemate-bypassed;
			now stalemate-recap of quest-dir is current-quest-snapshot;
	else if quest-dir is stalemated:
		say "Again, you pretty much cornered the [fourbyfourian] without attacking him. Awkward laughter resonates in this diplomatic meeting. It only sort of builds up his trust. You know how it is, when someone oversells something? You might be risking that here. The [fourbyfourian] (fool) already trusts you enough. Next time, you can go fully on offense.";
	else:
		now quest-dir is stalemated;
		say "Oh my! The [fourbyfourian] is trapped, but not too trapped. After a lot of verbal manipulation, you manage to convince him that this show of almost-force is just standard negotiating technique, and if he can't trust you, who can he trust?[paragraph break]The diplomatic maneuver is thus a success. After a few hours, you take leave, confident your little feint will keep the [fourbyfourian] off-guard enough, you will get him next time.";
		now stalemate-recap of quest-dir is current-quest-snapshot;
	retreat-to-unity;
	the rule succeeds;

this is the checkmate dialogue rule:
	if quest-dir is secondary and quest-dir is not stalemated:
		say "But wait! The [fourbyfourian] feels a LITTLE too under attack. He excuses himself for ... well, a family emergency, an important jousting tournament to judge, another one of those banquets, you know.[paragraph break]";
		if number of solved secondary directions > 0:
			say "Ye Olde Bummeur. You mixed things up. You should have slow-walked it a bit more, as in [q of random solved secondary direction].";
		else if number of stalemated secondary directions > 0:
			say "Man! You felt like you had something there. But you didn't gain the king's trust as in [q of random stalemated secondary direction]. You'll need to do that.";
		else:
			say "Drat! You were a bit too aggressive. Perhaps if there were a way to make [the fourbyfourian] feel almost-trapped but let him off the hook ... then he could be suckered. But not now.";
		if already-solved of quest-dir is empty:
			say "Perhaps this will work later. You note the position in your head. Some scribe will write it down. Perhaps once you've gained [the fourbyfourian]'s trust you won't attack him. Then, you can even say 'Ha, if I were going to fool you, I wouldn't use this exact same formation you'd been suspicious of, earlier.' People fall for that, even when they should know better.";
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
	if noun is Fourbyfourian King:
		if quest-dir is primary and quest-dir is unsolved, decide on 3;
	decide on 4;

definition: a piece (called p) is check-warning:
	if p is first-piece of quest-dir, no;
	if p is placed, yes;
	no;

to open-new-areas:
	if number of solved directions is 4:
		say "A panel of distinguished barons and earls is waiting for you back at the Ministry. There is backslapping and tallyhoing for a while before everyone immediately yells at each other that it's time to get serious. And you do.[paragraph break]Unfortunately, the governments of both East and [q of south] were packed with loyalists. So you will have to bring an extra ally along. Once you do, you will have a passage to [q of southeast].";
		if hard-mode is false:
			say "[line break]However, you've already gone through the steps of stalemating a king to gain his trust, so we'll skip your initial trips to [q of south] and [q of east] and, when it opens up, [q of southeast].";
			now all secondary directions are stalemate-bypassed;
			now all secondary directions are stalemated;
	else if number of solved directions is 5:
		say "You return to great applause at the Ministry. You now have passage to [q of southeast] via [q of last-solved], though you don't have to go there right away. Everyone is sure you will tackle things in the best order.";
		if hard-mode is false:
			say "[line break]That said, you go through the diplomatic hoops of stalemating the [k of southeast] one more time to gain his tenuous trust.";
	else:
		if debug-state is true:
			say "DEBUG: no special text for [number of solved regions] solved regions.";

definition: a room (called r) is near-unguarded:
	if r is guarded, no;
	if r is adjacent to location of fourbyfourian king, yes;
	no;

definition: a room (called r) is capturable:
	unless r is near-unguarded, no;
	if number of observable pieces in r > 0, yes;
	no;

this is the no-illegal-positions rule:
	if number of reserved pieces > 1:
		say "You'll want to place the [fourbyfourian] last." instead;
	if diag-dist of Twelvebytwelvian king and player <= 1, say "You can't really place the enemy kings that close to each other. Oh, sure, they'll perform all the proper diplomacy ... but they really don't WANT to. At least, your king doesn't want to. He doesn't want his fingerprints on any ... disappearances." instead;

to decide whether enemy-self-check:
	if color of second-piece of quest-dir is white, no;
	let sp be second-piece of quest-dir;
	let xdelt be absval of ((xval of location of fourbyfourian king) - (xval of location of sp));
	let ydelt be absval of ((yval of location of fourbyfourian king) - (yval of location of sp));
	if sp is grey knight:
		if (xdelt is 1 and ydelt is 2) or (xdelt is 2 and ydelt is 1), yes;
		no;
	if sp is grey bishop:
		let fd be from-dir of location of sp and location of fourbyfourian king;
		let check-room be the room fd of location of sp;
		while check-room is not nothing:
			if number of pieces in check-room is 1:
				if fourbyfourian king is in check-room, decide yes;
				no;
			now check-room is the room fd of check-room;
		no;
	no; [this should never be reached]

minor-slapfight is a truth state that varies.

this is the minor piece slapfight rule:
	let sp be second-piece of quest-dir;
	let fp be first-piece of quest-dir;
	unless fp is placed and sp is placed, continue the action;
	unless fp attacks sp or sp attacks fp, continue the action;
	if fp attacks sp and sp attacks fp:
		if minor-slapfight is false:
			say "You've managed to engineer a Mexican Standoff. The [fp] and [the sp] glare at each other, both ready to jump, but not quite. It's amusing, what you can get them to do. Perhaps it won't make an ultimate solution, but it should let the [ck]'s guard down a bit.";
		else if debug-state is true:
			say "DEBUG note: standoff between two minor pieces but slapfight flag is true.";
	else unless sp attacks fp:
		if minor-slapfight is false:
			say "While [the fp] now potentially attacks [the sp], you make clear that it's part of the festivities or tradition or something. We're not hooligans in [12b], etc.! It's probably impressive or reassuring to gullible onlookers, including maybe the [ck], even if it doesn't get closer to the main goal.";
		else if debug-state is true:
			say "DEBUG note: traitor attacks ally but slapfight flag is true.";
	else unless fp attacks sp:
		if minor-slapfight is false:
			say "While [the sp] now potentially attacks [the fp], you make a crack about being a good host. Everyone smiles tightly. A perfect joke to reassert power and who's really in control.";
		else if debug-state is true:
			say "DEBUG note: ally attacks traitor but slapfight flag is true.";
	now minor-slapfight is true;
	note-amusing-stuff "standoff";

this is the unified self check check rule:
	if debug-state is true, say "DEBUG CALL [called-loc] [called-piece] KICK [kicked-loc] [kicked-piece].";
	unless might-self-check, continue the action;
	let called-loc be location of called-piece;
	let kicked-loc be location of kicked-piece;
	if debug-state is true, say "CALL [called-loc] [called-piece] KICK [kicked-loc] [kicked-piece].";
	if kicked-piece is not null-piece:
		move kicked-piece to called-loc;
	if called-piece is not null-piece:
		move called-piece to location of player;
	let block-stuff be false;
	let sp be second-piece of quest-dir;
	let your-king-checked be whether or not sp attacks twelvebytwelvian king;
	if kicked-piece is not null-piece, move kicked-piece to kicked-loc;
	if called-piece is not null-piece, move called-piece to called-loc;
	if your-king-checked is true:
		now block-stuff is true;
		if called-piece is null-piece:
			say "Whoah! Wait! That'd open up a sneaky attack on [the twelvebytwelvian] from [the sp]. You realize it would be proper diplomatic procedure to remove one of them, first.";
		else if kicked-piece is null-piece:
			if called-piece is placed:
				say "The [called-piece] looks confused. You wonder why for a moment. Ah, that's it, ";
				if called-piece is sp:
					say "he would be attacking [the twelvebytwelvian king] at [location of twelvebytwelvian king]! ";
				else:
					say "[the sp] at [location of sp] would be attacking him! ";
				say "You nod and wave [the called-piece] off. Yes, best stay at [called-loc].";
			else:
				say "The [random placed piece] coughs. You realize that setup won't do. The [twelvebytwelvian] is stared down a bit too much by [the sp]. The enemy king might start to question why you or [the first-piece of quest-dir] won't rush to his defense.[paragraph break]So, somewhere else, maybe. As much as you'd sometimes love an excuse to see your monarch get bopped for no reason, the price is too high. A failed conquest and, of course, blame for said conquest.";
				note-amusing-stuff "self-check";
		else:
			say "Swapping [the called-piece] for [the kicked-piece] would put [the twelvebytwelvian] in check from [the sp]. So that won't quite do.";
	abide by the minor piece slapfight rule;
	if block-stuff is true, the rule succeeds;


carry out calling:
	if location of player is not puzzly, say "You don't need to call allies until you're away from the [the location of the player]." instead;
	if noun is irrelevant, say "You don't need to call [the noun]." instead;
	if noun is Fourbyfourian king and number of reserved pieces > 1, say "You will want to call [the noun] last." instead;
	reset-temps;
	now called-piece is noun;
	now called-loc is location of called-piece;
	if number of pieces in location of player is 1:
		let rpl be random piece in location of player;
		if rpl is the noun, say "It looks like you tried to call [the noun] to where he already was. If this is wrong, you may want to try being more specific." instead;
		if noun is fourbyfourian king:
			say "While you're nominally placing [the noun] last, it would replace [the random piece in the location of the player], who would become the last piece/person placed. So you need to put [the noun] on an empty square." instead;
		now kicked-piece is rpl;
		now kicked-loc is location of player;
		say "But [the rpl] is already here at [location of player][if location of noun is puzzly], and [the noun] is already at [location of the noun][end if]. [if location of noun is puzzly]Swap[else]Replace[end if] [the rpl] with [the noun]?";
		unless the player regex-prompt-consents:
			say "Okay, never mind." instead;
	else if noun is placed:
		say "You already called [the noun] to [location of the noun]. Have them move over here?";
		unless the player regex-prompt-consents:
			say "Okay, never mind." instead;
		if noun is twelvebytwelvian king:
			say "The [twelvebytwelvian] grumbles at being ordered around like this, but hey, you've got the power here, and you can use it. A little. Not too much.";
	abide by the unified self check check rule;
	if noun is a bishop:
		abide by the same-colored-bishops rule;
	if noun is Fourbyfourian king, abide by the no-illegal-positions rule;
	say "You place [the noun] at [location of player].";
	place-and-list noun;
	if kicked-piece is not null-piece, now kicked-piece is reserved;
	now entry (status-index of noun) of current-quest-snapshot is location of player;
	update-guarded;
	show-the-board;
	abide by the minor piece slapfight rule;
	if noun is Fourbyfourian king:
		consider the excessive beatdown rule;
		abide by the king-place of quest-dir;
		if you-stalemated, abide by the stalemate dialogue rule;
		unless Fourbyfourian king is checked:
			if quest-dir is stalemated:
				if king-cornered-not-stalemated:
					say "Once again, you stalemated the enemy king--well, sort of. But that doesn't work this time. He doesn't feel completely helpless, what with his [second-piece of quest-dir] to order around. You're pretty sure you need to put him under pressure to finish the job--he needs to be attacked, with no way out.";
				else:
					say "But the [ck] is neither in check nor immobilized. So nothing really happens this time.";
			else:
				say "You laid off the [ck] this time, but perhaps a bit too much. He had [if number of near-unguarded rooms is 1]only one place to go[else]several places to go, including [random near-unguarded room][end if].";
			if quest-dir is secondary:
				say "[line break]And unfortunately this [if quest-dir is stalemated]doesn't put the enemy king any more at ease[else]is not enough to put the enemy king at ease. You'll need to get them into a seemingly tougher situation, then let them slip out[end if].";
			if enemy-self-check:
				say "You also remember that though [second-piece of quest-dir] 'saw' his own king just now, his treachery doesn't extend to actual violence. So the [fourbyfourian] isn't really attacked.";
			say "[line break]So things didn't quite work out, but you're able to blow it off to all involved as the sort of diplomatic meeting that inches things forward. You even put some backhanded blame on the enemy monarch for wasting YOUR king's time and not providing the sort of hospitality you expect. It doesn't really hurt them, but it does cover up your far more serious intent. So there'll be another chance. Just got to plan a bit better, next time.";
			move player to Ministry of Unity;
			the rule succeeds;
		abide by misc-checks of quest-dir;
		if you-checkmated:
			abide by the checkmate dialogue rule;
			abide by right-checkmate of quest-dir;
			if debug-state is true, say "DEBUG: Checkmate achieved.";
			if quest-dir is primary:
				say "The [ck] feels pretty confident he won't get squeezed, even in the corner, with the loyal [second-piece of quest-dir] by his side. But how wrong he is! Sure, the [twelvebytwelvian] and [first-piece of quest-dir] are closing in, but ... but ... [the second-piece of quest-dir] doesn't move. He makes apologetic 'I ... but ... ' noises, confusing his leader just long enough.[paragraph break]Perhaps he realized things in his last moment, perhaps not. But either way, there is the matter of leaving a regent for the newly acquired lands: [the first-piece of quest-dir] would be just perfect. His successor may help later.";
			else:
				say "The [ck] doesn't look worried at first. After all, when you cornered him the last time, he escaped[if location of player is not cornery], and he isn't even pinned in the corner[end if]! So he has plenty of ways out, and one must work ... except he doesn't. The end is not the sort of thing I wish to focus on, and besides, the official version is abdication to spend more times exploring ... well, the rest of his new adopted land of [12b].";
			if location of player is cornery:
				now quest-dir is normal-checkmated;
			if quest-dir is not normal-checkmated:
				now quest-dir is hard-checkmated;
			now quest-dir is solved;
			now checkmate-recap of quest-dir is current-quest-snapshot;
			now last-solved is quest-dir;
			open-new-areas;
			if number of to-solve directions is 0:
				calculate-ending;
				end the story;
				the rule succeeds;
		else:
			let sq be a random near-unguarded room;
			if number of capturable rooms > 0, let sq be a random capturable room;
			say "Oh no! The [ck] sees [sq] is available, and he goes there[if sq is capturable], running over [the random piece in sq] in the process without even apologizing. Ouch![else].[end if]";
			if quest-dir is primary:
				if quest-dir is unsolved:
					say "[line break]Perhaps you were trying to do too much at once. If there was a way to trap the [ck] without attacking him ... that might make him feel helpless, yet trust you in the future.";
		retreat-to-unity;
		the rule succeeds;
	if screen-reader is false, continue the action;
	show-the-board;
	if map-notes-flag is false:
		now map-notes-flag is true;
		say "Now that you've placed a piece, you can toggle seeing maps in the room description with [b]TOGGLE[r] or [b]T[r].";
	the rule succeeds;

to calculate-ending:
	if hard-mode is true:
		say "You had just the right combination of force and tact to take over the [4s] without other countries getting too suspicious. Well, of course they were suspicious, but not enough to act until it was far too late. Everyone is happy, more or less, even if people in the new province aren't quite 'real' [4n]s.[paragraph break]But the important thing: you receive a statue with your likeness in Great Centroidia, the capital of [12b]! You loved your fast horse and all, but now that you proved yourself on your own, you shouldn't have to share the spotlight with it.[paragraph break]Alas, as you grow older, a new king demands the formation of a New Centroidia, which is more accessible to the far reaches of what was once [12b]. For strictly administrative purposes, of course. Your statue is left out, without quite enough people to lobby for you, though lesser minds and diplomatic talents are quite well-represented. Frustration!";
	else:
		say "But the similarities between all the [4n] Kings['] disappearance is too much. Someone puts all the pieces together, and slowly but surely, you're fingered as a Person of Interest. Perhaps with more territories to conquer, your King would have backed you up, but here, you are offered as a sacrifice. You do, however, get a nifty diagonal street named after you in New Centroidia, the more practical capital now that Great Centroidia isn't really fully in the center any more.";
		if number of nonoptimal directions is 0:
			say "You managed to find non-overlapping solutions, so if you want to see the good ending, you should replay on hard mode. Or you can poke at the source and just read it. Either is an intellectual activity, of a sort.";
			continue the action;
		let L be the list of nonoptimal directions;
		let lplur be whether or not the number of entries in L > 1;
		say "Your solution[if lplur is true]s[end if] to the [L] [if lplur is true]were[else]was[end if] good, but [if lplur is true]they[else]it[end if] won't quite work in hard mode.";
		if debug-state is true:
			repeat with D running through L:
				say "[D] [whether or not D is hard-stalemated] [whether or not D is hard-checkmated].";

definition: a direction (called d) is nonoptimal:
	if d is normal-stalemated, yes;
	if d is not primary and d is normal-checkmated, yes;
	no;

to retreat-to-unity:
	move player to Ministry of Unity;
	new-quest;

incident-row is a number that varies.

to new-quest:
	now minor-slapfight is false;
	if quest-dir is not tried:
		say "[line break]";
		if number of tried directions is 0:
			say "The initial reception at [cq] is a game of golf, the new sport that's swept nearby lands in the past twenty years. The [twelvebytwelvian] wins, of course, perfectly honestly. Perfectly honestly! As it should be. Your king has mandated his own citizens appreciate it, even if they are too poor to play it. But ... but ... a terrible insult occurred. Enough to remove any doubt [cq] must be conquered.[paragraph break]";
		else:
			say "Again, a golf game as welcome. Again, an unforgivable diplomatic insult that fully justifies your takeover plans for [cq]![paragraph break]";
		increment incident-row;
		choose row incident-row in the table of incidents;
		say "[incident-text entry][line break]";
		now quest-dir is tried;
	now quest-dir is tried;
	reset-guard;
	now all pieces are irrelevant;
	now first-piece of quest-dir is reserved;
	now current-quest-snapshot is { Ministry, Ministry, Ministry };
	unless quest-dir is primary and quest-dir is unsolved:
		now second-piece of quest-dir is reserved;
		add Ministry of Unity to current-quest-snapshot;
	now Twelvebytwelvian King is reserved;
	now Fourbyfourian King is reserved;
	reset-board;

table of incidents
incident-text	rough-order
"The [ck] offered frou-frou vegetables and fruits instead of the proper mid-match refreshments. An unfair advantage, considering [the twelvebytwelvian] was tired from his long journey!"	1
"The [ck] confessed to being 'too busy' (heh) to play golf or take lessons, thus greatly lessening the joy of [the twelvebytwelvian]'s emphatic victory."	1
"The [ck] failed to give the [twelvebytwelvian] a mulligan at a particularly tricky hole with weird hazards. Rigged!"	1
"The [ck]'s courtiers expressed mild skepticism that [the twelvebytwelvian] had made three holes-in-one in the past year. Losers and haters!"	1
"The [ck] did not offer the [twelvebytwelvian] his best clubs. Of course, your porters brought better, but it's the principle of the thing."	2
"The [ck] arranged for transport between golf holes with the dingiest pony-cart you ever saw. No gold plating at all. Sad!"	2
"The [ck] drew more attention with his golfing outfit than [the twelvebytwelvian]."	2
"The [ck] did not flash an enthusiastic enough thumbs-up for the post-golf match portrait with [the twelvebytwelvian]."	2

to reset-board:
	repeat with P running through pieces:
		move P to offsite;
	repeat with P running through placed pieces:
		now P is reserved;

definition: a piece (called p) is not-last:
	if p is Fourbyfourian king, no;
	if p is reserved, yes;

section rules for what's guarded

to king-mark (p - a piece):
	let myx be xval of location of p;
	let myy be yval of location of p;
	repeat with xtemp running through {-1, 0, 1}:
		repeat with ytemp running through {-1, 0, 1}:
			if xtemp is 0 and ytemp is 0, next;
			let RR be room-from-nums of myx + xtemp and myy + ytemp;
			now RR is guarded;

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
	now all rooms are not guarded;
	repeat with Q running through placed pieces:
		if color of Q is black, next;
		if Q is a bishop, bishop-mark Q;
		if Q is a knight, knight-mark Q;
		if Q is a king, king-mark Q;

section rules for placing

this is the no-corner rule:
	if location of player is cornery and hard-mode is true:
		say "The [ck], alas, knows your tricks. He won't be snuck into some corner, at least not without any allies. You'll have to find somewhere else to 'invite' him. On another diplomatic mission, perhaps. This wasn't quite the success you'd hoped.";
		retreat-to-unity;
		the rule fails;

this is the no-corner-no-close rule:
	abide by the no-corner rule;

this is the two-knights-silly rule:
	if hard-mode is true and location of player is cornery and you-checkmated:
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
		say "I couldn't find a good match for that in [the list of not irrelevant pieces], your current allies for this quest, so I didn't do anything[if number of placed pieces > 0]. You still need to call [the list of reserved pieces][end if]. You may need to be more specific.";
		bypass disambiguation;
		the rule succeeds;
	continue the action;

rule for asking which do you mean when everything matched is not reserved (this is the bypass disambiguation 2 rule):
	if the current action is calling:
		say "I couldn't find a good match for that in [the list of reserved pieces], whom you still need to place, though I may've found a match among current allies, so I didn't do anything. So you will need to be more specific.";
		bypass disambiguation;
		the rule succeeds;
	continue the action;

chapter kicking

kicking is an action applying to one visible thing.

understand the command "kick" as something new.
understand the command "k" as something new.

understand "kick" as kicking.
understand "k" as kicking.

understand "kick [any piece]" as kicking.
understand "k [any piece]" as kicking.

does the player mean kicking a placed piece: it is very likely.

does the player mean kicking an irrelevant piece: it is very unlikely.

kick-list is a list of things variable.

rule for supplying a missing noun when kicking:
	if location of player is not puzzly:
		say "You need to be on a quest with allies placed in order to [kick].";
		reject the player's command;
	if number of pieces in location of player is 1:
		let rp be a random piece in location of player;
		now noun is rp;
		say "([the rp], who's right here)[paragraph break]";
		continue the action;
	let x be the number of entries in kick-list;
	if x is 0:
		say "You can't kick any allies out, because you haven't placed anyone yet.";
		reject the player's command;
	now noun is entry x of kick-list;
	say "([the noun], whom you called most recently)";

to place-and-list (p - a piece):
	move p to location of player;
	now p is placed;
	add p to kick-list;

null-piece is a piece.
called-loc is a room that varies.
kicked-loc is a room that varies.
called-piece is a piece that varies.
kicked-piece is a piece that varies.

to reset-temps:
	now called-loc is offsite;
	now kicked-loc is offsite;
	now called-piece is null-piece;
	now kicked-piece is null-piece;

carry out kicking:
	if location of player is not puzzly, say "You can't [kick] anyone when you're not on a quest." instead;
	if noun is not placed, say "You don't need to kick [the noun], since it isn't [if noun is irrelevant]part of the quest[else]placed yet[end if]." instead;
	reset-temps;
	now kicked-piece is noun;
	now kicked-loc is location of noun;
	abide by the unified self check check rule;
	if noun is not listed in kick-list:
		say "Oops. There is a bug here. [the noun] should be in an internal list, but it isn't. This won't affect gameplay, but it may affect recaps.[paragraph break]";
	remove noun from kick-list, if present;
	move noun to offsite;
	now noun is reserved;
	say "With no small embarrassment, you whisper to [the noun] that their presence isn't quite needed right here, right now. You assure them there's been an important change of plans and all that sort of thing.[paragraph break]";
	update-guarded;
	if number of entries in kick-list is 0:
		say "Now you have no allies placed.";
	else:
		show-the-board;
	the rule succeeds;

chapter maps

to say topbox: say "+-----------+";

to say 12sp: say "|           ";

to say vbord: say "---+";

to say dirmap of (d - a direction): say "[if d is solved]xxx[else][map-abbrev of d][end if]|";

to say spc4 of (d - a direction): say "[if d is solved]xxx[else if d is stalemated]~~~[else]4b4[end if]|";

to say topbord: say "[topbox][vbord][line break]";

to say longspc of (d - a direction): say "[12sp]|[spc4 of d][line break]";

to say midbord: say "[12sp]+[vbord][line break]";

to say bordlines of (d - a direction): say "[longspc of d][midbord]";

to say botbord:
	say "+[vbord][vbord][vbord][vbord][line break]";

to say big-map:
	say "[fixed letter spacing][topbord]";
	say "[12sp]|[dirmap of north][line break]";
	say "[bordlines of north]";
	say "[12sp]|[dirmap of northeast][line break]";
	say "[bordlines of northeast]";
	say "[12sp]|[dirmap of east][line break]";
	say "[longspc of east]";
	say "[botbord]";
	say "|[dirmap of west][dirmap of southwest][dirmap of south][dirmap of southeast][line break]";
	say "|[spc4 of west][spc4 of southwest][spc4 of south][spc4 of southeast][line break]";
	say "[botbord][r][variable letter spacing][run paragraph on]";

carry out boarding:
	if location of player is not puzzly:
		if screen-reader is true, say "Unfortunately, the map of all the [4s] would tear up a screen reader, so I can't depict it in this mode." instead;
		say "Here is a rough text representation of the map of the [4s].[paragraph break]";
		say "[big-map]" instead;
	say "STRATEGIC MAP OF [printed name of quest-dir in upper case] FOURBYFOURIA SO FAR:[line break]";
	if screen-reader is true, say "Since you are using a screen reader, text maps in any [4b] are disabled. You'll need to restart if you want to use them." instead;
	show-the-board;
	show-pieces;
	the rule succeeds.

to show-pieces:
	if number of placed pieces > 0, say "You've placed [the list of placed pieces].";
	if number of reserved pieces > 0, say "You still need to place [the list of reserved pieces].";

after printing the name of a placed piece (called p) when boarding: say " at [location of p]";

aware-of-legend is a truth state that varies.

aware-of-enemy-attacks is a truth state that varies.

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
	if aware-of-legend is false:
		say "[b]LEG[r] shows the full legend of pieces.";
		now aware-of-legend is true;
	if aware-of-enemy-attacks is false:
		if second-piece of quest-dir is placed and color of second-piece of quest-dir is black:
			say "Note that attacks for [the second-piece of quest-dir] aren't shown, as they don't restrict [the fourbyfourian], so they'd be a distraction. You'll be warned if you place [the twelvebytwelvian] where an enemy could attack him. The [second-piece of quest-dir], not being an outright obvious traitor, can only block a square [the fourbyfourian] could run to.";
			now aware-of-enemy-attacks is true;

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
	else if rm is guarded and location of player is rm:
		say "#";
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
	say "I wanted to choose 'opposite' colors from the red/yellow/blue primary and secondary colors. Blue and orange is only nice if you're a Chicago Bears fan or, worse, you actually enjoyed going to the high school I attended, you utter bum, you. Red and green is for, well, Red Green or Santa Claus, both of whom are cool and all, but not for this game. I considered brown and tan, to underscore that there wasn't any difference, but it left me a bit confused. I also wanted to avoid the white/black seen in chess as well as any too-obscure colors.[paragraph break]I also wanted to avoid colors that started with N, B or K, because I wanted the color abbreviations to make things clearer, not confuse people.";
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
		say "[line break]And yes, it's also worth noting and snickering at, if you wish, how [b]ABB[r] is not as abbreviated as [b]A[r]. But I figure people will see [b]ABOUT[r] first, and they are less likely to want or need to read it twice.";
	the rule succeeds;

chapter abouting

show-technical is a truth state that varies.

carry out abouting:
	if show-technical is false:
		say "If you haven't played [5d], the game [this-game] is a sequel to, or don't know chess well, don't worry. You don't need to plan anything--just know how the king, bishop and knight move.";
		if player is in observation grounds:
			say "More details are available here by using [xbold] on anyone present.";
		else if observation grounds are visited:
			say "[if observation grounds are visited]You've been to the Observational Grounds, where examining your allies can tell you what they do.";
	else:
		say "The technical stuff: [this-game] is a sequel to [5d], my entry in the 2021 ParserComp. I first had the idea for [this-game] a week or so before the deadline. Obviously, I couldn't do much with it besides write out the basic stuff. Most of the puzzles revolve around checkmates with very few pieces left on the board. I wondered how many I could find. I had some problems with solutions being too similar. But it seemed there was enough for a challenging game.";
	say "[line break]The next time you type [about], you will see [if show-technical is true]game history[else]gameplay[end if] details.";
	now show-technical is whether or not show-technical is false;
	the rule succeeds;

chapter ching

carry out chessing:
	say "The rules of chess are that each player gets alternate turns, but here, you get to move as much as you want.";
	say "[line break]In [this-game] you also can focus on three pieces: the knight, bishop and king.";
	say "[line break]The king can move one square in any direction, straight or diagonally. While you'll probably want to put the [4n] king in check (a bishop or knight can attack it,) you don't want the [12n] king in check. You also can't place opposing kings next to each other.";
	say "[line break]Bishops can move diagonally across the length of the board, but they can't jump over other pieces. You'll usually want bishops on the same color squares, to maximize the total squares they cover.";
	say "[line break]Knights move one square vertically and two squares horizontally, or two horizontally and one vertically. Even if other pieces, enemy or friendly, are in the way.";
	say "[line break]After placing a friendly piece, you should be able to use [mapm] to see what squares are attacked.";
	say "[line break]More details are available [if player is in observation grounds]here, if you examine your allies[else]in the Observation Grounds, inside the Ministry of Unity[end if].";
	the rule succeeds;

chapter creditsing

carry out creditsing:
	say "Thanks to chess.com, lichess.org, chessgames.com, and everyone who helped chess streaming become popular during the pandemic, on YouTube and Twitch. It saved my sanity enough to write [this-game], which will hopefully not take too much of yours. Thanks to Adam Sommerfield for ParserComp, which led to this game.";
	say "Thanks to Amanda W., FA, and Olaf Nowacki for testing help. They found more than they thought they did, and their questions helped make [this-game] much more user-friendly.";
	say "[line break]Thanks to people who found bugs during IFComp 2021: my fellow competitor A. Di Bianca and past (and hopefully future) competitor Mathbrush.";
	say "[line break]Thanks to Robin Johnson, whose technical suggestion for [5b] paid quick dividends in [this-game].";
	say "Thanks to publicdomainvectors.org for the vector art of the knight(s) and freesvg.org for the vector art of the bishop(s) in the cover art.";
	say "[line break]If you find a bug or have a transcript, mail me at [email]. Or you can report bugs at [github].";
	the rule succeeds;

chapter detailing

rule for supplying a missing noun when detailing:
	if location of player is not puzzly:
		say "There are no specific fourth-wall technical details for [the location of the player]. You should specify a directional [4b] here or go out in the field to see more. Or you can go inside, to the [grounds].";
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
	if location of player is not puzzly, say "Get ahold of yourself! Positive thinking and all that sort of thing! It won't do to admit failure." instead;
	say "You walk away, feigning boredom, pretending to the [4n] King it was HIS fault the negotiations, or whatever ... failed. This gaslighting doesn't work often, but it's worth the (lack of) effort.";
	try going outside instead;

chapter forfiving

forfiving is an action out of world.

understand the command "45" as something new.
understand the command "54" as something new.

understand "45" as forfiving.
understand "54" as forfiving.

carry out forfiving:
	say "Here are the in-game reasons the [4n] castles are five-by-five and not four-by-four: first, the [4s] are getting too big for their britches by having such a huge castle. Perhaps the increased size is a subconscious desire to be assimilated as [5b] was. They may be signaling they are worth taking over. Second, they are expressing a general need to be a part of something bigger, as they know you wouldn't just cede them territory for jollies. Third, you detect signs of disuse in the castle, a sign they can't take care of themselves here and need a little law and order.[paragraph break]Of course, if the castle were too small, perhaps the size of a [12n] baron's, it would be a sign [cq] knew they were inferior.[paragraph break]Oh, there's a fourth more technical reason I couldn't quite give four-by-four castles. You can see it with [fofiv]. It may be slightly spoilery.";
	say "[line break]Oh, here's the fourth-wall reason why the [4n] castles are the size they are.[paragraph break]I wanted to make the castles four-by-four, but then there's no center to dump you in. I had a similar problem with Threediopolis that I skated on until Jenni Polodna noticed 444 wasn't the center of a 10x10x10 cube. It just didn't feel right dumping you in an almost-center or a corner to start.[paragraph break]I also think having a bit more space works a bit better, and it allowed for me to require conceptually different solutions for the southeastern [4s] in hard mode. The downside may be that, with more space, there may be too many options, even in normal mode.";
	the rule succeeds;

chapter hinting

carry out helping:
	if walkthrough-hint is false:
		now walkthrough-hint is true;
		say "[line break]NOTE: if you want full hints, the walkthrough.txt file that came with this binary should have the details. This command tries to give you hints without spoiling anything. This nag will not appear again." instead;
	if location of player is not puzzly, say "You have no specific tasks in [the location of the player], but you can hint a direction if you want, for specific [4s]." instead;
	abide by the visit-text of quest-dir;
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

chapter leging

leging is an action out of world.

understand the command "leg" as something new.

understand "leg" as leging.

carry out leging:
	if screen-reader is true, say "Since there are no text maps in screen reader mode, the LEG command is unfortunately of limited use." instead;
	say "[b][fixed letter spacing]UNOCCUPIED BY ALLIES:[r][variable letter spacing] + = guarded square, # = your location (guarded), * = your location (unguarded), - = uninhabited and unguarded.";
	say "[b][fixed letter spacing]  OCCUPIED BY ALLIES:[r][variable letter spacing] K, B and N refer to king, bishop and knight. If they are lower-case, they are enemy or traitorous pieces.";
	now aware-of-legend is true;
	the rule succeeds;

chapter metaing

metaing is an action out of world.

understand the command "meta" as something new.
understand the command "met" as something new.
understand the command "me" as something new.

understand "meta" as metaing.
understand "met" as metaing.
understand "me" as metaing.

to say mne: say "[b]MNE[r]/[b]MN[r]"

to say fofiv: say "[b]45[r] or [b]54[r]"

to say mapm: say "[b]MAP[r] or [b]M[r]"

carry out metaing:
	say "Here is a list of meta-verbs and options you can use. None are necessary to complete the game, but they can all be useful.";
	say "[line break][about] tells about the game. [cred] tells more technical details and thanks testers. [b]CHESS[r] or [b]CH[r] gives the relevant rules of chess. [b]DETAILS[r]/[b]DETAIL[r]/[b]D[r] gives some fourth-wall meta-details about your current quest.";
	say "[line break][mapm] or [b]BOARD[r] or [b]B[r] shows the current quest map. [b]TOGGLE[r] or [b]T[r] toggles the map. [b]LEG[r] shows the quest map legend.";
	now aware-of-legend is true;
	if c3 is visited, say "[line break][fofiv] gives an explanation for why the [4n] castles are not, well, four-by-four.";
	say "[line break][b]HINT[r] or [b]H[r] hints your current area or, if you give a direction, an area you've tried but haven't beaten yet.";
	if number of solved directions > 0, say "[line break][b]R[r] or [b]RECAP[r] is available to recap areas you've solved. By default, it goes to the last one, but you can specify a direction.";
	if player is in Ministry of Unity:
		if ever-mnemonic is true or map is examined:
			say "[line break][mne] also lets you [if ever-mnemonic is true]review[else]learn[end if]process mnemonics for which allies go to which [4b].";
	the rule succeeds;

chapter mnemonicing

ever-mnemonic is a truth state that varies.

mnemonicing is an action out of world.

understand the command "mne" as something new.
understand the command "mn" as something new.

understand "mne" as mnemonicing.
understand "mn" as mnemonicing.

carry out mnemonicing:
	say "You study the map [if ever-mnemonic is true]some more [end if]to see how the [4n] conquests line up. You note you ally with bishops on the east edge (north down to southeast) and knights on the south edge (west over to southeast.) Also, diagonal directions feature one knight and one bishop.";
	now ever-mnemonic is true;
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
	say "Going with the last solved direction, [last-solved].";
	now the noun is last-solved;

to say stale-list of (L - a list of rooms) and (d - a direction):
	say "[the Twelvebytwelvian king] at [entry 1 of L], [the first-piece of D] at [entry 2 of L], and [the Fourbyfourian king] at [entry 3 of L]";

to say list-out of (L - a list of rooms) and (d - a direction):
	say "[the Twelvebytwelvian king] at [entry 1 of L], [the first-piece of D] at [entry 2 of L], [the second-piece of D] at [entry 3 of L], and [the Fourbyfourian king] at [entry 4 of L]";

carry out recaping:
	if number of not unsolved directions is 0, say "You have no conquerings to recap. Yet." instead;
	if noun is not questable, say "That's not a [4b] to conquer." instead;
	if noun is unsolved:
		say "You haven't taken over [q of noun] yet[if noun is untried]. In fact, you haven't even been there[end if].";
		if noun is primary:
			say "[line break]In [q of noun], you'll need the help of [the first-piece of noun][if noun is unsolved] and [the second-piece of noun][end if].";
		the rule succeeds;
	if noun is stalemated:
		say "You're halfway to conquering [q of noun].";
	if noun is solved:
		if recap-text of noun is empty:
			say "[paragraph break][q of noun] needs recap text.";
		else:
			say "[paragraph break][recap-text of noun]";
	say "[line break]Here are specifics of [if noun is stalemated]your progress in[else]conquering[end if] [q of noun]: ";
	if noun is stalemate-bypassed:
		let dir2 be similar-early of noun;
		say "[if noun is not solved]so far, [end if]you bypassed (in-game) gaining the [k of noun]'s trust (stalemating) because you did so in [q of dir2] with [stale-list of stalemate-recap of dir2 and dir2].";
	else:
		say "[if noun is solved]Y[else]So far, y[end if]ou gained the enemy king's trust (stalemated) with [if noun is primary][stale-list of stalemate-recap of noun and noun][else][list-out of stalemate-recap of noun and noun][end if].";
	if noun is solved:
		say "[line break]  You [if noun is not stalemate-bypassed]then [end if]captured the enemy king (checkmated) with [list-out of checkmate-recap of noun and noun].";
	the rule succeeds;

chapter toggleing

player-knows-toggle is a truth state that varies.

carry out toggleing:
	if screen-reader is true, say "Since you are using a screen reader, text maps are disabled. You'll need to restart if you want to use them or change their options." instead;
	now map-view is whether or not map-view is false;
	say "Map text-graphics view toggled to [on-off of map-view].";
	if map-view is false, the rule succeeds;
	say "[line break]";
	if location of player is not puzzly, say "Before you go on quests, this only affects viewing the map of the Fourbyfourias." instead;
	say "Showing the map.";
	show-the-board;
	now player-knows-toggle is true;
	the rule succeeds;

chapter verbs

carry out verbsing:
	say "[this-game] uses a simplified parser. The main commands are the planar directions: [b]N[r], [b]S[r], [b]E[r], [b]W[r], [b]NW[r], [b]NE[r], [b]SW[r], [b]SE[r]. [b]U[r] and [b]D[r], for up and down, aren't used. [b]OUT[r] anywhere but the [ministry] returns you to the [ministry].";
	say "[line break]You can also ignore directions to jump to a square when you're not in the Ministry of Unity. So typing [b]a1[r] sends you to a1, etc.[paragraph break]You can also [b]CALL[r]/[b]C[r] or [b]PLACE[r]/[b]P[r] a piece, enemy or friendly. Calling a piece already on the board moves it, and calling a piece to an occupied square removes the previous piece. These have abbreviations, too: [b]ABB[r] finds them.";
	say "[line break]Meta-verbs and options are discussed in [b]META[r] ([b]MET[r]/[b]ME[r]). None of these are required, but they may ease play considerably.";
	say "[line break][b]UNDO[r] is also available but of limited use. Any quest can be solved in a maximum of seven moves, and you can always [kick] a piece off the board, anyway.";
	the rule succeeds;

chapter xyzzy

carry out xyzzying:
	note-amusing-stuff "xyzzy";
	if location of player is not puzzly:
		say "The x-y plane provides enough challenges, thank you very much. You don't want or need to deal with 3-d visualization. Maybe some younguns with fresher brains could figure it out. And fresher legs. If there're any underworld monsters, I bet they're BRUTAL.";
	else:
		say "You wouldn't want to pick a fight with any 26-wide country, that's for sure. Also, there are no secret doors on the west side of the castle."

volume post-game detailing

book amusing stuff

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
			if debug-state is true:
				say "DEBUG: [code entry] amusement entry [if done-yet entry is true]re[end if]done.";
			now done-yet entry is true;
			continue the action;
	say "WARNING: tried to note you already did amusing stuff with code [t] but couldn't find it in the table. Let me know at [email].";

table of amusing stuff
code	done-yet	amuse-list
"beatdown"	false	"Constructing a double check (both allies, no traitors, attacking [the fourbyfourian])"
"nvb-miss"	false	"Placing your knight where it would be checkmate, but the traitor bishop can attack it"
"bvn-miss"	false	"Placing the bishop too far from the king when you have the traitor knight"
"bb-colors-first"	false	"Placing two opposing bishops on the same color tile"
"bb-colors-second"	false	"Placing your two bishops on the same color tile"
"knight-moves-1"	false	"Moving one of the eight L-shaped directions from [5b] in the Ministry of Unity"
"knight-moves-2"	false	"Moving one of the eight L-shaped directions from [5b] in a [4b]"
"northwest"	false	"Going northwest in the [ministry]"
"orwell"	false	"Checkmating with two knights and a king in the corner (hard mode only)"
"self-check"	false	"Putting your own king in check"
"standoff"	false	"Placing opposing minor pieces so one or both attacks the other"
"xyzzy"	false	"Everyone's favorite* text-adventure in-joke, XYZZY"

book normal previewing hard mode

the tweaked print the final question rule is listed instead of the print the final question rule in before handling the final question.

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule		final response activity
--	false	"p/pre/preview"	check-normal rule	--

hard-previewing is an activity.

this is the check-normal rule:
	if hard-mode is true:
		issue miscellaneous library message number 8;
		the rule fails;
	say "In hard mode, the first four checkmates are the same, but one of the stalemates is modified. The real challenge is in all three final regions ([q of east], [q of south], and [q of southeast]), where you can't stalemate or checkmate the enemy king in the corner, and the game rejects similar checkmates between quests.";

when play begins (this is the part-boldify final options rule):
	choose row with final response rule of immediately undo rule in Table of Final Question Options;
	now final question wording entry is "[b]UNDO[r] the last command";
	choose row with final response rule of immediately restore saved game rule in Table of Final Question Options;
	now final question wording entry is "[b]RESTORE[r] a saved game";

This is the tweaked print the final question rule:
	let named options count be 0;
	repeat through the Table of Final Question Options:
		if the only if victorious entry is false or the story has ended finally:
			if there is a final response rule entry
				or the final response activity entry [activity] is not empty:
				if there is a final question wording entry, increase named options count by 1;
	if the named options count is less than 1, abide by the immediately quit rule;
	say "Would you like to ";
	if hard-mode is false, say "[b]P[r]/[b]PRE[r]/[b]PREVIEW[r] hard mode, ";
	repeat through the Table of Final Question Options:
		if the only if victorious entry is false or the story has ended finally:
			if there is a final response rule entry
				or the final response activity entry [activity] is not empty:
				if there is a final question wording entry:
					say "[b][final question wording entry][r]";
					decrease named options count by 1;
					if the named options count is 0:
						say "?[line break]";
					otherwise if the named options count is 1:
						if the serial comma option is active, say ",";
						say " or ";
					otherwise:
						say ", ";

volume parser rules and errors

rule for printing a parser error:
	say "I didn't recognize that command. Type [verbs] to see the full list of commands. [if location of player is puzzly][b]P[r] to place a piece is probably the big one. [end if]If you're confused what to do, [b]X[r] your manual again[if location of player is puzzly], or refer to the current map with [mapm][end if]."

volume beta testing - not for release

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
	if location of player is not puzzly:
		say "Undone. Note that there is nothing worth undoing when you aren't questing.";
	say "Undone. Note that if you want to remove an ally you've called, [kick] works. You can also [cp] an already-placed piece to move it over, and you can always reset everything by going [b]OUT[r].";

volume when play begins

the player is in Ministry of Unity. description of player is "You're ... distinguished. A distinguished spy. Or people say you are. Distinguished, that is. Anyone saying you were a spy, even as a joke ... no. No. They would not."

to say stalemate-ticks:
	repeat with D running through directions:
		if D is not stalemated, next;
		if D is north and northeast is stalemated, next;
		if D is west and southwest is stalemated, next;
		if D is stalemated, say "+";

when play begins (this is the assign variables and check for skips rule):
	now left hand status line is "[if location of player is puzzly][q of quest-dir], [location of player] ([quick-text of quest-dir])[else][location of player][end if]";
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

when play begins (this is the initial unchangeable options rule):
	if debug-state is true:
		say "Forcing hard mode for testing purposes, because that is more likely to catch bugs. NORM will switch to normal mode.";
		now hard-mode is true;
		continue the action;
	say "[i][this-game] can be played on hard or normal mode. In hard mode, some proper solutions will be rejected to force the player to try different approaches to different areas. Normal mode is recommended for newer chess players, at least for the first time through.[r]";
	while 1 is 1:
		say "So, H for hard mode, or N for normal?";
		let L be the chosen letter;
		if L is 72 or L is 104:
			now hard-mode is true;
			continue the action;
		if L is 78 or L is 110:
			continue the action;
	say "[this-game] has an option to use text maps in some places. This may cause problems with a screen reader. Are you using a screen reader?";
	if the player consents:
		now screen-reader is true;

when play begins (this is the randomizing game details rule):
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
	sort the table of incidents in rough-order order;

after printing the locale description when instructions-given is false:
	say "[bracket][b]NOTE[r]: to get you started, [b]ABOUT[r] will give general information about [this-game]. [verbs] will show common verbs, which usually have abbreviations, and [b]CHESS[r] or [b]CH[r] will give the relevant rules of chess.[close bracket][line break]";
	now instructions-given is true;
	continue the action;

to print-intro:
	say "The treaty was signed at the first Council of Sensibly Bordered Nations. After [12b] annexed [5b], you, who had risen to the office of Chief Diplomat, assured the seven [4n] mini-states that of COURSE there would be no further conquests. While swooping up the seven of them would increase [12b]'s size almost doubly, why, you'd have to rename yourself Sixteenbysixteenia in the process, and that was just too awkward a name.";
	wfak;
	say "That was good enough for them, but not really. They established border patrols. They improved their spying. You brought up their paranoia, their spying, at future Councils, mentioning how [12b] has more landmass than the [4s] combined, but who got nine times more votes per square mile? Not this guy's country! If there was anyone not to trust, it was those rinky-dink kingdoms whispering among each other. And with each year that passed, you expected to gain trust you wouldn't attack and gobble them up, but they only seemed to suspect you more. Even though [12b]'s border patrols went to the northwest frontier, against bigger, tougher countries!";
	wfak;
	say "You'd let them bait you long enough. You see, after the first council, a courtier suggested in private that, perhaps, Sixteenbysixteenia wasn't the only possible name if the [4b] mini-states were vacuumed up. Largeboxica! Doubleboardistan! Foursquaresquareland! Even Twofiftysixia!";
	wfak;
	say "Obviously a much more level-headed fellow than that nutcase who claimed the sun and moon didn't follow [12b] ... or whatever [12b]'s real name should be. Well, level-headed until he expected an advanced title. He should have just let you buy his silence. It would have been more than generous. And the ex-nations newly in the fold? Why, they could vote on the favorite name!";
	wfak;
	say "And if those full-square-worldists wanted to oppose your forging a bit of unity that actually made [i]sense[r], well, you would expose their inconsistencies! Still, there is a matter of diplomacy. No all-out wars. A mission, between high-ranking officers of each state. You've had time to cultivate some allies in the ranks of some of the outer realms. Not quite the inner ones, yet.";
	wfak;
	say "You've gotten too old and fat, I mean distinguished, to ride your super-speedy horse that served so well annexing [5b]. But you are alive, and it, alas, is not, despite the best medical attention. And you've shown your worth without it. Planning. Skill. A quick mind.  Noting the [4n] castles were, in fact, five-by-five. Indicating a need to be a part of something bigger. From there, more reasons for annexation were found. Enough to build the Ministry of Unity.";
	wfak;
	say "Where the final touches are laid on the plans. Four of the satellite nations have traitors, waiting for power, who will help you. The others--well, you will need to strike quickly and not be too obvious. You flip a doubloon (not THAT hollow) towards the scribe who applies the finishing touches of an odd script, made just for you, called 'BASIC ENDGAME MANUAL.' And off you go!";

volume beta testing - not for release

include Start With Transcripts by Andrew Schultz.

when play begins (this is the fourbyfourian instruction rule):
	say "For testers: do what you can. I'm mainly curious how the first four quests work out. My hope is that they get easier the more you do, so you're ready for the final three.";
	say "[line break]Also, I am wondering about if you found the mnemonic for what quests are in which direction useful or sensible or not.";
	say "[line break]I have general concerns about the text too. I hope the text when someone makes an errant try is funny, and I want it there for chess players. But I don't want to discourage non-players. I also suspect I have forgotten a few descriptions in my notes.";
	say "[line break]The hinting can probably be adjusted, too.";
	say "[wfak]";

the fourbyfourian instruction rule is listed after the prompt transcript when starting rule in the when play begins rulebook.
