#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.
require 'xmlsimple'

module Porter
  def self.import(file)
    return XmlSimple.xml_in(file) if File.exist?(file)
    abort 'File does not exist'
  end

  def self.export(issue, url, api_key)
    Redmine::Issue.site = url
    Redmine::Issue.headers["X-Redmine-API-Key"] = api_key

      issue.save
    rescue Exception
      abort "Connection failed, check your url and apikey"
  end
end