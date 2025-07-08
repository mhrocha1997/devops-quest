[WIP]
# DevOps Quest

The main goal of this repository is to serve as a lab for learning DevOps Engineering, and a knowledge/experience compendium.


## Load Testing
### Fortio

```sh
kubectl run -it fortio --rm --image=fortio/fortio -- \
load -qps 10 -t 120s -c 100 \
-X POST \
-payload '{"a": "b"}' \
-H "Content-Type: application/json" \
"http://app-ts-svc/exampe-k8s"
```
-qps: query per second
-c: simultaneous connections
