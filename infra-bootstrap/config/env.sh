#!/usr/bin/env bash
# ==============================================================================
# Arquivo: config/env.sh
# Descrição: Variáveis de ambiente e parâmetros globais do projeto.
# ==============================================================================

# --- Configurações Gerais ---
APP_ENV="development" # development | production

# --- Configurações do Módulo de Segurança ---
SSH_PORT="22"
ENABLE_FIREWALL=true

# --- Configurações do Módulo Docker ---
ENABLE_DOCKER=true
ADD_USER_TO_DOCKER=true
TARGET_USER="${USER:-jose}"
