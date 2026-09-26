#!/usr/bin/env bash
h="$1"
out=$(curl -skI --max-time 8 "https://$h/" 2>/dev/null)
code=$(printf '%s' "$out" | awk 'NR==1{print $2}')
srv=$(printf '%s' "$out" | awk -F': ' 'tolower($1)=="server"{v=$2} END{print v}' | tr -d '\r')
loc=$(printf '%s' "$out" | awk -F': ' 'tolower($1)=="location"{v=$2} END{print v}' | tr -d '\r')
printf "%s\t%s\t%s\t%s\n" "${code:-000}" "$h" "${srv:-?}" "${loc:-}"
