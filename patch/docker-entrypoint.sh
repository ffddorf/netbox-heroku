#!/bin/bash
set -e

for script in /opt/netbox/startup_scripts/*.py; do
  echo "⚙️ Executing '$script'"
  ./manage.py shell --interface python < "${script}"
done

echo "✅ Initialisation is done."

# launch whatever is passed by docker
# (i.e. the RUN instruction in the Dockerfile)
exec ${@}
