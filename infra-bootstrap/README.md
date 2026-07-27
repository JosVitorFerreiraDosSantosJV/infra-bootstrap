# 🚀 Infra Bootstrap - Automação e Provisionamento Linux

![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Debian/Ubuntu](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

Projeto de automação em **Shell Script (Bash)** para inicialização, hardening de segurança e preparação do ambiente de execução (Docker) em servidores baseados em Debian/Ubuntu.

---

## 📌 O que foi feito (Features Implementadas)

### 🧱 Arquitetura e Estrutura Modular
- **Script Orquestrador (`bootstrap.sh`):** Ponto de entrada centralizado que gerencia a sequência de execução e garante o modo estrito de erros (`set -euo pipefail`).
- **Módulos Isolados (`modules/`):** Separação de responsabilidades em scripts independentes (`01_security.sh`, `02_docker.sh`).
- **Mecanismo de Logs Automatizado (`logs/`):** Redirecionamento de `stdout` e `stderr` para geração de logs em tempo de execução sem poluir o repositório (`.gitignore`).

### 🛡️ Segurança (Módulo 01)
- Instalação e configuração do **UFW (Uncomplicated Firewall)**.
- Liberação dinâmica de portas críticas (ex: SSH).
- Habilitação automática do firewall garantindo acesso persistente.

### 🐳 Containerização (Módulo 02)
- Instalação automatizada do **Docker Engine** e **Docker Compose**.
- Suporte a múltiplas distribuições (detecção automática de repositórios oficiais para Debian/Ubuntu).
- Inclusão idempotente do usuário do sistema no grupo `docker` (permitindo uso sem `sudo`).

### ⚙️ Parametrização Centralizada (Fase 4)
- **Arquivo de Configuração (`config/env.sh`):** Controle total sobre as variáveis do ambiente sem alteração no código-fonte.
- **Flags de Execução:** Ativação/desativação condicional de módulos (`ENABLE_FIREWALL`, `ENABLE_DOCKER`).
- **Valores Padrão e Fallbacks:** Proteção contra variáveis nulas usando expressões do Bash como `${SSH_PORT:-22}`.

### 🔄 Idempotência Total
- Todos os comandos e instalações foram projetados para serem executados múltiplas vezes no mesmo servidor **sem quebrar** ou alterar estado indesejado.

---

## 🛠️ Estrutura do Repositório

```text
infra-bootstrap/
├── config/
│   └── env.sh            # Variáveis de ambiente e flags de módulos
├── modules/
│   ├── 01_security.sh    # Módulo de Firewall (UFW) e SSH
│   └── 02_docker.sh      # Módulo de instalação do Docker/Compose
├── logs/                 # Diretório de execução de logs (ignorado no Git)
├── .gitignore            # Filtro de arquivos temporários e logs
├── bootstrap.sh          # Script orquestrador principal
└── README.md             # Documentação do projeto
