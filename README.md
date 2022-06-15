# NSQ

NSQ is a realtime distributed messaging platform designed to operate at scale, handling billions of messages per day.

## TL;DR

```sh
helm repo add nsqio https://nsqio.github.io/helm-chart
helm install my-release nsqio/nsq
```

## Values

The following table lists the configurable parameters of the nsq chart and their default values.

### common

| Value            | Description                                      | Default                |
|------------------|--------------------------------------------------|------------------------|
| fullnameOverride | String to partially override nsq.fullname        | `Chart name`           |
| image.repository | NSQ image repository                             | `nsqio/nsq`            |
| image.tag        | NSQ image tag                                    | `v{.Chart.AppVersion}` |
| image.pullPolicy | Image pull policy                                | `IfNotPresent`         |
| imagePullSecrets | Specify docker-registry secret names as an array | `[]`                   |

### nsqlookupd

| Value                          | Description                                                                          | Default                    |
|--------------------------------|--------------------------------------------------------------------------------------|----------------------------|
| nsqlookupd.enabled             | Enable the nsqlookupd                                                                | `true`                     |
| nsqlookupd.fullnameOverride    | String to partially override nsq.nsqlookupd.fullname                                 | `.Release.Name-nsqlookupd` |
| nsqlookupd.replicaCount        | Number of nsqlookupd replicas                                                        | `3`                        |
| nsqlookupd.priorityClassName   | The name of the kube priority class used. Defaults to global default.                | `nil`                      |
| nsqlookupd.extraArgs           | Extra arguments to provide to the `nsqlookupd` command                               | `[]`                       |
| nsqlookupd.podManagementPolicy | The pod management policy of the StatefulSet                                         | `Parallel`                 |
| nsqlookupd.podAnnotations      | The annotations to attach to the nsqlookupd pods                                     | `{}`                       |
| nsqlookupd.podSecurityContext  | The security context to attach to the nsqlookupd pods                                | `{}`                       |
| nsqlookupd.resources           | The resources to allocate to the nsqlookupd pods                                     | `{}`                       |
| nsqlookupd.serviceAccountName  | The name of the service account used. Defaults to namespace default service account. | `nil`                      |
| nsqlookupd.nodeSelector        | The tags that will be used to select the node on which the pods should be scheduled  | `{}`                       |
| nsqlookupd.tolerations         | Tolerations for pod assignment                                                       | `[]`                       |
| nsqlookupd.affinity            | Affinity for pod assignment                                                          | `[]`                       |

### nsqadmin

| Value                        | Description                                                                          | Default                  |
|------------------------------|--------------------------------------------------------------------------------------|--------------------------|
| nsqadmin.enabled             | Enable the nsqadmin                                                                  | `true`                   |
| nsqadmin.fullnameOverride    | String to partially override nsq.nsqadmin.fullname                                   | `.Release.Name-nsqadmin` |
| nsqadmin.replicaCount        | Number of nsqadmin replicas                                                          | `1`                      |
| nsqadmin.priorityClassName   | The name of the kube priority class used. Defaults to global default.                | `nil`                    |
| nsqadmin.extraArgs           | Extra arguments to provide to the `nsqadmin` command                                 | `[]`                     |
| nsqadmin.service.type        | The nsqadmin service type                                                            | `ClusterIP`              |
| nsqadmin.service.port        | The nsqadmin service port                                                            | `4171`                   |
| nsqadmin.service.nodePort    | The nsqadmin service node port                                                       | `nil`                    |
| nsqadmin.ingress.enabled     | Enable the nsqadmin ingress                                                          | `false`                  |
| nsqadmin.ingress.host        | Host of the nsqadmin ingress                                                         | `nil`                    |
| nsqadmin.ingress.annotations | The annotations to attach to the ingress                                             | `{}`                     |
| nsqadmin.ingress.tls         | TLS configurations for the hostname                                                  | `[]`                     |
| nsqadmin.podAnnotations      | The annotations to attach to the nsqadmin pods                                       | `{}`                     |
| nsqadmin.podSecurityContext  | The security context to attach to the nsqadmin pods                                  | `{}`                     |
| nsqadmin.resources           | The resources to allocate to the nsqadmin pods                                       | `{}`                     |
| nsqadmin.serviceAccountName  | The name of the service account used. Defaults to namespace default service account. | `nil`                    |
| nsqadmin.nodeSelector        | The tags that will be used to select the node on which the pods should be scheduled  | `{}`                     |
| nsqadmin.tolerations         | Tolerations for pod assignment                                                       | `[]`                     |
| nsqadmin.affinity            | Affinity for pod assignment                                                          | `[]`                     |

### nsqd

| Value                   | Description                                                                          | Default              |
|-------------------------|--------------------------------------------------------------------------------------|----------------------|
| nsqd.enabled            | Enable the nsqd                                                                      | `true`               |
| nsqd.fullnameOverride   | String to partially override nsq.nsqd.fullname                                       | `.Release.Name-nsqd` |
| nsqd.replicaCount       | Number of nsqd replicas                                                              | `3`                  |
| nsqd.priorityClassName  | The name of the kube priority class used. Defaults to global default.                | `nil`                |
| nsqd.extraArgs          | Extra arguments to provide to the `nsqd` command                                     | `[]`                 |
| nsqd.service.type       | The nsqd service type                                                                | `ClusterIP`          |
| nsqd.service.annotations| Provide any additional annotations that may be required                              | `{}`                 |
| nsqd.podAnnotations     | The annotations to attach to the nsqd pods                                           | `{}`                 |
| nsqd.podSecurityContext | The security context to attach to the nsqd pods                                      | `{}`                 |
| nsqd.resources          | The resources to allocate to the nsqd pods                                           | `{}`                 |
| nsqd.serviceAccountName | The name of the service account used. Defaults to namespace default service account. | `nil`                |
| nsqd.nodeSelector       | The tags that will be used to select the node on which the pods should be scheduled  | `{}`                 |
| nsqd.tolerations        | Tolerations for pod assignment                                                       | `[]`                 |
| nsqd.affinity           | Affinity for pod assignment                                                          | `[]`                 |

