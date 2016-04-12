#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

class Mapper
  def self.map_issues(source_tool, issues_data, project_id)
    case source_tool
      when 'bugzilla'
        BugzillaMapper.map_issues(issues_data, project_id)
      when 'otrs'
        abort 'Source tool OTRS is in progress'
      else
        abort 'Unknown source tool'
    end
  end
end