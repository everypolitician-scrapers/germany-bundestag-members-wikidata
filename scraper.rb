#!/bin/env ruby
# encoding: utf-8

require 'everypolitician'
require 'wikidata/fetcher'

existing = EveryPolitician::Index.new.country("Germany").lower_house.popolo.persons.map(&:wikidata).compact

names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/germany-bundestag-members-wikipedia', column: 'wikiname')
warn "Fetching #{existing.count} ids and #{names.count} names"
EveryPolitician::Wikidata.scrape_wikidata(ids: existing, names: { de: names }, batch_size: 1000)

