# GameBench Web Dashboard Helm Chart

* Installs the GameBench web dashboard which displays session data recorded using the Android app, desktop app, GBA or SDK.

## TL;DR;

```
# Create a pv

# Example pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv-gamebench
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  nfs:
    path: /export/data
    server: 10.154.15.198

kubectl apply -f pv.yaml

# Create namespace
kubectl create ns <namespace>

# Grab chart
git clone git@github.com:GameBench/web-dashboard-helm-chart.git

helm install --namespace <namespace> gamebench-web-dashboard web-dashboard-helm-chart
```

## Configuration

| Parameter  | Description | Default |
| ------------- | ------------- | -- |
| `api.image.repository` | API image repository  | `quay.io/gamebench/node-backend` |
| `api.livenessProbe` | API liveness probe  | `{"httpGet":{"path":"/v1/health","port":5000},"initialDelaySeconds":60,"periodSeconds":30}` |
| `api.resources` | CPU/Memory resource requests/limits  | `{}` |
| `apiTokenSecret` | Key used to hash API tokens  | `""` |
| `application.host` | Application host. Used to construct URLs to the application  | `""` |
| `application.port` | Application port. Used to construct URLs to the application  | `""` |
| `application.urlScheme` | Application URL scheme. Used to construct URLs to the application  | `"https"` |
| `elasticsearch.host` | Elasticsearch host | `""` |
| `elasticsearch.pass` | Elasticsearch password | `""` |
| `elasticsearch.port` | Elasticsearch port | `""` |
| `elasticsearch.ssl` | Elasticsearch ssl | `""` |
| `elasticsearch.user` | Elasticsearch user | `""` |
| `encryptionKey` | Key used to hash Jira passwords / tokens  | `""` |
| `image.tag` | Image tag | `v1.18.1` |
| `ingress.annotations` | | `{}` |
| `ingress.enabled` | | `false` |
| `ingress.hosts` | Array of hosts | `[]` |
| `license.contents` | `gamebench-license` from the license zip as a string with double quotes escaped  | `""` |
| `license.signature` | `gamebench-license.RSA-SHA256` from the license zip base64 encoded  | `""` |
| `logLevel` |  | `info` |
| `postgres.database` | Postgres database | `"gamebench"` |
| `postgres.host` | Postgres host | `""` |
| `postgres.password` | Postgres password | `""` |
| `postgres.port` | Postgres port | `"5432"` |
| `postgres.username` | Postgres username | `""` |
| `redis.auth` | Redis auth | `""` |
| `redis.host` | Redis host | `""` |
| `redis.port` | Redis port | `"6379"` |
| `setupPassword` | `/setup` password | `""` |
| `smtp.from` | SMTP from | `""` |
| `smtp.host` | SMTP host | `""` |
| `smtp.pass` | SMTP pass | `""` |
| `smtp.port` | SMTP port | `""` |
| `smtp.tls` | SMTP TLS | `"false"` |
| `smtp.user` | SMTP user | `""` |
| `ui.image.repository` | Frontend image repository  | `quay.io/gamebench/ang4-frontend` |
| `ui.resources` | CPU/Memory resource requests/limits  | `{}` |
| `worker.resources` | CPU/Memory resource requests/limits  | `{}` |

## Troubleshooting

### Nginx ingress and 418 responses

If you're using the Nginx ingress controller and encounter 418 errors from Nginx when uploading sessions, add this annotation to your ingress annotations:

```
nginx.ingress.kubernetes.io/proxy-body-size: 4096m
```
