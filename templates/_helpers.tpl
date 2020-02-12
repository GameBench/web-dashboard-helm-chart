{{ define "gamebench.name" }}{{ default "gamebench" .Values.nameOverride | trunc 63 }}{{ end }}

{{ define "gamebench.fullname" }}
{{- $name := default "gamebench" .Values.nameOverride -}}
{{ printf "%s-%s" .Release.Name $name | trunc 63 -}}
{{ end }}
