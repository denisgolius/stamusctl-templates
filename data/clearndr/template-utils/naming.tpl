{{define "base-name"}}{{.Release.name}}{{end}}
{{define "suffix-name"}}{{ if .Values.globals.skipRandom}}1{{else}}{{randAlpha 6}}{{end}}{{end}}

{{define "full-name"}}{{end}}