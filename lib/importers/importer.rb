# encoding: utf-8

#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

class Importer

  DEFAULT_VALUES = {
    status_id: 1,
    tracker_id: 2,
    prioriry_id: 4,
    prioriry_name: 'Normal',
    is_private: false,
    fixed_version_id: 0
  }

  class << self
    def redmine_issues(options)
      @importer = initialize_importer(options)
      @source_entries = @importer.import_source_entries
      @source_entries.collect do |e|
        to_redmine_issue(e)
      end
    end

    def initialize_importer(options)
      importer_name = options[:source_tool].capitalize + 'Importer'
      ActiveSupport::Inflector.constantize(importer_name).new(options)
    rescue Exception
      abort 'Source tool unknown'
    end

    def param_value(attr, entry)
      if @importer.respond_to?(attr) && !@importer.send(attr, entry).nil?
        @importer.send(attr, entry)
      else
        DEFAULT_VALUES[attr]
      end
    end

    def to_redmine_issue(entry)
      params = {}
      RedmineIssue::ATTRS.each do |a|
        params[a] = param_value(a, entry)
      end
      RedmineIssue.new(params)
    end

    def import_source_entries
      raise 'implement me in subclass'
    end
  end
end
