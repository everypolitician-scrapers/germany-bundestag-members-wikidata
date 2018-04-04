#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

sparq = 'SELECT ?item WHERE { ?item p:P39/ps:P39 wd:Q1939555 . }'
ids = EveryPolitician::Wikidata.sparql(sparq)

names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/germany-bundestag-members-wikipedia', column: 'wikiname')

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { de: names }, batch_size: 100)
