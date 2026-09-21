#!/usr/bin/env python3
"""Check the core's JSON against what the Pocket's firmware will accept.

    tools/check_json.py [pkg/pocket]

The APF parses these files itself and says almost nothing when it cannot:
the first flash of this core stopped at `Load error in "interact" - General
Error`, which was a duplicate variable id (two entries had used id 20) and
two names longer than the field allows.  Nothing in the build caught it,
because everything in the build only ever read the files with a JSON parser,
which is not what the firmware does.

So this checks the things the firmware cares about and a parser does not:

  * every file is valid JSON and carries the magic the firmware looks for;
  * interact variable ids are unique -- the fault above;
  * names fit (the longest the MSX core ships, which the firmware accepts,
    is 17; the spec's limit is 23);
  * a list's options each have a name and a value, and there are at most 16;
  * data slot ids are unique and required slots name a filename;
  * the files are no larger than the largest this firmware is known to
    accept, because size is the one limit that cannot be read off the file.

It exits non-zero and prints every fault, not just the first.
"""
import json
import os
import sys

NAME_MAX = 23          # per Analogue's core JSON spec
OPTS_MAX = 16
SIZE_MAX = 8192        # the MSX2 core's interact.json is 7,771 and loads

MAGIC = {
    'core.json': 'APF_VER_1', 'data.json': 'APF_VER_1',
    'input.json': 'APF_VER_1', 'interact.json': 'APF_VER_1',
    'variants.json': 'APF_VER_1', 'audio.json': 'APF_VER_1',
    'video.json': 'APF_VER_1',
}


def main(argv):
    root = argv[1] if len(argv) > 1 else 'pkg/pocket'
    bad = []
    def fault(where, msg):
        bad.append(f'{where}: {msg}')

    files = []
    for dirpath, _dirs, names in os.walk(root):
        for n in sorted(names):
            if n.endswith('.json'):
                files.append(os.path.join(dirpath, n))
    if not files:
        print(f'no JSON under {root}')
        return 2

    for path in files:
        base = os.path.basename(path)
        size = os.path.getsize(path)
        try:
            d = json.load(open(path))
        except Exception as e:
            fault(path, f'not valid JSON: {e}')
            continue
        if size > SIZE_MAX:
            fault(path, f'{size} bytes, over the {SIZE_MAX} this firmware is '
                        f'known to accept')
        top = next(iter(d)) if len(d) == 1 else None
        if base in MAGIC:
            magic = d.get(top, {}).get('magic') if top else None
            if magic != MAGIC[base]:
                fault(path, f'magic is {magic!r}, expected {MAGIC[base]!r}')

        if base == 'interact.json':
            v = d['interact'].get('variables', [])
            seen = {}
            for x in v:
                i, name = x.get('id'), x.get('name', '')
                if i in seen:
                    fault(path, f'id {i} used by both {seen[i]!r} and {name!r}')
                seen[i] = name
                if len(name) > NAME_MAX:
                    fault(path, f'name {name!r} is {len(name)} characters, '
                                f'over {NAME_MAX}')
                if x.get('type') == 'list':
                    o = x.get('options', [])
                    if not o:
                        fault(path, f'{name!r} is a list with no options')
                    if len(o) > OPTS_MAX:
                        fault(path, f'{name!r} has {len(o)} options, over {OPTS_MAX}')
                    for k in o:
                        if 'name' not in k or 'value' not in k:
                            fault(path, f'{name!r} has an option missing '
                                        f'name or value: {k}')
                        elif len(k['name']) > NAME_MAX:
                            fault(path, f'{name!r} option {k["name"]!r} is '
                                        f'{len(k["name"])} characters')
                if x.get('type') != 'action' and 'address' not in x:
                    fault(path, f'{name!r} has no address')

        if base == 'data.json':
            slots = d['data'].get('data_slots', [])
            seen = {}
            for s in slots:
                i = s.get('id')
                if i in seen:
                    fault(path, f'slot id {i} used twice')
                seen[i] = s.get('name')
                if s.get('required') and not s.get('filename'):
                    fault(path, f'slot {i} is required but names no filename')

    for f in bad:
        print('  ' + f)
    print()
    if bad:
        print(f'{len(bad)} fault(s) the Pocket would refuse')
        return 1
    print(f'{len(files)} JSON files, nothing the Pocket is known to refuse')
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
