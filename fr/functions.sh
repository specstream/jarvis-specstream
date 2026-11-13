#!/bin/bash
pg_ss_lang () {
    case "$1" in
        no_key) echo "Ajoutez d'abord votre clé API SpecStream dans le config.sh du plugin";;
        no_query) echo "Que dois-je chercher ?";;
        no_jq) echo "Le plugin SpecStream a besoin de jq";;
        bad_key) echo "SpecStream a refusé la clé API";;
        no_credit) echo "Votre compte SpecStream n'a plus de crédit";;
        failed) echo "La recherche web a échoué";;
        nothing) echo "Je n'ai rien trouvé pour $2";;
    esac
}
