# GameBench Web Dashboard Helm Chart

* Installs the GameBench web dashboard which displays session data recorded using the Android app, desktop app, GBA or SDK.

## TL;DR;

```
helm install gamebench-web-dashboard .
```

## Configuration

| Parameter  | Description | Default |
| ------------- | ------------- | -- |
| `apiTokenSecret` | Key used to hash API tokens  | `""` |
| `backend.image.repository` | Backend image repository  | `quay.io/gamebench/node-backend` |
| `backend.resources` | CPU/Memory resource requests/limits  | `{}` |
| `elasticsearch.host` | Elasticsearch host | `""` |
| `elasticsearch.pass` | Elasticsearch password | `""` |
| `elasticsearch.port` | Elasticsearch port | `""` |
| `elasticsearch.ssl` | Elasticsearch ssl | `""` |
| `elasticsearch.user` | Elasticsearch user | `""` |
| `encryptionKey` | Key used to hash Jira passwords / tokens  | `""` |
| `frontend.image.repository` | Frontend image repository  | `quay.io/gamebench/ang4-frontend` |
| `frontend.resources` | CPU/Memory resource requests/limits  | `{}` |
| `image.tag` | Image tag | `v1.17.0` |
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
| `smtp.from` | SMTP from | `""` |
| `smtp.host` | SMTP host | `""` |
| `smtp.pass` | SMTP pass | `""` |
| `smtp.port` | SMTP port | `""` |
| `smtp.tls` | SMTP TLS | `""` |
| `smtp.user` | SMTP user | `""` |
