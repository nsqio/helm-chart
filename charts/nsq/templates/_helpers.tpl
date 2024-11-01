{{/*
nsq fullname
*/}}
{{- define "nsq.fullname" -}}
{{- default .Chart.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Chart name
*/}}
{{- define "nsq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
nsqlookupd fullname
*/}}
{{- define "nsq.nsqlookupd.fullname" -}}
{{- if .Values.nsqlookupd.fullnameOverride -}}
{{- .Values.nsqlookupd.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "nsqlookupd" -}}
{{- end }}
{{- end }}

{{/*
nsqadmin fullname
*/}}
{{- define "nsq.nsqadmin.fullname" -}}
{{- if .Values.nsqadmin.fullnameOverride -}}
{{- .Values.nsqadmin.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "nsqadmin" -}}
{{- end }}
{{- end }}

{{/*
nsqd fullname
*/}}
{{- define "nsq.nsqd.fullname" -}}
{{- if .Values.nsqd.fullnameOverride -}}
{{- .Values.nsqd.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "nsqd" -}}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nsq.commonLabels" -}}
helm.sh/chart: {{ include "nsq.chart" . }}
helm.sh/release: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "nsq.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
nsqlookupd selector labels
*/}}
{{- define "nsq.nsqlookupd.selectorLabels" -}}
app.kubernetes.io/component: nsqlookupd
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
nsqadmin selector labels
*/}}
{{- define "nsq.nsqadmin.selectorLabels" -}}
app.kubernetes.io/component: nsqadmin
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
nsqd selector labels
*/}}
{{- define "nsq.nsqd.selectorLabels" -}}
app.kubernetes.io/component: nsqd
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "nsq.imagePullSecrets" -}}
  {{- $pullSecrets := list }}
  
  {{- range .Values.imagePullSecrets -}}
    {{- $pullSecrets = append $pullSecrets .name -}}
  {{- end -}}
  
  {{- range .Values.metrics.image.pullSecrets -}}
    {{- $pullSecrets = append $pullSecrets .name -}}
  {{- end -}}
  {{- if (not (empty $pullSecrets)) }}
imagePullSecrets:
    {{- range $pullSecrets }}
  - name: {{ . }}
    {{- end }}
  {{- end }}
{{- end -}}

{{- define "nsq.serviceMonitor.namespace" -}}
    {{- if .Values.metrics.serviceMonitor.namespace -}}
        {{- print .Values.metrics.serviceMonitor.namespace -}}
    {{- else -}}
        {{- print .Release.Namespace -}}
    {{- end }}
{{- end -}}

{{/*
Renders a value that contains template.
Usage:
{{ include "nsq.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "nsq.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}