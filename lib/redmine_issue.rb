#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

class RedmineIssue
  ATTRS = [:project_id, :tracker_id, :status_id, :status_name, :prioriry_id, :prioriry_name, :subject, :description, :start_date, :is_private, :estimated_hours, :created_on, :updated_on, :story_points ]

  attr_accessor *ATTRS

  def initialize(params = {})
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def to_json
    { issue: key_value_hash }.to_json
  end

  def key_value_hash
    kv = {}
    ATTRS.each do |a|
      kv[a] = send(a)
    end
    kv
  end

end
