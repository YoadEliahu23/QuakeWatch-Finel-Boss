#!/bin/bash
apt-get update
apt-get install -y git curl
curl -sfL https://get.k3s.io | sh -
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 | bash
git clone https://github.com/YoadEliahu23/QuakeWatch-Finel-Boss.git