# encoding: utf-8

#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

require 'optparse'

module OptionHandler
  def self.parse
    # Array for options
    options = {}

    #
    # Return a structure describing the options.
    #
    opt_parser = OptionParser.new do |opt|
      opt.banner = 'Usage: opt_parser COMMAND [OPTIONS]'
      opt.separator  ''
      opt.separator  'Commands'
      opt.separator  '     2redmine: copy to redmine'
      opt.separator  ''
      opt.separator  'Options'

      opt.on('-rso','--redmine-source source','which source you want paste in to redmine (required)') do |source|
        options[:source] = source
      end

      opt.on('-rr','--redmine-projectid Projectid', 'which project you want paste in (required)') do |project_id|
        options[:project_id] = project_id
      end

      opt.on('-ra','--redmine-apikey Apikey', 'which apikey you want to use (required)') do |apikey|
        options[:apikey] = apikey
      end

      opt.on('-ru','--redmine-url URL', 'which URL you want to use (required)') do |url|
        options[:url] = url
      end

      opt.on('-e','--source-tool Source-Tool', 'which source tool you want to use (required) | Options: bugzilla, OTRS') do |source_tool|
        options[:source_tool] = source_tool
      end

      opt.on('-s','--status-id Status-id', 'which status id you want to use (Default = 1)') do |status_id|
        options[:status_id] = status_id
      end

      #
      # Parameters for OTRS
      #
      opt.on('-oq','--otrs-query Otrs-Query', 'otrs ticket title filter') do |query|
        options[:query] = query
      end

      opt.on('--otrs-queue ', 'otrs queue name to import tickets from, e.g. --otrs-queue-name MyQueue') do |queue|
        options[:queue] = queue
      end


      opt.on('-h','--help','help') do
        puts opt_parser
      end
    end

    begin
      opt_parser.parse!
    rescue OptionParser::InvalidOption => e
      puts e
      puts opt_parser
      exit
    end

    unless options.count >= 4
      puts 'argument(s) is missing'
      puts opt_parser
      exit
    end
    options
  end
end
