#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/cryptopus.

require 'optparse'

module OptionHandler
  def self.parse
    # Array for options
    options = {}

    #
    # Return a structure describing the options.
    #
    opt_parser = OptionParser.new do |opt|
      opt.banner = "Usage: opt_parser COMMAND [OPTIONS]"
      opt.separator  ""
      opt.separator  "Commands"
      opt.separator  "     2redmine: copy to redmine"
      opt.separator  ""
      opt.separator  "Options"

      opt.on("-f","--file File","which file you want paste in to redmine (required)") do |file|
        options[:file] = file
      end

      opt.on("-r","--redmine_projectid Projectid", "which project you want paste in (required)") do |projectid|
        options[:projectid] = projectid
      end

      opt.on("-a","--apikey Apikey", "which apikey you want to use (required)") do |apikey|
        options[:apikey] = apikey
      end

      opt.on("-u","--url URL", "which URL you want to use (required)") do |url|
        options[:url] = url
      end

      opt.on("-e","--source_tool Source_Tool", "which source tool you want to use (required) | Options: bugzilla") do |exporttool|
        options[:exporttool] = exporttool
      end

      opt.on("-h","--help","help") do
        puts opt_parser
      end
    end

    opt_parser.parse!

    unless options.count == 5
      puts "argument(s) is missing"
      puts opt_parser
    end
    options
  end
end
