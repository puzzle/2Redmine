#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.
class Importer

  DEFAULT_VALUES = {
    status_id: 1,
    status_name: 'New',
    prioriry_id: 4,
    prioriry_name: 'Normal',
    is_private: false
  }

  def self.redmine_issues(options)
    @importer = return_importer(options)
    @source_entries = @importer.import_source_entries
    @source_entries.collect do |e|
      to_redmine_issue(e)
    end
  end

  private

  def self.param_value(attr, entry)
    @importer.respond_to?(attr) ? @importer.send(attr, entry) : DEFAULT_VALUES[attr]
  end

  def self.return_importer(options)
    case options[:source_tool]
      when 'bugzilla'
        BugzillaImporter.new(options)
      when 'otrs'
        raise 'Source tool OTRS is in progress'
      else
        raise 'Source tool unknown'
      end
    end
  end

  def to_redmine_issue(entry)
    params = {}
    RedmineIssue::ATTRS.each do |a|
      params[a] = param_value(a, entry)
    end
    RedmineIssue.new(params)
  end

  def format_date(date_str)
    Date.parse(date_str).to_s
  end
