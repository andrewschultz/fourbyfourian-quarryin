"Fourbyfourian Intrigue" by Andrew Schultz

the story headline is "Flagrant Horsing Around".

the story description is "Less impossible than beating Stockfish".

volume basics and definitions

include Trivial Niceties by Andrew Schultz.

debug-state is a truth state that varies.

volume rooms

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

chapter directions

definition: a direction (called d) is viable:
	if the room d from the location of player is nowhere, no;
	yes;

volume pieces

team is a kind of value. the teams are black and white.

a piece is a kind of person. a piece can be reserved, irrelevant or placed. a piece is usually irrelevant. a piece has a list of truth state called summon-list. a piece has text called short-text.

a piece has a team called the color.

quest-index is a number that varies. quest-index is 1.

table of quest participants
first-piece	second-piece	orig-order	solved-yet	check-rule
friendly bishop	enemy traitor bishop	1	false	a rule
friendly knight	enemy traitor bishop	2	false	--
friendly knight	enemy traitor knight	3	false	--
friendly bishop	enemy traitor bishop	4	false	--

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

chapter knight

a knight is a kind of piece.

the friendly knight is a knight. color of friendly knight is white.

the enemy traitor knight is a knight. color of enemy traitor knight is black.

chapter king

a king is a kind of piece.

the friendly king is a king. color of friendly king is white.

the enemy traitor king is a king. color of enemy traitor king is black.

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
	if friendly king is placed:
		say "call1.";
		if friendly king is checked:
			say "But wait. Your king would be under attack from the enemy there. You'll need to try again.";
			move noun to offsite;
			the rule succeeds;
		say "call2.";
	if noun is enemy king:
		unless enemy king is checked:
			say "But the enemy king is not checked. So things fall apart.";
			new-quest;
			the rule succeeds;
		if enemy king is immobile:
			say "Bang! Got him.";
			increment quest-index;
			if quest-index is number of rows in table of quest participants:
				say "You win, yay!";
				end the story finally;
				the rule succeeds;
			new-quest;
		else:
			say "Oh no! The enemy king escapes.";
			new-quest;
	the rule succeeds;

to new-quest:
	now all pieces are irrelevant;
	now all kings are reserved;
	choose row quest-index in table of quest participants;
	now first-piece entry is reserved;
	now second-piece entry is reserved;
	reset-board;

to reset-board:
	repeat with P running through pieces:
		say "Moving [P] offsite.";
		move P to offsite;
	repeat with P running through placed pieces:
		say "Reserving [P].";
		now P is reserved;
	if player is not in c2, move the player to c2;

definition: a piece (called p) is not-last:
	if p is enemy traitor king, no;
	if p is reserved, yes;

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

the player is in c2. description of player is "You're ... distinguished. A distinguished spy. Or people say you are."

when play begins:
	if debug-state is false:
		sort the table of quest participants in random order;
	now quest-index is 1;
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
