# encoding: utf-8

#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.
require 'xmlsimple'

class Exporter

  def initialize (issue, url, api_key)
    @issue = issue
    @url = URI("#{url}/issues.json")
    @api_key = api_key
  end

  def export
    redmine_url = "https://#{@url.host}#{@url.path}"
      @issue.each do |i|
        client = RestClient::Resource.new(redmine_url, :verify_ssl => false)
        client.post(i.to_json, content_type: :json, params: {key: @api_key})
        puts "exported issue: #{i.subject}"
      end
    rescue Exception
      abort 'Connection failed, check your url and apikey'
  end
end
