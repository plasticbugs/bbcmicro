#!/usr/bin/env python3
"""Turn a line of text into the bench's -keys argument.

    tools/type_keys.py "SOUND1,-15,100,50\\n" [start_ms] [step_ms] [hold_ms]

The benches take key events as `ms:col,row,hold_ms`, which is the matrix
position and not a character, so typing anything longer than a word by hand is
a transcription exercise with a transcription error in it.  The positions are
already written down once, in tools/make_osk_panel.py's LAYOUT (label, row,
col, span, matrix column, matrix row), and this reads them from there so the
two cannot drift apart.

`\\n` is RETURN.  A character that needs SHIFT on the BBC's keyboard is typed
with SHIFT held across it -- the keyboard in rtl/bbc_keyboard.sv is a real
matrix, so holding two keys is just two events that overlap.
"""
import os
import re
import sys

ROOT = os.path.dirname(os.path.abspath(__file__))

# Which key SHIFT types each character on, read from the panel generator's
# own table so there is one copy and not two.  The first version of this
# file carried a second, hand-written one with the PC convention in it --
# it had underscore as SHIFT and something, where the BBC has a key of its
# own for it (column 8, row 2) -- and the tool typed ~ where the test
# wanted _.
def shifted_map():
    import ast
    src = open(os.path.join(ROOT, 'make_osk_panel.py')).read()
    tree = ast.parse(src)
    for node in tree.body:
        if isinstance(node, ast.Assign) and getattr(node.targets[0], 'id', '') == 'SHIFTED':
            base = ast.literal_eval(node.value)
            # the generator maps key -> its shifted legend; this wants the
            # other direction, and 'GBP' is what it calls the pound sign
            return {v: k for k, v in base.items()}
    raise SystemExit('make_osk_panel.py has no SHIFTED table')


def layout():
    src = open(os.path.join(ROOT, 'make_osk_panel.py')).read()
    body = src[src.index('LAYOUT = ['):]
    body = body[:body.index('\n]')]
    out = {}
    for label, _r, _c, _s, kc, kr in re.findall(
            r'\("([^"]+)",\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+)\)', body):
        out.setdefault(label, (int(kc), int(kr)))
    return out


def main(argv):
    if len(argv) < 2:
        print(__doc__)
        return 2
    text = argv[1].replace('\\n', '\n')
    start = float(argv[2]) if len(argv) > 2 else 2000.0
    step = float(argv[3]) if len(argv) > 3 else 150.0
    hold = float(argv[4]) if len(argv) > 4 else 80.0

    keys = layout()
    SHIFTED = shifted_map()
    shift = keys['SHF']
    events, t = [], start
    for ch in text:
        if ch == '\n':
            label, need_shift = 'RETURN', False
        elif ch == ' ':
            label, need_shift = 'SPACE', False
        elif ch in SHIFTED:
            label, need_shift = SHIFTED[ch], True
        else:
            label, need_shift = ch.upper(), False
        if label not in keys:
            sys.exit(f'no key on the BBC keyboard for {ch!r}')
        col, row = keys[label]
        if need_shift:
            sc, sr = shift
            events.append(f'{t - 20:.0f}:{sc},{sr},{hold + 40:.0f}')
        events.append(f'{t:.0f}:{col},{row},{hold:.0f}')
        t += step
    print(' '.join(events))
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
