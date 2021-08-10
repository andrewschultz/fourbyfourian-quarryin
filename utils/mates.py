# mates.py
#
# Fourbyfouria auxiliary script
#
# this determines all the ways two minor pieces can work together to checkmate or stalemate an enemy king
#

import sys
import os
from PIL import Image

from collections import defaultdict
from itertools import permutations

# KBN: ((1, 0), (1, 1), (2, 2), (1, 2))

rooms = []

knight_move_deltas = [ (1, 2), (1, -2), (-1, 2), (-1, -2), (2, 1), (2, -1), (-2, 1), (-2, -1) ]

for x in range(0, 5):
    for y in range(0, 5):
        rooms.append((x, y))

perms = permutations(rooms, 4)

lp = list(perms)

mate_type = [ 'both', 'stalemate', 'checkmate' ]
pieces = [ 'bishop', 'knight' ]
pshort = [ 'b', 'n' ]

BOTH_MATES = 0
STALEMATE = 1
CHECKMATE = 2

html_out = "html/mates.htm"

add_to_testfile = False
write_out_graphics = False
launch_graphics = False

prev_sect = ''

cmd_count = 1

while cmd_count < len(sys.argv):
    arg = sys.argv[cmd_count].lower()
    if arg[0] == '-':
        arg = arg[1:]
    if arg == 'a':
        add_to_testfile = True
    elif arg == 'w':
        write_out_graphics = True
    elif arg in ( 'wl', 'lw' ):
        write_out_graphics = True
        launch_graphics = True
    elif arg == 'l':
        launch_graphics = True
    else:
        sys.exit("Bad argument {}. Currently only A for add to test file and W for writing out graphics and L for launching are accepted.".format(sys.argv[count]))
    cmd_count += 1

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
    for m in knight_move_deltas:
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

def write_one_graphic(placements, test_case): # king = 0 bishop = 3 knight = 4
    background = Image.open("blank-board.png")
    foreground = Image.open("newserif-bak.png")

    h_delta = 60
    v_delta = 60

    for x in range(0, 4):
        y = placements[x]
        print(y, placements)
        if x == 0:
            foreground_temp = foreground.crop((0, 0, h_delta, v_delta)).convert("RGBA")
        elif x == 3:
            foreground_temp = foreground.crop((0, v_delta, h_delta, 2 * v_delta)).convert("RGBA")
        else:
            this_delta = 3 + (test_case[x] == 'n')
            foreground_temp = foreground.crop((60 * this_delta, 0, 60 * (this_delta + 1), v_delta)).convert("RGBA")
        background.paste(foreground_temp, (60 * y[0], 60 * (4 - y[1])), foreground_temp)

    out_file = "mate-{}.png".format(test_case)
    background = background.save(os.path.join("html", out_file))
    try:
        f = open(html_out, "a")
    except:
        sys.exit("Could not create {}. Make sure the html directory exists.".format(out_file))
    global prev_sect
    if prev_sect not in out_file or not prev_sect:
        if prev_sect:
            f.write("<hr>\n")
        prev_sect = out_file[5:8]
        f.write("<center><font size=+2>{}, {} and {}</font></center>\n".format('Checkmate' if prev_sect[0] == 'c' else 'Stalemate', pieces[prev_sect[1] == 'n'], pieces[prev_sect[2] == 'n']))
    f.write("<img src = {}>\n".format(out_file))
    f.close()

def print_moves(placements, knight_1, knight_2, sub_number, checkmate):
    placements = (placements[3], placements[1], placements[2], placements[0])
    test_case = "{}{}{}{}".format('c' if checkmate else 's', pshort[knight_1], pshort[knight_2], sub_number)
    prefix = 'test {} with "'.format(test_case)
    num_knights = knight_1 + knight_2
    dir_from_kt = ['e', 's', 'se']
    move_array = [ dir_from_kt[num_knights] ]
    count = 0
    for a in placements:
        if a == (2, 2) and count == 0:
            pass
        else:
            move_array.append(loc(a))
        test_string = "place "
        if count == 0 or count == 3:
            test_string += "king"
        elif num_knights == 2:
            test_string += "bishop"
        elif num_knights == 0:
            test_string += "knight"
        else:
            test_string += "knight" if ((count == 1) == knight_1) else "bishop"
        move_array.append(test_string)
        count += 1
    print(prefix + '/'.join(move_array) + '". [auto-generated]')
    if add_to_testfile:
        f = open("testfile.txt", "a")
        f.write("> ; TEST CASE {}\n".format(test_case.upper()))
        for x in move_array:
            f.write("> " + x + "\n")
        f.write("DEBUG: {}\n".format('Checkmate' if checkmate else 'Stalemate'))
        f.write("> pf\n")
        f.write("SUCCESS\n")
        f.write("> wipe {}\n\n".format(dir_from_kt[knight_1 + knight_2]))
        f.close()
    if write_out_graphics:
        write_one_graphic(placements, test_case)

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
        checkmate = False
        for i in range (-1, 2):
            for j in range (0, 2):
                temp = blocked[(p[0][0] + i, p[0][1] + j)]
                if i == 0 and j == 0:
                    checkmate = temp
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
        print_moves(p, knight_1, knight_2, count, checkmate)
    return "Total # for {} = {}\n".format(this_mate, count)

end_string = ''

if add_to_testfile:
    f = open("testfile.txt", "w")
    f.write("> JUMP\n\n")
    f.write("# reg-4i-all-mates.txt\n")
    f.write("## generated by mates.py -a\n\n")
    f.write("** game: /home/andrew/prt/debug-fourbyfourian-quarryin.z8\n")
    f.write("** interpreter: /home/andrew/prt/dfrotz -m -w 5000\n\n")
    f.write("* main-thru\n\n")
    f.close()

if write_out_graphics:
    f = open(html_out, "w")
    f.write("<html>\n<body bgcolor=\"#cccccc\">\n")
    f.close()

for x in (STALEMATE, CHECKMATE):
    for y in (False, True):
        for z in (False, True):
            if z > y:
                continue
            end_string += get_mates(y, z, x)

print(end_string)

if write_out_graphics:
    try:
        f = open(html_out, "a")
    except:
        sys.exit("Could not create {}. Make sure the html directory exists.".format(html_out))
    f.write("</body>\n</html>\n")
    f.close()
    if launch_graphics:
        print("Launching", html_out)
        os.system(os.path.normpath(html_out))
