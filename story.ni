"Fourbyfourian Intrigue" by Andrew Schultz

volume rooms

a room has a number called xval. a room has a number called yval. a room has text called room-edge-text. the description of a room is usually "You are [room-edge-text of the item described]. You can go [if number of viable directions is 8]any which way[else][list of viable directions]."

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

volume when play begins

the player is in c2. description of player is "You're ... distinguished. A distinguished spy."

when play begins:
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
