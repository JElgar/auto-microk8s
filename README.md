# auto-microk8s

## Getting started

```bash
terraform init
terraform apply -var="hcloud_token=<YOUR_HETZNER_TOKEN>" terraform
```

## Destroy

```bash
terraform destroy -var="hcloud_token=<YOUR_HETZNER_TOKEN>" terraform
```
