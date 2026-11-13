#!/bin/bash
pg_ss_lang () {
    case "$1" in
        no_key) echo "Add your SpecStream API key in the plugin's config.sh first";;
        no_query) echo "What should I search for?";;
        no_jq) echo "The SpecStream plugin needs jq";;
        bad_key) echo "SpecStream refused the API key";;
        no_credit) echo "Your SpecStream account has no credit left";;
        failed) echo "The web search failed";;
        nothing) echo "I found nothing for $2";;
    esac
}
