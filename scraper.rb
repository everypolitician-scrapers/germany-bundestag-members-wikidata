#!/bin/env ruby
# encoding: utf-8

require 'json'
require 'pry'
require 'rest-client'
require 'scraperwiki'
require 'wikidata/fetcher'
require 'mediawiki_api'


def candidates
  morph_api_url = 'https://api.morph.io/tmtmtmtm/germany-bundestag-members-wikipedia/data.json'
  morph_api_key = ENV["MORPH_API_KEY"]
  result = RestClient.get morph_api_url, params: {
    key: morph_api_key,
    query: "select DISTINCT(identifier__wikipedia_de) as wikiname from data"
  }
  JSON.parse(result, symbolize_names: true)
end

def wikidata_ids(names)
  client = MediawikiApi::Client.new "https://de.wikipedia.org/w/api.php"
  res = names.each_slice(50).map { |sliced|
    page_args = { 
      prop: 'pageprops',
      ppprop: 'wikibase_item',
      titles: sliced.join("|"),
      token_type: false,
    }
    response = client.action :query, page_args 
    response.data['pages'].find_all { |p| p.last.key? 'pageprops' }.map { |p| 
      [ p.last['title'], p.last['pageprops']['wikibase_item'] ]
    }
  }
  Hash[ res.flatten(1) ]
end

wikidata_ids(candidates.map { |c| c[:wikiname] }).each do |p|
  data = WikiData::Fetcher.new(id: p.last).data('de') or next
  ScraperWiki.save_sqlite([:id], data)
end

