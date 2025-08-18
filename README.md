# DevOps Quest

A comprehensive lab environment for learning and experimenting with DevOps engineering practices, tools, and methodologies.

## 🎯 Objective

This repository serves as a hands-on learning platform covering:
- **Container Orchestration** with Kubernetes
- **Infrastructure as Code** with Terraform and Vagrant
- **Observability** with OpenTelemetry, Grafana Stack
- **Application Development** with modern frameworks
- **CI/CD Pipelines** and automation
- **Performance Testing** and monitoring

## 📁 Project Structure

### 🏗️ Infrastructure & Clusters
- **[cluster-config/](cluster-config/)** - Kubernetes cluster configurations
  - **[vagrant/](cluster-config/vagrant/)** - Local K3s cluster with Vagrant/VirtualBox
  - Storage classes, metrics server, and cluster resources

- **[terraform/](terraform/)** - AWS infrastructure as code
  - ECR repositories, IAM roles, and cloud resources

### 📊 Observability Stack
- **[observability/](observability/)** - Complete monitoring and logging setup
  - **[grafana-docker-compose/](observability/grafana-docker-compose/)** - Grafana, Loki, Tempo, Mimir, OpenTelemetry Collector
  - Full observability pipeline for logs, metrics, and traces

### 🚀 Simple Example Applications
- **[simple-example-apps/](simple-example-apps/)** - Sample applications with observability
  - **[app-nestjs/](simple-example-apps/app-nestjs/)** - NestJS API with OpenTelemetry integration
  - **[app-fastapi/](simple-example-apps/app-fastapi/)** - FastAPI application
  - **[kafka-producer/](simple-example-apps/kafka-producer/)** - Kafka message producer
  - **[kafka-consumer/](simple-example-apps/kafka-consumer/)** - Kafka message consumer

### 🏢 Production Projects
- **[projects/](projects/)** - Real-world application examples
  - **[accounts-api/](projects/accounts-api/)** - Account management API
  - **[accounts-db-postgres/](projects/accounts-db-postgres/)** - PostgreSQL database setup

### ⚙️ CI/CD
- **[.github/workflows/](.github/workflows/)** - GitHub Actions pipelines

## 🚀 Quick Start

### 1. Local Kubernetes Cluster
```bash
cd cluster-config/vagrant
vagrant up
kubectl get nodes
```

### 2. Observability Stack
```bash
cd observability/grafana-docker-compose
docker-compose up -d
# Access Grafana at http://localhost:3000
```

### 3. Deploy Sample Application
```bash
cd simple-example-apps/app-nestjs
kubectl apply -f k8s/
```

## 🧪 Load Testing

### Fortio
```bash
kubectl run -it fortio --rm --image=fortio/fortio -- \
load -qps 10 -t 120s -c 100 \
-X POST \
-payload '{"a": "b"}' \
-H "Content-Type: application/json" \
"http://app-ts-svc/example-k8s"
```

## 🗺️ Roadmap

### Phase 1: Foundation ✅
- [x] Local K3s cluster with Vagrant
- [x] Basic observability stack (Grafana, Loki, Tempo, Mimir)
- [x] OpenTelemetry integration
- [x] Sample NestJS application
- [x] Sample Python FastAPI application
- [x] Load Testing with Fortio

### Phase 2: CI/CD, GitOps and Quality Gates 🚧
- [ ] Helm charts for applications
- [ ] GitOps with ArgoCD
- [ ] SonarQube integration
- [ ] Code quality gates
- [ ] Automated testing in pipelines
- [ ] Multi-stage deployments

### Phase 3: Advanced Observability 🚧
- [ ] Advanced Grafana dashboards
- [ ] Alert manager configuration
- [ ] SLI/SLO monitoring
- [ ] Distributed tracing analysis

### Phase 4: Testing & Quality Assurance 📋
- [ ] Complete load testing with k6 or Locust
- [ ] Performance and regression tests
- [ ] E2E tests with Cypress, Selenium
- [ ] Contract testing with Pact
- [ ] Chaos engineering with Chaos Monkey
- [ ] Security testing (OWASP ZAP)

### Phase 5: API Gateway & Service Mesh 📋
- [ ] Kong API Gateway
- [ ] Rate limiting and throttling
- [ ] API versioning strategies
- [ ] Service discovery
- [ ] Circuit breakers and resilience patterns
- [ ] Service mesh with Istio
- [ ] API documentation with Swagger/OpenAPI

### Phase 6: Infrastructure Automation 📋
- [ ] Terraform modules for AWS EKS
- [ ] Infrastructure testing with Terratest
- [ ] Multi-environment setup (dev/staging/prod)
- [ ] Configuration management with Ansible
- [ ] Infrastructure as Code best practices
- [ ] Cost optimization and monitoring

### Phase 7: Security & Compliance 📋
- [ ] Pod Security Standards
- [ ] Network policies and segmentation
- [ ] Policy enforcement with Kyverno
- [ ] Secret management with External Secrets or Vault
- [ ] Security scanning in CI/CD (Snyk)
- [ ] Compliance monitoring and reporting
- [ ] Self-hosted VPN with WireGuard
- [ ] RBAC and identity management

### Phase 8: Deployment Strategies 📋
- [ ] Blue-Green deployments
- [ ] Canary deployments with Flagger
- [ ] Rolling updates strategies
- [ ] Feature flags with Unleash/Flagsmith
- [ ] A/B testing infrastructure
- [ ] Rollback strategies and automation

### Phase 9: Advanced Patterns & Architecture 📋
- [ ] Event-driven architecture with Kafka
- [ ] Microservices communication patterns
- [ ] CQRS and Event Sourcing
- [ ] Saga pattern for distributed transactions
- [ ] Performance optimization techniques
- [ ] Caching strategies (Redis, CDN)

### Phase 10: ML/AI Operations 📋
- [ ] Airflow for workflow orchestration
- [ ] MLOps pipeline with MLflow
- [ ] Model serving with KServe
- [ ] Feature stores (Feast)
- [ ] ML monitoring and drift detection
- [ ] AutoML and model versioning
- [ ] GPU workloads on Kubernetes



## 🤝 Contributing

This is a learning repository. Feel free to:
- Add new examples and experiments
- Improve existing configurations
- Share knowledge through documentation
- Report issues and suggest improvements

## 📚 Learning Resources

Each subdirectory contains its own README with specific implementation details, setup instructions, and learning objectives.

## 🎯 Learning Path Recommendations

**Beginner**: Phases 1-3 (Foundation → CI/CD → Observability)  
**Intermediate**: Phases 4-6 (Testing → API Gateway → Infrastructure)  
**Advanced**: Phases 7-10 (Security → Deployment → Patterns → MLOps)