# Observability Stack

Complete observability solution with logs, metrics, and traces using the Grafana ecosystem and OpenTelemetry.

## 🎯 Overview

This setup provides a full observability pipeline following the **three pillars of observability**:
- **📊 Metrics** - Mimir + Prometheus
- **📝 Logs** - Loki + Promtail  
- **🔍 Traces** - Tempo
- **🔗 Correlation** - OpenTelemetry Collector

## 🏗️ Architecture

```
Applications → OpenTelemetry Collector → Storage Backends → Grafana
```

### Components

| Component | Purpose | Port | Storage |
|-----------|---------|------|---------|
| **Grafana** | Visualization & Dashboards | 3000 | - |
| **Loki** | Log aggregation | 3100 | MinIO |
| **Tempo** | Distributed tracing | 4317/4318 | Local |
| **Mimir** | Metrics storage | 9009 | Local |
| **Prometheus** | Metrics collection | 9090 | Local |
| **OpenTelemetry** | Telemetry pipeline | 4317/4318 | - |
| **MinIO** | Object storage for Loki | 9000/9001 | Volume |

## 🚀 Quick Start

### 1. Start the Stack
```bash
cd observability/grafana-docker-compose
docker-compose up -d
```

### 2. Access Services
- **Grafana**: http://localhost:3000 (no auth required)
- **MinIO Console**: http://localhost:9001 (loki/++loki++)
- **Prometheus**: http://localhost:9090
- **Sample Apps**: 
  - FastAPI: http://localhost:3003
  - NestJS: http://localhost:3001

### 3. Generate Sample Data
```bash
# Generate traces and metrics
curl http://localhost:3003/
curl http://localhost:3001/
```

## 📊 Data Flow

### Metrics Pipeline
```
Apps → OTLP → OpenTelemetry Collector → Mimir → Grafana
Apps → Prometheus scrape → Prometheus → Grafana
```

### Logs Pipeline  
```
Apps → OTLP → OpenTelemetry Collector → Loki → Grafana
System logs → Promtail → Loki → Grafana
```

### Traces Pipeline
```
Apps → OTLP → OpenTelemetry Collector → Tempo → Grafana
```

## 🔧 Configuration

### OpenTelemetry Collector
- **Receivers**: OTLP (gRPC/HTTP), Prometheus scraping
- **Processors**: Batch processing, resource attributes
- **Exporters**: Loki, Tempo, Mimir, Prometheus format

### Sample Applications
Two pre-configured applications demonstrate observability:

**FastAPI** (Auto-instrumented):
- Automatic traces, metrics, and logs
- External service calls to NestJS
- Environment-based OTLP configuration

**NestJS** (Manual instrumentation):
- Custom OpenTelemetry setup
- Pino logger integration
- Manual trace and metric creation

## 📈 Monitoring Capabilities

### What you can observe:
- **Request latency** and throughput
- **Error rates** and status codes  
- **Service dependencies** and call graphs
- **Application logs** with trace correlation
- **Custom business metrics**

### Grafana Features:
- Pre-configured datasources
- Log-to-trace correlation
- Metric-to-trace correlation
- Explore view for ad-hoc queries

## 🛠️ Development Usage

### Send Custom Telemetry
```bash
# Send traces via OTLP
curl -X POST http://localhost:4318/v1/traces \
  -H "Content-Type: application/json" \
  -d @trace-data.json

# Send metrics via OTLP  
curl -X POST http://localhost:4318/v1/metrics \
  -H "Content-Type: application/json" \
  -d @metrics-data.json
```

### Application Integration
Point your applications to:
- **OTLP Endpoint**: `http://localhost:4317` (gRPC) or `http://localhost:4318` (HTTP)
- **Prometheus Scrape**: Configure `/metrics` endpoint

## 🔍 Troubleshooting

### Check Service Health
```bash
# OpenTelemetry Collector health
curl http://localhost:13133

# View collector metrics
curl http://localhost:8888/metrics

# Check Loki readiness
curl http://localhost:3100/ready
```

### Common Issues
- **No data in Grafana**: Check OTLP endpoints and application configuration
- **Loki storage errors**: Verify MinIO is running and accessible
- **Missing traces**: Ensure sampling is configured correctly

## 🔗 Useful Links

- [OpenTelemetry Documentation](https://opentelemetry.io/docs/)
- [Grafana Observability](https://grafana.com/docs/)
- [Loki Configuration](https://grafana.com/docs/loki/)
- [Tempo Tracing](https://grafana.com/docs/tempo/)
- [Mimir Metrics](https://grafana.com/docs/mimir/)