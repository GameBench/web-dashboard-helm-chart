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
| `api.image.pullSecrets` | Array of kubernetes pull secret names | `[]` |
| `api.livenessProbe` | API liveness probe  | `{"httpGet":{"path":"/v1/health","port":5000},"initialDelaySeconds":60,"periodSeconds":30}` |
| `api.readinessProbe` | API readiness probe  | `{"httpGet":{"path":"/v1/info/version","port":5000},"initialDelaySeconds":60,"periodSeconds":30}` |
| `api.replicas` | | `1` |
| `api.resources` | CPU/Memory resource requests/limits  | `{}` |
| `api.service.type` | API Service Type | `"ClusterIP"` | 
| `apiTokenSecret` | Key used to hash API tokens  | `""` |
| `application.host` | Application host. Used to construct URLs to the application  | `""` |
| `application.port` | Application port. Used to construct URLs to the application  | `"443"` |
| `application.urlScheme` | Application URL scheme. Used to construct URLs to the application  | `"https"` |
| `elasticsearch.host` | Elasticsearch host | `""` |
| `elasticsearch.pass` | Elasticsearch password | `""` |
| `elasticsearch.port` | Elasticsearch port | `""` |
| `elasticsearch.ssl` | Elasticsearch ssl | `""` |
| `elasticsearch.user` | Elasticsearch user | `""` |
| `encryptionKey` | Key used to hash Jira passwords / tokens  | `""` |
| `fileStorage.cacheType` | Can be `disk` or `redis`. Set to `redis` in order to share the cache between multiple API replicas  | `"disk"` |
| `fileStorage.type` | Can be `disk` or `gcs` | `"disk"` |
| `fileStorage.gcsBucket` | Google Cloud Storage bucket used for file storage | `""` |
| `fileStorage.gcsPathPrefix` | Path prefix for uploaded objects. Useful if the bucket contains other objects not uploaded by the system | `""` |
| `fileStorage.gcsProjectId` | Project ID for `fileStorage.gcsBucket` | `""` |
| `googleApplicationCredentials` | Base64 encoded JSON service account key | `""` |
| `image.tag` | Image tag | `v1.23.1` |
| `ingress.annotations` | | `{}` |
| `ingress.enabled` | | `false` |
| `ingress.hosts` | Array of hosts | `[]` |
| `license.contents` | `gamebench-license` from the license zip base64 encoded | `""` |
| `license.signature` | `gamebench-license.RSA-SHA256` from the license zip base64 encoded  | `""` |
| `logLevel` |  | `info` |
| `persistence.enabled` | Set to `false` if you do not wish to use a PVC. Can be used in conjuction with `fileStorage.type` `gcs` | `true` |
| `persistence.existingClaim` | Name of existing PVC. If left empty and `persistence.enabled` is `true`, a PVC will be created | `""` |
| `persistence.storageClass` | Persistent Disk Storage Class | `""` |
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
| `ui.image.pullSecrets` | Array of kubernetes pull secret names | `[]` |
| `ui.replicas` | | `1` |
| `ui.resources` | CPU/Memory resource requests/limits  | `{}` |
| `ui.service.type` | UI Service Type | `"ClusterIP"` |
| `worker.replicas` | | `1` |
| `worker.resources` | CPU/Memory resource requests/limits  | `{}` |

## Troubleshooting

### Nginx ingress and 418 responses

If you're using the Nginx ingress controller and encounter 418 errors from Nginx when uploading sessions, add this annotation to your ingress annotations:

```
nginx.ingress.kubernetes.io/proxy-body-size: 4096m
```
