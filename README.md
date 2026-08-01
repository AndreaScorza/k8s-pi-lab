# k8s-pi-lab

Infrastructure for a Kubernetes home lab running on a single Raspberry Pi (k3s).

## Architecture

This repo is split into two layers that run in sequence, because Terraform's
`helm`/`kubernetes` providers only operate on a cluster that already exists
(via `~/.kube/config`) — they have no notion of the machine the cluster runs
on.

1. **`ansible/`** — bootstraps the k3s node itself, before a cluster exists.
   Installs k3s and keeps its bundled Traefik ingress controller disabled.
   Nothing in this cluster uses Traefik (no `Ingress`/`IngressRoute`
   resources), but its `LoadBalancer` service DNATs *all* inbound traffic on
   host ports 80/443 to itself via iptables, which silently broke Caddy
   (also running on this Pi, fronting `redacted.duckdns.org` /
   `redacted.duckdns.org`) until it was disabled.
2. **`terraform/`** — manages in-cluster resources once a kubeconfig exists:
   Helm releases for observability (`kube-prometheus-stack`, `loki`,
   `alloy`).

## Usage

### 1. Bootstrap k3s

Run once on a fresh Pi, or any time k3s needs to be reinstalled. Executed
from another machine on the same network with SSH access to the Pi and a
sudo-capable user:

```bash
ansible-playbook -i ansible/inventory.ini ansible/k3s.yml
```

### 2. Deploy cluster resources

```bash
cd terraform
terraform init
terraform apply
```
