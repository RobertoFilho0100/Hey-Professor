#!/bin/bash

# Cores para mensagens
NC='\033[0m'
BRed='\033[1;31m'

# Regex para capturar o identificador da branch
REGEX_ISSUE_ID="[A-Z]+-[0-9]+"
BRANCH_NAME=$(git symbolic-ref --short HEAD)
ISSUE_ID=$(echo "$BRANCH_NAME" | grep -o -E "$REGEX_ISSUE_ID")
COMMIT_MESSAGE=$(cat "$1")

# Valida se o identificador foi encontrado
if [ -z "$ISSUE_ID" ]; then
    echo -e "${BRed}A branch não está no padrão esperado. Use algo como 'feature/HEY-2-descricao'.${NC}"
    exit 1
fi

# Evita duplicar o prefixo
if [[ $COMMIT_MESSAGE == $ISSUE_ID* ]]; then
    exit 0
fi

# Prefixa o identificador na mensagem do commit
echo "$ISSUE_ID: $COMMIT_MESSAGE" > "$1"
