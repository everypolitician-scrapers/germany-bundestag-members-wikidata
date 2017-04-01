#!/bin/env ruby
# encoding: utf-8

require 'everypolitician'
require 'wikidata/fetcher'

sparq = 'SELECT ?item WHERE { ?item wdt:P39 wd:Q1939555 . }'
ids = EveryPolitician::Wikidata.sparql(sparq)

# existing = EveryPolitician::Index.new.country("Germany").lower_house.popolo.persons.map(&:wikidata).compact
names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/germany-bundestag-members-wikipedia', column: 'wikiname')

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { de: names }, batch_size: 100)
