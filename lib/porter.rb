#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.
require 'xmlsimple'

class Porter
  def import(file)
    return XmlSimple.xml_in(file) if File.exist?(file)
    abort 'File does not exist'
  end

  def export(issue, url, api_key)
      url = url.match(/([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
      redmine_url = "https://#{url}/issues.json"

      RestClient.post(redmine_url, issue.to_json, content_type: :json, params: {key: api_key})
      puts "Imported issue: #{issue.subject}"
    rescue Exception
      abort 'Connection failed, check your url and apikey'
  end
end