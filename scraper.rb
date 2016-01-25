#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/germany-bundestag-members-wikipedia', column: 'identifier__wikipedia_de')
EveryPolitician::Wikidata.scrape_wikidata(names: { de: names })
warn EveryPolitician::Wikidata.notify_rebuilder

