#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

include OptionHandler
class ToRedmine

  def self.execute
    options = OptionHandler.parse
    im = Importer.new(options)
    redmine_issues = im.redmine_issues
    e = Exporter.new
    redmine_issues.each do |i|
      e.export(i, options[:url], options[:apikey])
    end
    puts 'Issue importing succeeded!'
  end

end
