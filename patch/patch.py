#!/usr/bin/env python

import re
from glob import glob

for file in glob('/opt/netbox/netbox/project-static/jquery-ui-*/*.css'):
    print(f'replacing in {file}')
    with open(file, 'r') as f:
        text = f.read()
        text = re.sub(r'To view and modify this theme, visit .*', '', text)
    with open(file, 'w') as f:
        f.write(text)
