import sys

from collections import defaultdict
from itertools import permutations

# KBN: ((1, 0), (1, 1), (2, 2), (1, 2))

rooms = []

move_deltas = [ (1, 2), (1, -2), (-1, 2), (-1, -2), (2, 1), (2, -1), (-2, 1), (-2, -1) ]

for x in range(0, 5):
    for y in range(0, 5):
        rooms.append((x, y))

perms = permutations(rooms, 4)

lp = list(perms)

count = 0

mate_type = [ 'both', 'stalemate', 'checkmate' ]
pieces = [ 'bishop', 'knight' ]
pshort = [ 'b', 'n' ]

BOTH_MATES = 0
STALEMATE = 1
CHECKMATE = 2

def tuple_difference(tuple1, tuple2):
    return tuple(x - y for x, y in zip(tuple1, tuple2))

def shifted(perm1, perm2):
    tuple_to_compare = tuple_difference(perm1[0], perm2[0])
    for x in range(1, len(perm1)):
        if tuple_difference(perm1[x], perm2[x]) != tuple_to_compare:
            return False
    return True

def bishop_block(coord, blocks, p):
    for x in (-1, 1):
        for y in (-1, 1):
            c = (coord[0] + x, coord[1] + y)
            while on_board(c[0], c[1]):
                blocks[(c[0], c[1])] = True
                if (c[0], c[1]) in p:
                    break
                c = (c[0] + x, c[1] + y)
    return

def knight_block(coord, blocks):
    for m in move_deltas:
        new_pair = (m[0] + coord[0], m[1] + coord[1])
        if not on_board(m[0] + coord[0], m[1] + coord[1]):
            continue
        # print("Knight", coord, "blocks", new_pair)
        blocks[new_pair] = True

def on_board(a, b):
    if a < 0 or a > 4: return False
    if b < 0 or b > 4: return False
    return True

def loc(a):
    return chr(a[0] + 97) + chr(49 + a[1])

def print_moves(placements, knight_1, knight_2, count):
    placements = (placements[3], placements[1], placements[2], placements[0])
    test_string = 'test g{}{}{} with "'.format(pshort[knight_1], pshort[knight_2], count)
    num_knights = knight_1 + knight_2
    if num_knights == 1:
        test_string += "s"
    elif num_knights == 2:
        test_string += "se"
    else:
        test_string += "e"
    count = 0
    for a in placements:
        test_string += "/" + loc(a) + "/place "
        if count == 0 or count == 3:
            test_string += "king"
        elif num_knights == 2:
            test_string += "friendly bishop" if count == 1 else "second bishop"
        elif num_knights == 0:
            test_string += "friendly knight" if count == 1 else "second knight"
        else:
            test_string += "n" if ((count == 1) == knight_1) else "b"
        count += 1
    test_string += '". [auto-generated]'
    print(test_string)

def print_board(my_perm, blocked, knight_1, knight_2):
    for y in range(4, -1, -1):
        print("+-+-+-+-+-+")
        row_string = ''
        for x in range(0, 5):
            row_string += '|'
            if my_perm[1] == (x, y):
                row_string += 'N' if knight_1 else 'B'
                continue
            if my_perm[2] == (x, y):
                row_string += 'N' if knight_2 else 'B'
                continue
            if my_perm[3] == (x, y):
                row_string += 'K'
                continue
            if my_perm[0] == (x, y):
                row_string += 'k'
                continue
            if blocked[(x, y)]:
                row_string += '+'
                continue
            row_string += ' '
        row_string += '|'
        print(row_string)
    print("+-+-+-+-+-+")

# 0 = enemy king
# 3 = my king

def get_mates(knight_1, knight_2, wanted_mate = BOTH_MATES):
    current_solutions = []
    this_mate = "{} / {} {}".format(pieces[knight_1], pieces[knight_2], mate_type[wanted_mate])
    print("=========================BEGINNING check for {}.".format(this_mate))
    count = 0 # 0 = enemy king, 1 = 1st piece, 2 = 2nd piece, 3 = your king
    for p in lp:
        if p[0][0] in (0, 1, 4): continue
        if p[0][1] > 0: continue
        if p[1][1] > 2: continue
        if p[2][1] > 2: continue
        if knight_1 == knight_2 and p[1] > p[2]:
            continue
        if p[3][1] > 2: continue
        if abs(p[3][1] - p[0][1]) <= 1 and abs(p[3][0] - p[0][0]) <= 1: continue
        blocked = defaultdict(bool)
        for r in rooms:
            blocked[r] = 0
        for i in range (-1, 2):
            for j in range (-1, 2):
                if on_board(p[3][0] + i, p[3][1] + j):
                    # print("Blocking", p[3][0] + i, p[3][1] + j)
                    blocked[(p[3][0] + i, p[3][1] + j)] = True
        if knight_1:
            knight_block(p[1], blocked)
        else:
            bishop_block(p[1], blocked, p)
        if knight_2:
            knight_block(p[2], blocked)
        else:
            bishop_block(p[2], blocked, p)
        trapped = True
        for i in range (-1, 2):
            for j in range (0, 2):
                temp = blocked[(p[0][0] + i, p[0][1] + j)]
                if i == 0 and j == 0:
                    if wanted_mate == BOTH_MATES:
                        continue
                    if wanted_mate == STALEMATE:
                        temp = not temp
                if not temp:
                    trapped = False
        if not trapped:
            continue
        duplicate_yet = False
        for x in current_solutions:
            if shifted(p, x):
                duplicate_yet = True
                break
        if duplicate_yet:
            continue

        if not knight_1 and not knight_2 and p[3][0] == p[0][0] and p[3][1] == 2: # don't get too close to the enemy king with B&B! That is an automatic stalemate even without the other bishop.
            #print("Maybe bishop lined up!")
            #print_board(p, blocked, knight_1, knight_2)
            #print("Maybe not!")
            #print(p, p[2][1], p[2][0], p[0][0], not knight_2)
            if (p[2][1] == 1 and p[2][0] == p[0][0]) or (p[1][1] == 1 and p[1][0] == p[0][0] and not knight_1):
                continue

        p2 = [(4 - x, y) for (x, y) in p]
        if p2[2] < p2[1] and knight_1 == knight_2:
            (p2[2], p2[1]) = (p2[1], p2[2])
        p2 = tuple(p2)

        for x in current_solutions:
            if shifted(p2, x):
                duplicate_yet = True
                break
        if duplicate_yet:
            continue
        current_solutions.append(p)
        count += 1
        same_color_bishop = ''
        if knight_1 == knight_2 and knight_2 == 0:
            cheap_sum = p[1][0] + p[1][1] + p[2][0] + p[2][1]
            if not cheap_sum % 2:
                same_color_bishop = " (SAME COLORED BISHOPS)"
        print("BAM! Solution # {} for {}{}.".format(count, this_mate, same_color_bishop))
        print_board(p, blocked, knight_1, knight_2)
        print_moves(p, knight_1, knight_2, count)
    return "Total # for {} = {}\n".format(this_mate, count)

end_string = ''

for x in (STALEMATE, CHECKMATE):
    for y in (False, True):
        for z in (False, True):
            if z > y:
                continue
            end_string += get_mates(y, z, x)

print(end_string)
