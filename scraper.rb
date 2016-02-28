#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/germany-bundestag-members-wikipedia', column: 'identifier__wikipedia_de')
names.each_slice(50) do |sliced|
  EveryPolitician::Wikidata.scrape_wikidata(names: { de: sliced })
end

