# GameBench Web Dashboard Helm Chart

* Installs the GameBench web dashboard which displays session data recorded using the Android app, desktop app, GBA or SDK.

## TL;DR;

```
# Create a pv (only required if you wish to use disk file storage.)

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

# Install from Helm

helm repo add gb-helm-charts https://gb-helm-charts.storage.googleapis.com/
helm install --namespace <namespace> --version 0.27 gb-helm-charts/gamebench

# Or clone the repo and install the chart

git clone git@github.com:GameBench/web-dashboard-helm-chart.git
helm install --namespace <namespace> --version 0.27 gamebench-web-dashboard web-dashboard-helm-chart
```

## Upgrading

### v0.17 to v0.18

`application.authJwtSecret` must be specified otherwise the API pods will error.


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
| `application.authJwtSecret` | Secret key used to sign JWTs | `""` |
| `application.host` | Application host. Used to construct URLs to the application  | `""` |
| `application.port` | Application port. Used to construct URLs to the application  | `"443"` |
| `application.primaryDataStore` | Can be `es` or `postgres` | `"es"` |
| `application.urlScheme` | Application URL scheme. Used to construct URLs to the application  | `"https"` |
| `elasticsearch.host` | Elasticsearch host. Not required if `application.primaryDataStore` is `postgres` | `""` |
| `elasticsearch.pass` | Elasticsearch password. Not required if `application.primaryDataStore` is `postgres` | `""` |
| `elasticsearch.port` | Elasticsearch port. Not required if `application.primaryDataStore` is `postgres` | `""` |
| `elasticsearch.ssl` | Elasticsearch ssl. Not required if `application.primaryDataStore` is `postgres` | `""` |
| `elasticsearch.user` | Elasticsearch user. Not required if `application.primaryDataStore` is `postgres` | `""` |
| `encryptionKey` | Key used to hash Jira passwords / tokens  | `""` |
| `fileStorage.cacheType` | Can be `disk` or `redis`. Set to `redis` in order to share the cache between multiple API replicas  | `"disk"` |
| `fileStorage.type` | Can be `disk` or `gcs` | `"disk"` |
| `fileStorage.gcsBucket` | Google Cloud Storage bucket used for file storage | `""` |
| `fileStorage.gcsPathPrefix` | Path prefix for uploaded objects. Useful if the bucket contains other objects not uploaded by the system | `""` |
| `fileStorage.gcsProjectId` | Project ID for `fileStorage.gcsBucket` | `""` |
| `googleApplicationCredentials` | Base64 encoded JSON service account key | `""` |
| `image.tag` | Image tag | `v1.36.0` |
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

### Nginx ingress and 413 responses

If you're using the Nginx ingress controller and encounter 413 errors from Nginx when uploading sessions, add this annotation to your ingress annotations:

```
nginx.ingress.kubernetes.io/proxy-body-size: 4096m
```
