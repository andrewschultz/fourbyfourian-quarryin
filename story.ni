"Fourbyfourian Intrigue" by Andrew Schultz

the story headline is "Flagrant Horsing Around".

the story description is "Less impossible than beating Stockfish".

volume basics and definitions

include Trivial Niceties by Andrew Schultz.

debug-state is a truth state that varies.

chapter modules not for release

include Debug Levels and Checks by Andrew Schultz.

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

the Ministry of Unity is a room. xval is 8. yval is 8. "You can go [list of unsolved directions] from here[if number of solved-already directions > 0]. You've already taken care of business to the [list of solved-already directions][end if].".

the hub check rule is listed first in the check going rulebook.

to decide what indexed text is conquest of (d - a direction):
	let temp be "[d]" in title case;
	decide on "[temp] Fourbyfouria"

check going (this is the hub check rule):
	if noun is up or noun is down:
		say "Flying machines are a century or more away." instead;
	if player is in Ministry of Unity:
		let cur-row be 0;
		if questable of noun is false, say "You can't go [noun] from the Ministry." instead;
		if solved-yet of noun is true, say "You already conquered [noun] Fourbyfouria." instead;
		abide by can-visit of noun;
		now quest-dir is noun;
		say "You head [noun] to [conquest of noun]. Assisting you, along with your king, are [first-piece of noun] and [second-piece of noun].";
		move player to c3 instead;
	if noun is outside:
		say "You return to the Ministry of Unity. This conquest can wait for later.";
		now all pieces are irrelevant;
		move player to Ministry of Unity;
		the rule succeeds;
	if noun is inside:
		say "You need to go a planar direction.";

chapter the grid

a room has a number called xval. a room has a number called yval. a room has text called room-edge-text. the description of a room is usually "You are [room-edge-text of the item described]. You can go [if number of viable directions is 8]any which way[else][list of viable directions][end if]."

offsite is a room. xval of offsite is -3. yval of offsite is -3.

a1 is a room. xval of a1 is 0. yval of a1 is 0. room-edge-text is "in the southwest corner".

b1 is a room. xval of b1 is 1. yval of b1 is 0. room-edge-text is "just west of the center of the south edge".

c1 is a room. xval of c1 is 2. yval of c1 is 0. room-edge-text is "just east of the center of the south edge".

d1 is a room. xval of d1 is 3. yval of d1 is 0. room-edge-text is "in the southeast corner".

a2 is a room. xval of a2 is 0. yval of a2 is 1. room-edge-text is "just south of the center of the west edge".

b2 is a room. xval of b2 is 1. yval of b2 is 1. room-edge-text is "just southwest of the very center".

c2 is a room. xval of c2 is 2. yval of c2 is 1. room-edge-text is "just southeast of the very center".

d2 is a room. xval of d2 is 3. yval of d2 is 1. room-edge-text is "just south of the center of the east edge".

a3 is a room. xval of a3 is 0. yval of a3 is 2. room-edge-text is "just north of the center of the west edge".

b3 is a room. xval of b3 is 1. yval of b3 is 2. room-edge-text is "just northwest of the very center".

c3 is a room. xval of c3 is 2. yval of c3 is 2. room-edge-text is "just northeast of the very center".

d3 is a room. xval of d3 is 3. yval of d3 is 2. room-edge-text is "just south of the center of the east edge".

a4 is a room. xval of a4 is 0. yval of a4 is 3. room-edge-text is "in the northwest corner".

b4 is a room. xval of b4 is 1. yval of b4 is 3. room-edge-text is "just west of the center of the north edge".

c4 is a room. xval of c4 is 2. yval of c4 is 3. room-edge-text is "just east of the center of the north edge".

d4 is a room. xval of d4 is 3. yval of d4 is 3. room-edge-text is "in the northeast corner".

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
		let the way be the best route from location of p1 to r;
		let temp-room be location of p1;
		while 1 is 1:
			now temp-room is the room the way of temp-room;
			if temp-room is r, yes;
			if number of pieces in temp-room is 1, no;
			if temp-room is nowhere, no;
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
		let R be the room Q from location of p1;
		if R is nothing, next;
		let this-attack be false;
		repeat with p2 running through pieces:
			if location of p2 is offsite, next;
			say "Looking at [p2].";
			if color of p1 is color of p2:
				say "Same-color.";
				if location of p2 is R, now this-attack is true;
				next;
			say "Opposite color.";
			if p2 attacks R, now this-attack is true;
		if this-attack is false:
			say "[R] [q] of [location of p1] is an escapable square.";
			no;
	yes;

chapter bishop

a bishop is a kind of piece.

the friendly bishop is a bishop. color of friendly bishop is white.

the enemy traitor bishop is a bishop. color of enemy traitor bishop is black.

the second bishop is a bishop. color of second bishop is white.

chapter knight

a knight is a kind of piece.

the friendly knight is a knight. color of friendly knight is white.

the enemy traitor knight is a knight. color of enemy traitor knight is black.

