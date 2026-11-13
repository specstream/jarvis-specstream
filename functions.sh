#!/bin/bash
# SpecStream web search for Jarvis.
# One call of the Search API (GET /v1/web-search, up to 10 results, $0.005 a search).
# Jarvis says the answer when the search gives one, else the title and snippet of the first results.

pg_ss_api_base="${pg_ss_api_base:-https://api.specstream.ai}"

# Internal: JSON body of one search on stdout; curl's code is the return code.
pg_ss_request () { # $1: query
    curl --silent --show-error --max-time 30 --get \
        --write-out '\n%{http_code}' \
        -H @<(printf 'Authorization: Bearer %s\n' "$pg_ss_api_key") \
        -H "Accept: application/json" \
        -H "User-Agent: jarvis-specstream/1.0" \
        --data-urlencode "q=$1" \
        --data "num=5" \
        "$pg_ss_api_base/v1/web-search"
}

# Internal: the spoken text of a search answer read on stdin.
pg_ss_speech () { # $1: number of results to read when there is no answer
    jq -r --argjson n "${1:-1}" '
        .data as $d
        | if ($d.answer.value // "") != "" then $d.answer.value
          else ([($d.sources // [])[:$n][] | [.title, .snippet] | map(select(. != null and . != "")) | join(". ")] | join("\n"))
          end'
}

# Public: search the web and say the result.
pg_ss_search () { # $1: the words to search
    local query="$1"
    if [ -z "$pg_ss_api_key" ]; then
        say "$(pg_ss_lang no_key)"
        return 1
    fi
    if [ -z "$query" ]; then
        say "$(pg_ss_lang no_query)"
        return 1
    fi
    command -v jq >/dev/null || { say "$(pg_ss_lang no_jq)"; return 1; }
    local reply code body text
    reply="$(pg_ss_request "$query")" || { say "$(pg_ss_lang failed)"; return 1; }
    code="${reply##*$'\n'}"
    body="${reply%$'\n'*}"
    case "$code" in
        200) ;;
        401|403) say "$(pg_ss_lang bad_key)"; return 1;;
        402) say "$(pg_ss_lang no_credit)"; return 1;;
        *) say "$(pg_ss_lang failed)"; return 1;;
    esac
    local n="$pg_ss_results"
    [[ "$n" =~ ^[1-3]$ ]] || n=1
    text="$(printf '%s' "$body" | pg_ss_speech "$n")" || { say "$(pg_ss_lang failed)"; return 1; }
    if [ -z "$text" ]; then
        say "$(pg_ss_lang nothing "$query")"
        return 0
    fi
    say "$text"
}
