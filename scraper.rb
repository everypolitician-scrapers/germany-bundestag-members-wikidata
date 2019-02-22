#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

sparq = 'SELECT ?item WHERE { ?item p:P39/ps:P39 wd:Q1939555 . }'
ids = EveryPolitician::Wikidata.sparql(sparq)

wpde = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/germany-bundestag-members-wikipedia', column: 'wikidata')

EveryPolitician::Wikidata.scrape_wikidata(ids: ids | wpde, batch_size: 100)
