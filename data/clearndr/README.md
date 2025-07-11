# ClearNDR Template

This template deploys ClearNDR CE (Community Edition), a comprehensive Network Detection and Response solution built on open-source components.

## Overview

ClearNDR provides network security monitoring, intrusion detection, and threat analysis capabilities through an integrated stack of security tools. The template orchestrates the deployment of all components using Docker Compose.

## Components

### Core Components

- **Suricata**: High-performance network intrusion detection system (IDS/IPS)
- **Scirius**: Web-based rule management and event analysis interface
- **OpenSearch**: Search and analytics engine for log data
- **OpenSearch Dashboards**: Data visualization and analysis interface
- **NGINX**: Web proxy with SSL termination and load balancing
- **RabbitMQ**: Message broker for internal communication (used by Scirius/Celery)
- **Fluentd**: Log collection and forwarding agent
- **PostgreSQL**: Database backend for Scirius configuration and metadata

### Optional Components

- **Arkime**: Full packet capture and analysis (disabled by default)
- **Evebox**: Event and alert management interface

## Template Structure

```
data/clearndr/
├── compose.yml                    # Main Docker Compose template
├── config.yaml                    # Template configuration and defaults
├── db/                           # Database configurations
│   ├── db.compose.yaml           # Database services
│   └── db.config.yaml            # Database configuration
├── events-stack/                 # OpenSearch stack
│   ├── events-stack.compose.yaml # OpenSearch and Dashboards
│   ├── opensearch.config.yaml    # OpenSearch configuration
│   ├── Dockerfile.fluentd        # Custom Fluentd image
│   ├── Dockerfile.osd            # Custom OpenSearch Dashboards image
│   └── [configs]/                # Component-specific configs
├── nginx/                        # Web proxy configuration
│   ├── nginx.compose.yaml        # NGINX service
│   ├── nginx.config.yaml         # NGINX configuration
│   ├── nginx.conf                # NGINX main config
│   └── conf.d/                   # Virtual host configurations
├── scirius/                      # Scirius web interface
│   ├── scirius.compose.yaml      # Scirius services
│   ├── scirius.config.yaml       # Scirius configuration
│   └── [scripts]/                # Startup scripts
├── suricata/                     # Suricata IDS/IPS
│   ├── suricata.compose.yaml     # Suricata service
│   ├── suricata.config.yaml      # Suricata configuration
│   └── [configs]/                # Suricata-specific configs
└── utils/                        # Utility services
    ├── utils.compose.yaml        # Utility containers
    ├── utils.config.yaml         # Utility configuration
    └── [tools]/                  # Additional tools
```

## How It Works

### Template Processing

1. **Configuration Merge**: User values are merged with template defaults from `config.yaml`
2. **Template Rendering**: Go templates process configuration values to generate final compose files
3. **Service Orchestration**: Docker Compose uses generated files to deploy the stack

### Service Dependencies

#### Component Architecture

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│   NGINX     │◄───│   Scirius    │◄───│  RabbitMQ   │
│ (Web Proxy) │    │ (Web UI/API) │    │ (Celery)    │
└─────────────┘    └──────────────┘    └─────────────┘
                           │
                           ▼
                   ┌──────────────┐
                   │ PostgreSQL   │
                   │ (Database)   │
                   └──────────────┘
```

#### Data Pipeline & Management

```
                   ┌──────────────┐
                   │   Scirius    │────────────────┐
                   │ (Web UI/API) │  Rule Updates  │
                   └──────────────┘  & Config Mgmt │
                           │                       │
                           ▼                       ▼
                   ┌──────────────┐        ┌──────────────┐
                   │ OpenSearch   │        │   Suricata   │
                   │ (Analytics)  │        │ (IDS/IPS)    │
                   └──────────────┘        └──────────────┘
                           ▲                       │
                           │                       │
                   ┌──────────────┐                │
                   │   Fluentd    │◄───────────────┘
                   │ (Log Collect)│
                   └──────────────┘