### Metrics parameters

| Name                                         | Description                                                                                                           | Value                      |
| -------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| `metrics.enabled`                            | Enable using a sidecar Prometheus exporter                                                                            | `false`                    |
| `metrics.image.registry`                     | Nsq(&reg;) Prometheus exporter image registry                                                                         | `docker.io`                |
| `metrics.image.repository`                   | Nsq(&reg;) Prometheus exporter image repository                                                                       | `lovoo/nsq_exporter`       |
| `metrics.image.tag`                          | Nsq(&reg;) Prometheus exporter image tag (immutable tags are recommended)                                             | `2.0.2`                    |
| `metrics.image.pullPolicy`                   | Nsq(&reg;) Prometheus exporter image pull policy                                                                      | `IfNotPresent`             |
| `metrics.image.pullSecrets`                  | Specify docker-registry secret names as an array                                                                      | `[]`                       |
| `metrics.args`                               | Override default container args (useful when using custom images)                                                     | `[]`                       |
| `metrics.resources.limits`                   | The resources limits for Prometheus exporter containers                                                               | `{}`                       |
| `metrics.resources.requests`                 | The requested resources for Prometheus exporter containers                                                            | `{}`                       |
| `metrics.containerPort`                      | Port of the Prometheus metrics container                                                                              | `9216`                     |
| `metrics.service.annotations`                | Annotations for Prometheus Exporter pods. Evaluated as a template.                                                    | `{}`                       |
| `metrics.service.type`                       | Type of the Prometheus metrics service                                                                                | `ClusterIP`                |
| `metrics.service.ports.metrics`              | Port of the Prometheus metrics service                                                                                | `9216`                     |
| `metrics.service.extraPorts`                 | Extra ports to expose (normally used with the `sidecar` value)                                                        | `[]`                       |
| `metrics.livenessProbe.enabled`              | Enable livenessProbe                                                                                                  | `true`                     |
| `metrics.livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe                                                                               | `15`                       |
| `metrics.livenessProbe.periodSeconds`        | Period seconds for livenessProbe                                                                                      | `5`                        |
| `metrics.livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe                                                                                     | `5`                        |
| `metrics.livenessProbe.failureThreshold`     | Failure threshold for livenessProbe                                                                                   | `3`                        |
| `metrics.livenessProbe.successThreshold`     | Success threshold for livenessProbe                                                                                   | `1`                        |
| `metrics.readinessProbe.enabled`             | Enable readinessProbe                                                                                                 | `true`                     |
| `metrics.readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe                                                                              | `5`                        |
| `metrics.readinessProbe.periodSeconds`       | Period seconds for readinessProbe                                                                                     | `5`                        |
| `metrics.readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe                                                                                    | `1`                        |
| `metrics.readinessProbe.failureThreshold`    | Failure threshold for readinessProbe                                                                                  | `3`                        |
| `metrics.readinessProbe.successThreshold`    | Success threshold for readinessProbe                                                                                  | `1`                        |
| `metrics.startupProbe.enabled`               | Enable startupProbe                                                                                                   | `false`                    |
| `metrics.startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe                                                                                | `5`                        |
| `metrics.startupProbe.periodSeconds`         | Period seconds for startupProbe                                                                                       | `10`                       |
| `metrics.startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe                                                                                      | `5`                        |
| `metrics.startupProbe.failureThreshold`      | Failure threshold for startupProbe                                                                                    | `30`                       |
| `metrics.startupProbe.successThreshold`      | Success threshold for startupProbe                                                                                    | `1`                        |
| `metrics.serviceMonitor.enabled`             | Create ServiceMonitor Resource for scraping metrics using Prometheus Operator                                         | `false`                    |
| `metrics.serviceMonitor.namespace`           | Namespace which Prometheus is running in                                                                              | `""`                       |
| `metrics.serviceMonitor.interval`            | Interval at which metrics should be scraped                                                                           | `30s`                      |
| `metrics.serviceMonitor.scrapeTimeout`       | Specify the timeout after which the scrape is ended                                                                   | `""`                       |
| `metrics.serviceMonitor.relabelings`         | RelabelConfigs to apply to samples before scraping.                                                                   | `[]`                       |
| `metrics.serviceMonitor.metricRelabelings`   | MetricsRelabelConfigs to apply to samples before ingestion.                                                           | `[]`                       |
| `metrics.serviceMonitor.labels`              | Used to pass Labels that are used by the Prometheus installed in your cluster to select Service Monitors to work with | `{}`                       |
| `metrics.serviceMonitor.selector`            | Prometheus instance selector labels                                                                                   | `{}`                       |
| `metrics.serviceMonitor.honorLabels`         | Specify honorLabels parameter to add the scrape endpoint                                                              | `false`                    |
| `metrics.serviceMonitor.jobLabel`            | The name of the label on the target service to use as the job name in prometheus.                                     | `""`                       |