the second knight is a knight. color of second knight is white.

chapter king

a king is a kind of piece.

the friendly king is a king. color of friendly king is white.

the enemy traitor king is a king. color of enemy traitor king is black.

volume directions

definition: a direction (called d) is unsolved:
	if solved-yet of d is true, no;
	if questable of d is false, no;
	yes;

definition: a direction (called d) is solved-already:
	if solved-yet of d is true, yes;
	no;

definition: a direction (called d) is viable:
	if the room d from the location of player is nowhere, no;
	yes;

quest-dir is a direction that varies.

chapter properties for quests

a direction has a truth state called questable. questable of a direction is usually false.

a direction has a truth state called solved-yet. solved-yet of a direction is usually false.

a direction has a piece called first-piece.

a direction has a piece called second-piece.

a direction has a rule called can-visit. can-visit of a direction is usually the trivially ignorable rule.

a direction has a rule called king-place. king-place of a direction is usually the trivially ignorable rule.

a direction has a rule called right-checkmate. right-checkmate of a direction is usually the trivially ignorable rule.

section individual quest properties

first-piece of southwest is friendly bishop. second-piece of southwest is enemy traitor bishop. questable of southwest is true.

first-piece of northeast is friendly knight. second-piece of northeast is enemy traitor knight. questable of northeast is true.

first-piece of west is friendly bishop. second-piece of west is enemy traitor knight. questable of west is true.

first-piece of north is friendly knight. second-piece of north is enemy traitor bishop. questable of north is true.

first-piece of east is friendly bishop. second-piece of east is second bishop. king-place of east is no-corner-no-close rule. questable of east is true.

first-piece of south is friendly knight. second-piece of south is second knight. king-place of south is no-corner-no-close rule. questable of south is true.

first-piece of southeast is friendly bishop. second-piece of southeast is friendly knight. king-place of east is no-corner-no-close rule. questable of southeast is true.

volume verbs

chapter calling

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
	if noun is irrelevant, say "You don't need to call [the noun]." instead;
	if noun is enemy king and number of reserved pieces > 1, say "You will want to call [the noun] last." instead;
	if number of pieces in location of player is 1, say "But [the random piece in location of player] is already there." instead;
	if noun is placed, say "But [the noun] is already at [location of the noun]." instead;
	say "You place [the noun] at [location of player].";
	move noun to location of player;
	now noun is placed;
	if noun is a bishop:
		if number of placed bishops is 1:
			let Q be a random placed bishop;
			if color of noun is white and color of Q is white and location of Q and location of player are samecolored:
				say "You realize that you are about to place both your bishops on the same color square. You may break a lot of stuffy old rules in Twelvebytwelvia, but that's not one of them, especially since breaking that rule gives no practical benefit. Okay, it actually harms you." instead;
	if friendly king is placed:
		dc-say "Placing friendly king.";
		if friendly king is checked:
			say "But wait. Your king would be under attack from the enemy there. You'll need to try again.";
			move noun to offsite;
			the rule succeeds;
		dc-say "Done placing friendly king, checks avoided.";
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
			if number of unsolved directions is 0:
				say "You win, yay!";
				end the story finally;
				the rule succeeds;
			move player to Ministry of Unity;
		else:
			say "Oh no! The enemy king escapes.";
			new-quest;
	the rule succeeds;

to new-quest:
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
	if p is enemy traitor king, no;
	if p is reserved, yes;

section rules for placing

this is the no-corner rule:
	if location of player is cornery:
		say "The enemy king, alas, knows your tricks. He won't be snuck into some corner, at least not without any allies. You'll have to find somewhere else to 'invite' him.";
		the rule fails;

this is the no-corner-no-close rule:
	abide by the no-corner rule;

volume beta testing - not for release

volume testing - not for release

chapter when play begins

when play begins (this is the set debug state rule):
	now debug-state is true;

the set debug state rule is listed first in the when play begins rulebook.

chapter pie

pieing is an action out of world.

understand the command "pie" as something new.

understand "pie" as pieing.

carry out pieing:
	repeat with P running through pieces:
		say "[P] [if p is irrelevant](irrelevant) [end if][location of P].";
	the rule succeeds;

chapter tests

test q1 with "w/place friendly bishop/ne/n/place enemy bishop/se/s/place friendly king/n/n/place enemy king".
test q2 with "n/place friendly knight/n/place friendly king/sw/w/place enemy bishop/n/place enemy king".
test q3 with "w/place friendly knight/ne/place friendly king/w/w/place enemy knight/n/place enemy king".
test q4 with "place friendly king/n/place friendly bishop/n/place enemy knight/w/place enemy king".

test a2 with "test q1/test q2".
test a3 with "test q1/test q2/test q3".
test a4 with "test q1/test q2/test q3/test q4".

volume when play begins

the player is in Ministry of Unity. description of player is "You're ... distinguished. A distinguished spy. Or people say you are."

when play begins:
	new-quest;
	repeat with xval running from 0 to 3:
		repeat with yval running from 0 to 3:
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
