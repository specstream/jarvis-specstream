<!---
This README.md is displayed in the Jarvis Store and within the Jarvis app. Keep its sections.
-->
## Description
SpecStream: the live web data engine.

One platform to build, search, extract, enrich, map, and monitor data across the entire web.

This plugin lets Jarvis search the live web with the SpecStream Search API (`GET /v1/web-search`) and say the answer. When a search gives no short answer, Jarvis reads the title and snippet of the first results.

- $5 per 1,000 searches of up to 10 results, billed to your SpecStream account.
- Source URL and read time on every value.
- English and French commands.

Setup: install the plugin from the Jarvis Store, then put your SpecStream API key in `pg_ss_api_key` in the plugin's `config.sh`. Get a key at https://specstream.ai. The plugin needs `curl` and `jq`.

## Usage
```
You: Search the web for <your question>
Jarvis: <the answer from the live web>
```

## Author
[SpecStream](https://specstream.ai)
