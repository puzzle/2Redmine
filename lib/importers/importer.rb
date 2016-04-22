#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.
class Importer

  # TODO fix method permissions: private, public, protected

  DEFAULT_VALUES = {
    status_id: 1,
    status_name: 'New',
    prioriry_id: 4,
    prioriry_name: 'Normal',
    is_private: false
  }

  def initialize(options)
    @params = options
    @importer = find_importer
  end

  def import_source_entries
    raise 'implement me in sub class'
  end

  def redmine_issues
    source_entries = import_source_entries
    source_entries.collect do |e|
      to_redmine_issue(e)
    end
  end

  def to_redmine_issue(entry)
    params = {}
    RedmineIssue.ATTRS.each do |a|
      params[a] = param_value(a)
    end
    RedmineIssue.new(params)
  end

  def param_value(attr)
    respond_to?(attr) ? send(attr) : DEFAULT_VALUES[attr]
  end

  def format_date(date_str)
    Date.parse(date_str).to_s
  end

  def self.find_importer
    case @params[:source_tool]
    when 'bugzilla'
      BugzillaImporter.new(@params)
    when 'otrs'
      raise 'Source tool OTRS is in progress'
    else
      raise 'Source tool unknown'
    end
  end
end
