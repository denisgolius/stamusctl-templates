#! /bin/sh

echo "Updating Suricata rules from Scirius"
docker exec {{template "base-name" .}}-scirius-{{ .Release.seed }} python /opt/scirius/manage.py updatesuricata && echo "done." || echo "ERROR"