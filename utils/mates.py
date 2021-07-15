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

def get_mates(knight_1, knight_2):
    print(knight_1, knight_2)
    count = 0
    b_n = [ 'bishop', 'knight' ]
    for p in lp:
        if p[0][0] in (0, 4): continue
        if p[0][1] > 0: continue
        if p[1][1] > 2: continue
        if p[2][1] > 2: continue
        if p[3][1] > 2: continue
        if abs(p[3][1] - p[0][1]) <= 1 and abs(p[3][0] - p[0][0]) <= 1: continue
        blocked = defaultdict(int)
        for r in rooms:
            blocked[r] = 0
        for i in range (-1, 2):
            for j in range (-1, 2):
                if on_board(p[3][0] + i, p[3][1] + j):
                    # print("Blocking", p[3][0] + i, p[3][1] + j)
                    blocked[(p[3][0] + i, p[3][1] + j)] = 1
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
                if not blocked[(p[0][0] + i, p[0][1] + j)]:
                    trapped = False
        if not trapped:
            continue
        count += 1
        print("BAM! Solution # {} {} {}.".format(count, b_n[knight_1], b_n[knight_2]))
        print_board(p, blocked, knight_1, knight_2)

get_mates(True, True)
get_mates(True, False)
get_mates(False, True)
get_mates(False, False)
