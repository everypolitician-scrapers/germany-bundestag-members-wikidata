#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/germany-bundestag-members-wikipedia', column: 'wikiname')
EveryPolitician::Wikidata.scrape_wikidata(names: { de: sliced }, batch_size: 100)

