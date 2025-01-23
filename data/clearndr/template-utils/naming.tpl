{{define "base-name"}}{{.Release.name}}{{end}}
{{define "suffix-name"}}{{ if .Values.globals.skiprandom}}1{{else}}{{randAlpha 6}}{{end}}{{end}}

{{define "full-name"}}{{end}}

{{define "image-name"}}{{.image | default (printf "%s:%s" .registry .version )}}{{end}}