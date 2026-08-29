#!/usr/bin/env bash
# Retorna o número do workspace ativo em JSON, para o módulo custom/workspace.
# Disparado uma vez no início ("interval": "once") e atualizado via sinal
# (RTMIN+9), enviado pelo workspace-watch.sh sempre que o workspace muda.

ws=$(hyprctl activeworkspace -j | jq -r '.id')

printf '{"text":"%s","tooltip":"Workspace %s"}\n' "$ws" "$ws"
