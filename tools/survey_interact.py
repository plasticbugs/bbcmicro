#!/usr/bin/env python3
"""Survey the interact.json of every core on a Pocket's SD card.

    tools/survey_interact.py [/Volumes/POCKET/Cores]

The firmware says `Load error in "interact" - General Error` and nothing
else, and Analogue publish no limits worth relying on.  What is on the card
is better evidence than a document: every one of those cores loads on this
firmware, so whatever they do is allowed.  Comparing this core against them
is how the second flash's fault was found -- `defaultval` on a list is an
INDEX into its options, and every core that loads uses 0 to 3 there while
this one used 256, 16384 and 2097152.

It prints one row per core; the last row is whichever core is being worked
on, so the comparison is against the whole shelf at once.
"""
import json
import os
import sys


def main(argv):
    root = argv[1] if len(argv) > 1 else '/Volumes/POCKET/Cores'
    if not os.path.isdir(root):
        print(f'{root}: not a directory -- is the card mounted?')
        return 2
    print(f"{'core':<30} {'vars':>4} {'bytes':>6} {'name':>4} {'opts':>4} "
          f"{'max option':>10}  defaultvals")
    for core in sorted(os.listdir(root)):
        p = os.path.join(root, core, 'interact.json')
        if not os.path.exists(p):
            continue
        try:
            v = json.load(open(p))['interact'].get('variables', [])
        except Exception as e:
            print(f'{core:<30} unreadable: {e}')
            continue
        maxopt = maxname = maxopts = 0
        defaults = set()
        for x in v:
            maxname = max(maxname, len(x.get('name', '')))
            if x.get('type') == 'list':
                maxopts = max(maxopts, len(x.get('options', [])))
                for o in x.get('options', []):
                    try:
                        maxopt = max(maxopt, int(str(o['value']), 16))
                    except Exception:
                        pass
            if isinstance(x.get('defaultval'), int):
                defaults.add(x['defaultval'])
        print(f'{core:<30} {len(v):>4} {os.path.getsize(p):>6} {maxname:>4} '
              f'{maxopts:>4} {maxopt:>#10x}  {sorted(defaults)}')
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
