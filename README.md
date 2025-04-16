## Templates

### ClearNDR - CE

#### Overview

This template is used to deploy ClearNDR CE.

#### Values

| Key                                 | Default                        | Usage                                                                                                                            |
| ----------------------------------- | ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| arkime.openport                     | false                          | Open port for Arkime Viewer ?                                                                                                    |
| cron.logrotate.enabled              | true                           | Enable logrotate for Suricata logs                                                                                               |
| cron.logrotate.period               | daily                          | Logrotate period (`1min`, `daily`, `weekly`, `monthly`)                                                                          |
| cron.updatesurirules.enabled        | true                           | Enable automatic update of Suricata rules                                                                                        |
| cron.updatesurirules.period         | daily                          | Update period (`1min`, `daily`, `weekly`, `monthly`)                                                                             |
| evebox.version                      | master                         | Evebox version to install                                                                                                        |
| globals.restartmode                 | unless-stopped                 | Restart mode for all services                                                                                                    |
| nginx.ssl.certname                  | scirius.crt                    | Name of the certificate file. Used only if ssl.enabled is true.                                                                  |
| nginx.ssl.enabled                   | true                           | Enable SSL for NGINX                                                                                                             |
| nginx.ssl.folder                    |                                | Folder on host containing SSL certificates. If set, disable automatic generation of self-signed certificates. Use absolute path. |
| nginx.ssl.keyname                   | scirius.key                    | Name of the private key file. Used only if ssl.enabled is true.                                                                  |
| opensearch.dashboards.openport      | true                           | Expose OpenSearch Dashboards port                                                                                                |
| opensearch.datapath                 | opensearch-data                | Data path on host to store OpenSearch data                                                                                       |
| opensearch.ism.delete_min_index_age | 15d                            | Minimum index age before transitioning to delete state                                                                           |
| opensearch.ism.warm_min_index_age   | 7d                             | Minimum index age before transitioning to warm state                                                                             |
| opensearch.memory                   | 2g                             | Memory limit for OpenSearch                                                                                                      |
| opensearch.openport                 | false                          | Expose OpenSearch port                                                                                                           |
| rabbitmq.openport                   | false                          | Expose RabbitMQ port                                                                                                             |
| scirius.celery.beat.restart         | unless-stopped                 | Celery beat restart mode                                                                                                         |
| scirius.celery.worker.restart       | unless-stopped                 | Celery worker restart mode                                                                                                       |
| scirius.debug                       | false                          | Enable debug mode                                                                                                                |
| scirius.registry                    | ghcr.io/stamusnetworks/scirius | Image registry where to find scirius image                                                                                       |
| scirius.version                     | clear-ndr-rc1                  | Scirius version to install                                                                                                       |
| suricata.additionalconfig           |                                | Additional configuration for Suricata                                                                                            |
| suricata.interfaces                 |                                | List of interfaces to monitor                                                                                                    |
| suricata.unixsocket.enabled         | false                          | Enable Unix Socket Output for Suricata Eve logs ?                                                                                |

## Top level variables in templates

| Variable           | Value                                                        |
| ------------------ | ------------------------------------------------------------ |
| .Values            | values given to the template by users                        |
| .Release.name      | Name of the release.                                         |
| .Release.user      | user creating the release                                    |
| .Release.group     | user's group creating the release                            |
| .Release.location  | where the release is placed                                  |
| .Release.isUpgrade | is the release an upgrade                                    |
| .Release.isInstall | is the release an install                                    |
| .Release.service   | name of the service creating the release (stamusctl/stamusd) |
| .Template.name     | name of the current template                                 |
| .Release.version   | version of the current template                              |
