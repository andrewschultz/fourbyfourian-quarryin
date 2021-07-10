"Fourbyfourian Intrigue" by Andrew Schultz

the story headline is "Flagrant Horsing Around".

the story description is "Less impossible than beating Stockfish".

volume basics and definitions

include Trivial Niceties by Andrew Schultz.

include Bypass Disambiguation by Climbing Stars.

debug-state is a truth state that varies.

to say 4b: say "Fourbyfouria"

to say 12b: say "Twelvebytwelvia"

to say q of (d - a direction):
	let t be indexed text;
	now t is "[d]" in title case;
	say "[t] [4b]";

section scoring

check requesting the score:
	say "This game doesn't keep track of scores, but to give you an idea of your progress, you've helped conquer [number of solved directions] of [number of questable directions] [4b]s so far[one of].[paragraph break]This is tracked in the upper-right status bar[or][stopping]." instead;

The print final score rule is not listed in the for printing the player's obituary rulebook.

book i6 modification(s)

section Command-Line Verb Expansion

Include (-
Replace LanguageVerb;
-) after "Definitions.i6t".

Include (-
[ LanguageVerb i;
	switch (i) {
	'i//','inv','inventory': print "take inventory";
	'l//':   print "look";
	'x//':   print "examine";
	'z//':   print "wait";
	'about':  print "see info about the game";
	'credit', 'credits': print "see the credits";
	'c//', 'p//', 'call', 'place': print "(P)lace or (C)all";
	'g//', 'gt//': print "go to";
	'd//', 'detail': print "print details about";
	default: rfalse;
	}
	rtrue;
];
-) after "Language.i6t".


Include (-

#Undef AGAIN2__WD;
Constant AGAIN2__WD = 'again';

-) after "Language.i6t".

chapter modules not for release

[add hyphen above to really Git Tuff on debug code]

include Debug Levels and Checks by Andrew Schultz.

volume starting

volume rooms

to decide which number is the parity of (r - a room):
	decide on the remainder after dividing (xval of r + yval of r) by 2;

to decide if (r1 - a room) and (r2 - a room) are samecolored:
	if parity of r1 is parity of r2, yes;
	no;

to decide which number is edge-count of (r - a room):
	let temp be 0;
	if xval of r is 4 or yval of r is 4, increment temp;
	if xval of r is 0 or yval of r is 0, increment temp;
	decide on temp;

definition: a room (called r) is edgy:
	if edge-count of r > 0, yes;
	no;

definition: a room (called r) is cornery:
	if edge-count of r is 2, yes;
	no;

chapter central

the Ministry of Unity is a room. xval is 8. yval is 8. "Conquests await [list of to-solve directions] from here[if number of solved directions > 0]. You've already taken care of business to the [list of solved directions][end if].".

the hub check rule is listed first in the check going rulebook.

to decide what indexed text is conquest of (d - a direction):
	let temp be "[d]" in title case;
	decide on "[temp] [4b]"

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
		if noun is northwest, say "Alas, the vast lands northwest of [12b] are inhospitable and forbidding to would-be conquerors." instead;
		if noun is unquestable, say "You can't go [noun] from the Ministry." instead;
		if noun is solved, say "You already conquered [noun] [4b]." instead;
		abide by can-visit of noun;
		now quest-dir is noun;
		say "You head to [conquest of noun]. Assisting you to entrap the enemy king are [the first-piece of noun] and [the second-piece of noun].";
		new-quest;
		move player to c3 instead;
	if noun is inside:
		say "You need to go a planar direction.";

chapter the grid

a room has a number called xval. a room has a number called yval. a room has text called room-edge-text. the description of a room is usually "You are [room-edge-text of the item described]. You can go [if number of viable directions is 8]any which way[else][list of viable directions][end if]."

a room can be guarded. A room is usually not guarded.

offsite is a room. xval of offsite is -3. yval of offsite is -3.

a1 is a room. xval of a1 is 0. yval of a1 is 0. room-edge-text is "at the relatively inaccessible southwest corner".

b1 is a room. xval of b1 is 1. yval of b1 is 0. room-edge-text is "on the south edge and near the west edge".

c1 is a room. xval of c1 is 2. yval of c1 is 0. room-edge-text is "in the center of the south edge".

