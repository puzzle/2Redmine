#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

class BugzillaMapper
  class << self
    def map_issues(issues_data, project_id)
      issues_data['bug'].collect do |b|
        bug_to_issue(b, project_id)
      end
    end

    def bug_to_issue(bug, project_id)
      Issue.new(
        {
          project_id: project_id,
          tracker_id: bugzilla_tracker_id(bug),
          status_id: 1,
          status_name: 'New',
          prioriry_id: 4,
          prioriry_name: 'Normal',
          subject: bugzilla_subject(bug),
          description: bugzilla_description(bug),
          start_date: to_date(bug['creation_ts'][0]),
          is_private: false,
          estimated_hours: bug['estimated_time'][0],
          created_on: to_date(bug['creation_ts'][0]),
          updated_on: to_date(bug['delta_ts'][0]),
          story_points: bug['estimated_time'][0]
        }
      )
    end

    def bugzilla_tracker_id(bug)
      bug['bug_severity'][0] == 'enhancement' ? 2 : 1
    end

    def bugzilla_description(bug)
      desc = "BugzillaBug for #{bug['product'][0]} (#{bug['component'][0]}) #{bug['version'][0]}: \n"
      desc += "Status: #{bug['bug_status'][0]} / Priority: #{bug['priority'][0]} / Severity: #{bug['bug_severity'][0]} \n"
      desc += "Reporting Customer: #{bug['cf_customer'][0]} \n"

      bug['long_desc'].each do |ld|
        desc += "#{ld['bug_when'][0]}, #{ld['who'][0]['content']}:\n #{ld['thetext'][0]}"
      end
      desc
    end

    def bugzilla_subject(bug)
      "#{bug['bug_id'][0]} #{bug['short_desc'][0]}"
    end

    def to_date(date_str)
      Date.parse(date_str).to_s
    end
  end
end