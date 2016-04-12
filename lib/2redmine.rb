#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

include OptionHandler

def to_redmine
  p = Porter.new
  
  options = OptionHandler.parse
  issues_hash = p.import(options[:file])
  issues = Mapper.map_issues(options[:source_tool], issues_hash, options[:project_id])

  issues.each do |i|
    p.export(i, options[:url], options[:apikey])
  end
  puts 'Issue importing succeeded!'
end