d1 is a room. xval of d1 is 3. yval of d1 is 0. room-edge-text is "on the south edge and near the east edge".

e1 is a room. xval of e1 is 4. yval of e1 is 0. room-edge-text is "at the relatively inaccessible southeast corner".

a2 is a room. xval of a2 is 0. yval of a2 is 1. room-edge-text is "on the west edge and near the south edge".

b2 is a room. xval of b2 is 1. yval of b2 is 1. room-edge-text is "in a southwest-ish area".

c2 is a room. xval of c2 is 2. yval of c2 is 1. room-edge-text is "just south of the center".

d2 is a room. xval of d2 is 3. yval of d2 is 1. room-edge-text is "in a southeast-ish area".

e2 is a room. xval of e2 is 4. yval of e2 is 1. room-edge-text is "on the east edge and near the south edge".

a3 is a room. xval of a3 is 0. yval of a3 is 2. room-edge-text is "at the center of the west edge".

b3 is a room. xval of b3 is 1. yval of b3 is 2. room-edge-text is "just west of the center".

c3 is a room. xval of c3 is 2. yval of c3 is 2. room-edge-text is "smack in the center".

d3 is a room. xval of d3 is 3. yval of d3 is 2. room-edge-text is "just east of the center".

e3 is a room. xval of e3 is 4. yval of e3 is 2. room-edge-text is "at the center of the east edge".

a4 is a room. xval of a4 is 0. yval of a4 is 3. room-edge-text is "on the west edge and near the north edge".

b4 is a room. xval of b4 is 1. yval of b4 is 3. room-edge-text is "in a northwest-ish area".

c4 is a room. xval of c4 is 2. yval of c4 is 3. room-edge-text is "just north of the center".

d4 is a room. xval of d4 is 3. yval of d4 is 3. room-edge-text is "in a northeast-ish area".

e4 is a room. xval of e4 is 4. yval of e4 is 3. room-edge-text is "on the east edge and near the north edge".

a5 is a room. xval of a5 is 0. yval of a5 is 4. room-edge-text is "at the relatively inaccessible northwest corner".

b5 is a room. xval of b5 is 1. yval of b5 is 4. room-edge-text is "on the north edge and near the west edge".

c5 is a room. xval of c5 is 2. yval of c5 is 4. room-edge-text is "in the center of the north edge".

d5 is a room. xval of d5 is 3. yval of d5 is 4. room-edge-text is "on the north edge and near the east edge".

e5 is a room. xval of e5 is 4. yval of e5 is 4. room-edge-text is "at the relatively inaccessible northeast corner".

to decide which room is reverse-room of (x - a number) and (y - a number):
	repeat with Q running through rooms:
		if xval of Q is x and yval of Q is y, decide on Q;
	decide on offsite;

to decide which number is basic-dist of (r1 - a room) and (r2 - a room):
	decide on abs of (xval of r1 - xval of r2) + abs of (yval of r1 - yval of r2)

to decide which number is basic-dist of (t1 - a thing) and (t2 - a thing):
	decide on basic-dist of location of t1 and location of t2;

to decide which number is diag-dist of (r1 - a room) and (r2 - a room):
	let x be abs of (xval of r1 - xval of r2);
	let y be abs of (yval of r1 - yval of r2);
	if x > y, decide on x;
	decide on y;

to decide which number is diag-dist of (t1 - a thing) and (t2 - a thing):
	decide on diag-dist of location of t1 and location of t2;

volume pieces

team is a kind of value. the teams are black and white.

a piece is a kind of person. a piece can be reserved, irrelevant or placed. a piece is usually irrelevant. a piece has a list of truth state called summon-list. a piece has text called short-text.

a piece has a team called the color.

chapter whether attacks

to decide which number is abs of (n - a number):
	if n > 0, decide on n;
	decide on 0 - n;

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
	let dx be abs of (x1 - x2);
	let dy be abs of (y1 - y2);
	if p1 is a king:
		if dx > 1, no;
		if dy > 1, no;
		yes;
	if p1 is a bishop:
		if abs of (x1 - x2) is not abs of (y1 - y2), no;
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
			if debug-state is true, say "[R2] [q] of [location of p1] is an escapable square.";
			no;
	yes;

