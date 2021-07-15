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

BOTH_MATES = 0
STALEMATE = 1
CHECKMATE = 2

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
        count += 1
        print("BAM! Solution # {} for {}.".format(count, this_mate))
        print_board(p, blocked, knight_1, knight_2)
    return "Total # for {} = {}\n".format(this_mate, count)

end_string = ''

for x in (STALEMATE, CHECKMATE):
    end_string += get_mates(True, True, x)
    end_string += get_mates(True, False, x)
    end_string += get_mates(False, True, x)
    end_string += get_mates(False, False, x)

print(end_string)