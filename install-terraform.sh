#!/usr/bin/env bash
set -e

echo "🔄 Updating package index..."
sudo apt update -y

echo "📦 Installing prerequisites..."
sudo apt install -y gnupg software-properties-common curl

echo "🔑 Adding HashiCorp GPG key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "➕ Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

echo "🔄 Updating package index (HashiCorp repo)..."
sudo apt update -y

echo "⬇️ Installing Terraform..."
sudo apt install -y terraform

echo "✅ Terraform installation complete"
terraform version