chapter bishop

a bishop is a kind of piece.

the friendly bishop is a bishop. color of friendly bishop is white. understand "b" and "fb" as friendly bishop.

the enemy traitor bishop is a bishop. color of enemy traitor bishop is black. understand "b" and "eb" as enemy bishop.

the second bishop is a bishop. color of second bishop is white. understand "b" and "sb" as second bishop.

chapter knight

a knight is a kind of piece.

the friendly knight is a knight. color of friendly knight is white. understand "n" and "fn" as friendly knight.

the enemy traitor knight is a knight. color of enemy traitor knight is black. understand "n" and "en" as enemy knight.

the second knight is a knight. color of second knight is white. understand "n" and "sn" as second knight.

chapter king

a king is a kind of piece.

the friendly king is a king. color of friendly king is white. understand "k" and "fk" as friendly king.

the enemy king is a king. color of enemy king is black. understand "k" and "ek" as enemy king.

volume directions

quest-dir is a direction that varies. quest-dir is inside.

chapter properties for quests

a direction can be unquestable, primary, secondary or tertiary. a direction is usually unquestable. [okay, number crunchers will note it's usually primary, but we want to set questable directions explicitly.]

a direction can be tried or untried. a direction is usually untried.

a direction can be solved or unsolved. a direction is usually unsolved.

a direction has a piece called first-piece.

a direction has a piece called second-piece.

a direction has a rule called can-visit. can-visit of a direction is usually the trivially ignorable rule.

a direction has a rule called king-place. king-place of a direction is usually the trivially ignorable rule.

a direction has a rule called right-checkmate. right-checkmate of a direction is usually the trivially ignorable rule.

a direction has text called quest-details.

a direction has text called hint-text.

a direction has text called quick-text.

section direction definitions

definition: a direction (called d) is viable:
	if the room d from the location of player is nowhere, no;
	yes;

definition: a direction (called d) is questable: [ We can say "not unquestable" but I'd like to make clear code when necessary. ]
	if d is unquestable, no;
	yes;

definition: a direction (called d) is to-solve:
	if d is unquestable, no;
	if d is solved, no;
	yes;

section individual quest properties

first-piece of southwest is friendly bishop. second-piece of southwest is enemy traitor bishop. southwest is primary. quick-text of southwest is "B vs. N".

first-piece of north is friendly knight. second-piece of north is enemy traitor bishop. north is primary. quick-text of north is "N vs. B".

first-piece of northeast is friendly knight. second-piece of northeast is enemy traitor knight. northeast is primary. quick-text of northeast is "N vs. N".

first-piece of west is friendly bishop. second-piece of west is enemy traitor knight. west is primary. quick-text of west is "N vs. B".

first-piece of south is friendly knight. second-piece of south is second knight. king-place of south is no-corner-no-close rule. can-visit of south is two-cleared rule. south is secondary. quest-details of south is "The bishop and knight checkmate is a tricky one. It took me a while to figure. I walked away saying, 'Hey, look, here's proof that the two bishops are better than a bishop and knight if pawns aren't in the way.' But one night I was able to put it together: you have to push the enemy king to the corner your bishop can't cover, then push the king to the other corner. Having the bishop two squares from your knight puts a lock on critical escape squares, and the checkmate taught me a lot about square control.". hint-text of south is "[piece-cooperation]". quick-text of south is "2 N's".

first-piece of east is friendly bishop. second-piece of east is second bishop. king-place of east is no-corner-no-close rule. can-visit of east is two-cleared rule. east is secondary. quest-details of east is "Checkmate with two bishops and nothing else isn't too bad to figure out. You push the enemy king to the side of the board, where he has only two moves. Then you lose a move with one of the bishop as you roll him into the corner. However, I was shocked to learn one Chicago area master I respected greatly (I had a Learning Experience against him) was unable to convert the advantage in a tournament with long time controls.". hint-text of east is "[piece-cooperation]". quick-text of east is "2 B's".

first-piece of southeast is friendly bishop. second-piece of southeast is friendly knight. king-place of southeast is no-corner-no-close rule. can-visit of southeast is corner-cleared rule. southeast is secondary. quest-details of southeast is "Checkmate with two knights against a king is impossible unless the opponent cooperates. However, two knights against a pawn may be very possible indeed, depending on where the pawn is. You can Google Troitsky Line for more on that. I remember reading an article about the endgame at math camp in high school. We were all pretty smart, but we didn't get far with it. Years later I read a blog post describing the strategies in an actual tournament game and remembered math camp. I felt pretty smart understanding the concept. Then I found out the person with the two knights ... wasn't in high school yet. I felt less smart.". hint-text of southeast is "[piece-cooperation]". quick-text of southeast is "B & N".

to say hint-minor-vs of (d - a direction):
	say "You'll need to restrict the squares the enemy king can run to. Also, your [if friendly bishop is irrelevant]knight can check but not cover escape squares[else]bishop can check and cover an escape square, but your king can't cover the rest[end if]. How can you cover that final square?"

to say piece-cooperation:
	say "You want your king to cover two escape squares, with one minor piece checking and covering an escape square, and another covering two escape squares."

section quest rules

fourth-wall-warn is a truth state that varies.

this is the corner-cleared rule:
	if east is unsolved and south is unsolved:
		say "You will need to conquer [q of south] or [q of east] to gain passage to [q of southeast]." instead;

this is the two-cleared rule:
	if number of solved directions < 1: [?? EZ - TOUGH >= 2]
		say "Tackling [q of noun] seems tactically unwise at the moment. You'll have two allies, not a traitor close to the enemy king, but a big show of strength that soon might tip your hand. Maybe [list of primary unsolved directions] seem better to start.";
		if fourth-wall-warn is false:
			now fourth-wall-warn is true;
			say "[line break]And, yes, this is totally not me saying that I believe certain [4b]s are easier to conquer than others, or at least, they have more similar themes, so you'll get off to a quicker start." instead;

volume verbs

chapter going to

rule for supplying a missing noun when gotoing:
	if player is in Ministry of Unity, now noun is c3;

definition: a room (called r) is legitimate:
	if r is offsite or r is ministry of unity, no;
	yes;

gotoing is an action applying to one visible thing.

understand the command "g" as something new.
understand the command "gt" as something new.
understand the command "go to" as something new.

understand "g [any legitimate room]" as gotoing.
understand "gt [any legitimate room]" as gotoing.
understand "go to [any legitimate room]" as gotoing.

carry out gotoing:
	if noun is location of player:
		say "You're already here." instead;
	if player is in Ministry:
		say "You need to depart from the Ministry before going anywhere." instead;
	if noun is Ministry:
		try going outside instead;
	let bd be diag-dist of location of player and noun;
	say "You take a [if bd is 1]brief[else if bd is 2]moderate[else if bd is 3]nice long[else]serious[end if] walk...";
	move player to noun;
	the rule succeeds;

chapter calling

does the player mean calling the friendly bishop when friendly bishop is reserved: it is likely.

does the player mean calling the friendly knight when friendly knight is reserved: it is likely.

does the player mean calling the enemy king when friendly king is reserved: it is unlikely.

does the player mean calling a reserved piece: it is very likely.

does the player mean calling an irrelevant piece: it is very unlikely.

calling is an action applying to one visible thing.

understand the command "call" as something new.
understand the command "c" as something new.
understand the command "place" as something new.
understand the command "p" as something new.

understand "call [any thing]" as calling.
understand "c [any thing]" as calling.
understand "place [any thing]" as calling.
understand "p [any thing]" as calling.

understand "call" as calling.
understand "c" as calling.
understand "place" as calling.
understand "p" as calling.

carry out calling:
	if location of player is Ministry of Unity, say "You don't need to call allies until you're away from the Ministry." instead;
	if noun is irrelevant, say "You don't need to call [the noun]." instead;
	if noun is enemy king and number of reserved pieces > 1, say "You will want to call [the noun] last." instead;
	if number of pieces in location of player is 1, say "But [the random piece in location of player] is already there." instead;
	if noun is placed, say "But [the noun] is already at [location of the noun]." instead;
	say "You place [the noun] at [location of player].";
	move noun to location of player;
	if noun is a bishop:
		if number of placed bishops is 1:
			let Q be a random placed bishop;
			if color of noun is white and color of Q is white and location of Q and location of player are samecolored:
				say "You realize that you are about to place both your bishops on the same color square. You may break a lot of stuffy old rules in [12b], but that's not one of them, especially since breaking that rule gives no practical benefit. Okay, it actually harms you." instead;
	now noun is placed;
	if friendly king is placed:
		if friendly king is checked:
			say "But wait. Your king would be under attack from the enemy there. You'll need to try again.";
			move noun to offsite;
			now noun is reserved;
			the rule succeeds;
	update-guarded;
	if noun is enemy king:
		if number of reserved pieces > 1:
			say "You'll want to place the enemy king last." instead;
			abide by the king-place of quest-dir;
		unless enemy king is checked:
			say "But the enemy king is not checked. So things fall apart.";
			new-quest;
			the rule succeeds;
		if enemy king is immobile:
			abide by right-checkmate of quest-dir;
			say "Bang! Got him.";
			now quest-dir is solved;
			if number of to-solve directions is 0:
				say "You win, yay!";
				end the story finally;
				the rule succeeds;
			move player to Ministry of Unity;
		else:
			say "Oh no! The enemy king escapes.";
			new-quest;
	the rule succeeds;

to new-quest:
	now quest-dir is tried;
	now all rooms are not guarded;
	now all pieces are irrelevant;
	now all kings are reserved;
	now first-piece of quest-dir is reserved;
	now second-piece of quest-dir is reserved;
	reset-board;

to reset-board:
	repeat with P running through pieces:
		move P to offsite;
	repeat with P running through placed pieces:
		now P is reserved;

definition: a piece (called p) is not-last:
	if p is enemy king, no;
	if p is reserved, yes;

section rules for what's guarded

to knight-mark (p - a piece):
	let myx be xval of location of p;
	let myy be yval of location of p;
	repeat through table of knight offsets:
		let newx be myx + the-x entry;
		let newy be myy + the-y entry;
		let RR be reverse-room of newx and newy;
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
		say "The enemy king, alas, knows your tricks. He won't be snuck into some corner, at least not without any allies. You'll have to find somewhere else to 'invite' him.";
		the rule fails;

this is the no-corner-no-close rule:
	abide by the no-corner rule;

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
		the rule succeeds;
	continue the action;

chapter maps

boarding is an action applying to nothing.

understand the command "board" as something new.
understand the command "b" as something new.
understand the command "map" as something new.
understand the command "m" as something new.

understand "board" as boarding.
understand "b" as boarding.
understand "map" as boarding.
understand "m" as boarding.

carry out boarding:
	if location of player is ministry of unity, say "There is no map to look at right now." instead;
	show-the-board;
	the rule succeeds.

to show-the-board:
	say "STRATEGIC MAP OF FIVEBYFIVIA SO FAR:[line break]";
	say "[fixed letter spacing]  a b c d e[line break]";
	say "5[pie of a5][pie of b5][pie of c5][pie of d5][pie of e5] 5[line break]";
	say "4[pie of a4][pie of b4][pie of c4][pie of d4][pie of e4] 4[line break]";
	say "3[pie of a3][pie of b3][pie of c3][pie of d3][pie of e3] 3[line break]";
	say "2[pie of a2][pie of b2][pie of c2][pie of d2][pie of e2] 2[line break]";
	say "1[pie of a1][pie of b1][pie of c1][pie of d1][pie of e1] 1[line break]";
	say "  a b c d e[variable letter spacing][paragraph break]";

to say pie of (rm - a room):
	say " ";
	if enemy bishop is in rm:
		say "b";
	else if friendly bishop is in rm or second bishop is in rm:
		say "B";
	else if enemy knight is in rm:
		say "n";
	else if friendly knight is in rm or second knight is in rm:
		say "N";
	else if friendly king is in rm:
		say "K";
	else if enemy king is in rm:
		say "k";
	else if rm is guarded:
		say "+";
	else if location of player is rm:
		say "*";
	else:
		say "-";

volume meta-verbs

chapter about

abouting is an action out of world.

understand the command "about" as something new.

understand "about" as abouting.

carry out abouting:
	the rule succeeds;

chapter credits

creditsing is an action out of world.

understand the command "credits" as something new.

understand "credits" as creditsing.

carry out creditsing:
	the rule succeeds;

chapter detailing

rule for supplying a missing noun when detailing:
	if player is in Ministry of Unity:
		say "There are no specific technical details for the Ministry of Unity. You should go out in the field to see more.";
		reject the player's command;
	now noun is quest-dir;

detailing is an action applying to one visible thing.

understand the command "d" as something new.

understand "d" as detailing.
understand "d [direction]" as detailing.

carry out detailing:
	if noun is primary, say "I remember discovering a minor piece vs. minor piece checkmate many years ago. Then I discovered a couple others. It always amused me. A post on chess.stackexchange brought old memories of this. You may be amused to note that, because of the possibility of checkmate even with cooperative play, professional blitz-chess play may allow participants to claim a forfeit with minor piece vs. minor piece, but they could not with minor piece vs. king." instead;
	if quest-details of noun is empty, say "There are no details for this, but there should be." instead;
	say "[quest-details of noun]";
	the rule succeeds;

chapter hinting

hinting is an action out of world.

understand the command "h" as something new.

understand "h" as hinting.

carry out hinting:
	if player is in Ministry of Unity, say "You have nothing to do in the [unity], but you can hint a direction if you want, for specific [4b]s." instead;
	if debug-state is false:
		abide by the can-visit of noun;
	try hintdiring quest-dir;
	the rule succeeds;

section hintdiring

hintdiring is an action applying to one visible thing.

understand "h [direction]" as hintdiring.

carry out hintdiring:
	if noun is not questable, say "No [4b] exists that way to conquer." instead;
	if noun is untried, say "You haven't looked at [q of noun] yet, so I don't want to give any hints." instead;
	if noun is solved, say "You've already conquered [q of noun], so I won't show these hints. You can restart the game or look at the source if you really want to see them, or you can [b]R[r] or [b]RECAP[r] to see details." instead;
	if noun is primary:
		say "[hint-text of noun]";
	else:
		say "[piece-cooperation]";
	the rule succeeds;

chapter verbs

verbsing is an action out of world.

understand the command "verbs" as something new.

understand "verbs" as verbsing.

carry out verbsing:
	say "Placeholder for verb description.";
	the rule succeeds;

volume parser rules and errors

after reading a command:
	if the player's command matches the regular expression "^<a-e><1-5>$":
		let n be indexed text;
		now n is "gt [the player's command]";
		change the text of the player's command to n;

volume beta testing - not for release

volume testing - not for release

rule for printing a parser error when the latest parser error is the didn't understand error or the latest parser error is the not a verb I recognise error:
	say "That wasn't a verb I recognized. You may wish to type [b]V[r] or [b]VERBS[r] to see the list of pared-down verbs in this game."

chapter when play begins

when play begins (this is the set debug state rule):
	now debug-state is true;

the set debug state rule is listed first in the when play begins rulebook.

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

test bb with "e/e/place bishop/w/w/w/place k/se/place b/s/place k". [KBBvK]
test qe with "test bb".

test nn with "s/e/place n/w/w/w/place n/se/se/e/e/place k/w/w/place k". [KNNvK]
test qs with "test nn".

test bn with "se/place n/w/place k/e/e/e/place b/sw/sw/place k". [KBNvK]
test qse with "test bn".

test a14 with "test bvb/test nvb/test nvn/test bvn".

test a56 with "test nn/test bb".

test a7 with "test qse".

test all with "test a14/test a56/test a7".

volume when play begins

the player is in Ministry of Unity. description of player is "You're ... distinguished. A distinguished spy. Or people say you are."

when play begins:
	now left hand status line is "[if player is in Ministry of Unity][location of player][else][q of quest-dir], [location of player] ([quick-text of quest-dir])";
	now right hand status line is "[number of solved directions]/[number of questable directions]";
	repeat with xval running from 0 to 4:
		repeat with yval running from 0 to 4:
			let r be reverse-room of xval and yval;
			let rn be reverse-room of xval and yval + 1;
			let re be reverse-room of xval + 1 and yval;
			let rne be reverse-room of xval + 1 and yval + 1;
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
