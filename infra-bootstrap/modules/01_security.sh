#!/usr/bin/env bash
# ==============================================================================
# Módulo: 01_security.sh
# Descrição: Atualiza os pacotes do sistema e configura o firewall básico (UFW).
# ==============================================================================

set -euo pipefail

echo "--------------------------------------------------"
echo "[SEGURANÇA] Iniciando hardening básico do sistema..."
echo "--------------------------------------------------"

# 1. Atualizar a lista de pacotes
echo "[SEGURANÇA] Atualizando repositórios de pacotes (apt update)..."
sudo apt-get update -y

# 2. Instalar o UFW (Uncomplicated Firewall) se não estiver instalado
if ! command -v ufw &> /dev/null; then
    echo "[SEGURANÇA] Instalando o firewall UFW..."
    sudo apt-get install -y ufw
else
    echo "[SEGURANÇA] UFW já está instalado."
fi

# 3. Configurar regras do Firewall (Idempotente)
echo "[SEGURANÇA] Configurando regras de firewall..."
# Permite conexão na porta 22 (SSH) para não fechar seu acesso ao PuTTY!
sudo ufw allow 22/tcp comment 'Acesso SSH'

# Habilita o UFW sem pedir confirmação interativa
sudo ufw --force enable

echo "[SEGURANÇA] Status do Firewall:"
sudo ufw status verbose

echo "[SEGURANÇA] Módulo de segurança concluído com sucesso!"
