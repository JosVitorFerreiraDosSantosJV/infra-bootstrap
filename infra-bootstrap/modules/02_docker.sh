#!/usr/bin/env bash
# ==============================================================================
# Módulo: 02_docker.sh
# Descrição: Detecta a distribuição Linux e instala o Docker Engine corretamente.
# ==============================================================================

set -euo pipefail

echo "--------------------------------------------------"
echo "[DOCKER] Verificando instalação do Docker..."
echo "--------------------------------------------------"

if command -v docker &> /dev/null; then
    echo "[DOCKER] O Docker já está instalado! Pulando etapa de instalação."
    docker --version
else
    echo "[DOCKER] Docker não encontrado. Identificando o Sistema Operacional..."

    # Carrega as variáveis do arquivo /etc/os-release
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_NAME=$ID
    else
        echo "[ERRO] Não foi possível identificar o Sistema Operacional."
        exit 1
    fi

    echo "[DOCKER] Sistema detectado: ${OS_NAME}"

    case "${OS_NAME}" in
        ubuntu|debian)
            echo "[DOCKER] Instalando via APT (Debian/Ubuntu)..."
            sudo apt-get update -y
            sudo apt-get install -y ca-certificates curl gnupg

            sudo install -m 0755 -d /etc/apt/keyrings
            sudo curl -fsSL "https://download.docker.com/linux/${OS_NAME}/gpg" -o /etc/apt/keyrings/docker.asc
            sudo chmod a+r /etc/apt/keyrings/docker.asc

            echo \
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/${OS_NAME} \
              $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
              sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

            sudo apt-get update -y
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            ;;

        centos|rhel|almalinux|rocky)
            echo "[DOCKER] Instalando via DNF/YUM (RedHat/CentOS/AlmaLinux)..."
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            ;;

        fedora)
            echo "[DOCKER] Instalando via DNF (Fedora)..."
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
            sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            ;;

        *)
            echo "[ERRO] Distribuição '${OS_NAME}' não é suportada por este script."
            exit 1
            ;;
    esac

    echo "[DOCKER] Docker instalado com sucesso!"
fi

# Garantir serviço ativo
sudo systemctl enable --now docker

# Adicionar usuário ao grupo docker
if ! groups "$USER" | grep -q "\bdocker\b"; then
    echo "[DOCKER] Adicionando o usuário '${USER}' ao grupo 'docker'..."
    sudo usermod -aG docker "$USER"
fi

echo "[DOCKER] Módulo Docker concluído!"
