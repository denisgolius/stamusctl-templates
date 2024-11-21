## Templates

### ClearNDR - CE

#### Overview

TODO

#### Values

TODO

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