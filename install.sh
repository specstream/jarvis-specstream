#!/bin/bash
# Sourced by Jarvis when the plugin is installed. The plugin needs curl and jq, which Jarvis itself uses.
command -v jq >/dev/null || jv_error "The SpecStream plugin needs jq: install it with your package manager"
