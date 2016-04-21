#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.
class Importer

  def initialize(options)
    @params = options
  end

  def redmine_issues
    importer = find_importer
    issue = importer.import
    issue.collect do |i|
      attributes = to_redmine_map(i, importer)
      to_redmine_issue(attributes)
    end
  end

  def to_redmine_map (issue, importer)
    redmine_map =  {
          project_id: @params[:project_id],
          tracker_id: importer.method(:tracker_id).call(issue),
          subject: importer.method(:subject).call(issue),
          description: importer.method(:description).call(issue),
          start_date: to_date(importer.method(:start_date).call(issue)),
          estimated_hours: importer.method(:estimated_hours).call(issue),
          created_on: to_date(importer.method(:created_on).call(issue)),
          updated_on: to_date(importer.method(:updated_on).call(issue)),
          story_points: importer.method(:story_points).call(issue),
          status_id: 1,
          status_name: 'New',
          prioriry_id: 4,
          prioriry_name: 'Normal',
          is_private: false,
        }
  end

  def find_importer
    case @params[:source_tool]
      when 'bugzilla'
        BugzillaImporter.new(@params)
      when 'otrs'
        raise 'Source tool OTRS is in progress'
      else
          raise 'Source tool unknown'
    end
  end

  def to_redmine_issue(attributes)
    RedmineIssue.new(attributes)
  end

  def to_date(date_str)
    Date.parse(date_str).to_s
  end
end
