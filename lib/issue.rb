class Issue
  attr_accessor :project_id, :tracker_id, :status_id, :status_name, :prioriry_id, :prioriry_name, :subject, :description, :start_date, :is_private, :estimated_hours, :created_on, :updated_on, :story_points

  def initialize(params = {})
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def to_json
    {
      issue:{
        project_id: self.project_id,
        tracker_id: self.tracker_id,
        status_id: self.status_id,
        status_name: self.status_name,
        prioriry_id: self.project_id,
        prioriry_name: self.prioriry_name,
        subject: self.subject,
        description: self.description,
        start_date: self.start_date,
        is_private: self.is_private,
        estimated_hours: self.estimated_hours,
        created_on: self.created_on,
        updated_on: self.updated_on,
        story_points: self.story_points
      }
    }.to_json
  end
end