```

### Data Flow

1. **Network Traffic** → Suricata (analysis) → Eve JSON logs
2. **Eve Logs** → Fluentd (collection) → OpenSearch (storage)
3. **OpenSearch** ← Scirius (queries/management) → Web Interface
4. **Scirius** → Suricata (rule updates and configuration management)
5. **Scirius** ↔ PostgreSQL (configuration, metadata, and application data)
6. **RabbitMQ** ↔ Scirius (Celery task queue for background processing)

## Configuration

### Key Configuration Areas

#### Network Monitoring

- `suricata.interfaces`: Network interfaces to monitor
- `suricata.additionalconfig`: Custom Suricata rules and configuration
- `suricata.unixsocket.enabled`: Enable Unix socket for real-time data

#### Data Storage

- `opensearch.datapath`: Host path for OpenSearch data persistence
- `opensearch.memory`: Memory allocation for OpenSearch
- `opensearch.ism.*`: Index lifecycle management settings

#### Web Interface

- `nginx.ssl.enabled`: Enable/disable SSL termination
- `nginx.ssl.folder`: Custom SSL certificate location
- `scirius.debug`: Enable debug mode for troubleshooting

#### Maintenance

- `cron.logrotate.*`: Automatic log rotation settings
- `cron.updatesurirules.*`: Automatic rule update configuration

## Troubleshooting

### Common Issues and Solutions

#### Services Won't Start

**Issue**: Services fail to start or crash immediately

- **Check**: `docker compose logs <service-name>`
- **Files**: `compose.yml`, service-specific `*.compose.yaml`
- **Common causes**: Port conflicts, missing directories, insufficient permissions

#### Network Interface Problems

**Issue**: Suricata can't monitor network interfaces

- **Check**: `suricata.interfaces` configuration
- **Files**: `suricata/suricata.config.yaml`, `suricata/suricata.compose.yaml`
- **Solutions**:
  - Verify interface names: `ip link show`
  - Check container network mode and privileges
  - Ensure interface is available in container

#### SSL/TLS Certificate Issues

**Issue**: NGINX SSL errors or certificate problems

- **Check**: `nginx.ssl.*` configuration
- **Files**: `nginx/nginx.conf`, `nginx/conf.d/selks6.conf`
- **Solutions**:
  - Verify certificate files exist and are readable
  - Check certificate validity: `openssl x509 -in cert.crt -text -noout`
  - Ensure proper file permissions

#### OpenSearch Memory Issues

**Issue**: OpenSearch crashes or performs poorly

- **Check**: `opensearch.memory` setting and system resources
- **Files**: `events-stack/opensearch.config.yaml`
- **Solutions**:
  - Increase memory allocation
  - Check available system RAM
  - Verify Docker memory limits

#### Data Persistence Problems

**Issue**: Data is lost after container restart

- **Check**: Volume mounts and `opensearch.datapath`
- **Files**: `events-stack/events-stack.compose.yaml`, `db/db.compose.yaml`
- **Solutions**:
  - Verify host directory exists and is writable
  - Check Docker volume permissions
  - Ensure proper user/group ownership
  - Check PostgreSQL data volume configuration

#### Database Connection Issues

**Issue**: Scirius can't connect to PostgreSQL

- **Check**: Database configuration and connectivity
- **Files**: `db/db.config.yaml`, `db/db.compose.yaml`, `scirius/scirius.config.yaml`
- **Solutions**:
  - Verify PostgreSQL service is running
  - Check database credentials and connection strings
  - Ensure database is properly initialized
  - Review network connectivity between containers

#### Rule Update Failures

**Issue**: Suricata rules aren't updating automatically

- **Check**: `cron.updatesurirules.*` configuration
- **Files**: `utils/utils.compose.yaml`, cron configuration
- **Solutions**:
  - Verify internet connectivity
  - Check rule source URLs
  - Review cron job logs

#### Performance Issues

**Issue**: High CPU/memory usage or slow response

- **Check**: Resource allocation and system metrics
- **Files**: Service-specific compose files
- **Solutions**:
  - Adjust service resource limits
  - Optimize OpenSearch settings
  - Review network interface load

### Log Locations

- **Suricata**: `/var/log/suricata/` (in container)
- **OpenSearch**: `/usr/share/opensearch/logs/` (in container)
- **Scirius**: Django logs via `docker compose logs scirius`
- **NGINX**: `/var/log/nginx/` (in container)
- **PostgreSQL**: `/var/log/postgresql/` (in container)

### Debugging Steps

1. **Check Service Status**:

   ```bash
   stamusctl compose ps
   ```

2. **View Service Logs**:

   ```bash
   stamusctl compose logs <service-name>
   ```

3. **Execute Commands in Container**:

   ```bash
   stamusctl compose exec <service-name> <command>
   ```

4. **Verify Configuration**:

   ```bash
   stamusctl config get
   ```

5. **Test Network Connectivity**:
   ```bash
   # Test from inside containers
   stamusctl compose exec scirius ping opensearch
   ```

## Development and Customization

### Modifying Templates

1. **Edit Template Files**: Modify `*.compose.yaml` and `*.config.yaml` files
2. **Test Changes**: Use `stamusctl compose init --template ./data/clearndr`
3. **Validate**: Check generated compose files for syntax errors

### Adding New Services

1. **Create Service Directory**: Add new directory under `data/clearndr/`
2. **Add Compose Template**: Create `<service>.compose.yaml`
3. **Add Configuration**: Create `<service>.config.yaml`
4. **Update Main Template**: Reference new service in `compose.yml`

### Custom Configuration

Templates support custom configuration through:

- **Environment Variables**: Set via `environment` in compose files
- **Configuration Files**: Mount custom configs via volumes
- **Additional Parameters**: Add new keys to `config.yaml`

## Best Practices

### Security

- Use strong passwords for service accounts
- Configure proper SSL certificates
- Restrict network access to necessary ports
- Regularly update container images

### Performance

- Allocate sufficient memory to OpenSearch
- Use SSD storage for OpenSearch data
- Monitor system resources during deployment
- Optimize Suricata rules for your environment

### Maintenance

- Enable automatic log rotation
- Configure regular rule updates
- Monitor disk space usage
- Backup OpenSearch data regularly

## Support

For template-specific issues:

- **Template Issues**: Report to [stamusctl-public-templates](https://github.com/StamusNetworks/stamusctl-public-templates/issues)
- **CLI Issues**: Report to [stamusctl](https://github.com/StamusNetworks/stamusctl/issues)
- **Documentation**: [https://docs.clearndr.io/](https://docs.clearndr.io/)
