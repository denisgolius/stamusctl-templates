## Templates

### ClearNDR - CE

#### Overview

This template is used to deploy ClearNDR CE.

#### Values

| Config    | description | default |
| -------- | ------- | ------- |
| .globals.restartmode | restart mode of all services    | "unless-stopped" |
| .opensearch.openPort | Open port of opensearch to local network | false |
| .opensearch.openPort.dashboards.openPort | Open port of opensearch-dashboards to local network | false |
| .scirius.registry | Image registry where to find scirius image | "ghcr.io/stamusnetworks/scirius" |
| .scirius.version | Scirius version to install | clearndr-ce-b1 |
| .scirius.debug | Enable debug mode | false |
| .suricata.interfaces | List of interfaces to monitor | "..."(all network interfaces on host) |
| .arkime.openPort | Open port of Arkime Viewer | false |
| .evebox.version | Evebox version to install | master |

## Top level variables in templates

| Variable    | Value |
| -------- | ------- |
| .Values    | values given to the template by users    |
| .Release.name  | Name of the release.    |
| .Release.user | user creating the release     |
| .Release.group    | user's group creating the release    |
| .Release.location    | where the release is placed    |
| .Release.isUpgrade    | is the release an upgrade    |
| .Release.isInstall    | is the release an install    |
| .Release.service    | name of the service creating the release (stamusctl/stamusd)    |
| .Template.name    | name of the current template    |
| .Release.version    | version of the current template    |