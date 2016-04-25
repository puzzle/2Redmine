require 'require_all'
require 'minitest/autorun'
require 'date'
require 'json'
require 'restclient'
require_all 'lib'

class ImporterTest < Minitest::Test

  def test_if_importer_output_is_a_redmine_issue
    options = {
      file: 'test/test_file.xml',
      project_id: '183',
      source_tool: 'bugzilla'
    }

    redmine_issues = Importer.redmine_issues(options)

    source_entry = {project_id: "183",
               tracker_id: 2,
               subject: "1 Test eines Testes",
               description: "BugzillaBug for Test (Logik) 2: \nStatus: NEW / Priority: P1 / Severity: enhancement \n2014-01-01 16:48:53 +0200, :\n \n        Test Issue for Script\n      ",
               start_date: "2014-01-01 16:48:00 +0200",
               estimated_hours: "64.00",
               created_on: "2014-01-01 16:48:00 +0200",
               updated_on: "2014-01-01 16:48:53 +0200",
               story_points: "64.00",
               status_id: 1,
               status_name: "New",
               prioriry_id: 4,
               prioriry_name: "Normal",
               is_private: false}

    assert_equal redmine_issues[0].project_id, source_entry[:project_id]
    assert_equal redmine_issues[0].tracker_id, source_entry[:tracker_id]
    assert_equal redmine_issues[0].subject, source_entry[:subject]
    assert_equal redmine_issues[0].description, source_entry[:description]
    assert_equal redmine_issues[0].start_date, source_entry[:start_date]
    assert_equal redmine_issues[0].estimated_hours, source_entry[:estimated_hours]
    assert_equal redmine_issues[0].created_on, source_entry[:created_on]
    assert_equal redmine_issues[0].updated_on, source_entry[:updated_on]
    assert_equal redmine_issues[0].story_points, source_entry[:story_points]
    assert_equal redmine_issues[0].status_id, source_entry[:status_id]
    assert_equal redmine_issues[0].status_name, source_entry[:status_name]
    assert_equal redmine_issues[0].prioriry_id, source_entry[:prioriry_id]
    assert_equal redmine_issues[0].is_private, source_entry[:is_private]

  end

  def test_abort_if_unknown_tool
    options = {
      file: 'test/test_file.xml',
      project_id: "183",
      url: "https://redmine.puzzle.ch",
      source_tool: "not"
    }

    exception = assert_raises(Exception) {
      Importer.return_importer(options)
     }
    assert_equal "Source tool unknown", exception.message

  end

end
