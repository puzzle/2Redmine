require 'require_all'
require 'minitest/autorun'
require 'date'
require 'json'
require 'restclient'
require_all 'lib'
require 'active_support/inflector'

class BugzillaImporterTest < Minitest::Test

  def test_convert_bugzilla_bug_to_redmine_issue
    options = {
      source: 'test/test_file.xml',
      project_id: '183',
      source_tool: 'bugzilla'
    }

    redmine_issues = Importer.redmine_issues(options)

    redmine_issue = redmine_issues.first

    assert_equal "183", redmine_issue.project_id
    assert_equal 2, redmine_issue.tracker_id
    assert_equal "1 Test eines Testes", redmine_issue.subject
    description = "BugzillaBug for Test (Logik) 2: \nStatus: NEW / Priority: P1 / Severity: enhancement \n2014-01-01 16:48:53 +0200, :\n \n        Test Issue for Script\n      "
    assert_equal description, redmine_issue.description
    assert_equal "2014-01-01", redmine_issue.start_date
    assert_equal "64.00", redmine_issue.estimated_hours
    assert_equal "2014-01-01", redmine_issue.created_on
    assert_equal "2014-01-01", redmine_issue.updated_on
    assert_equal "64.00", redmine_issue.story_points
    assert_equal 1, redmine_issue.status_id
    assert_equal 'New', redmine_issue.status_name
    assert_equal 4, redmine_issue.prioriry_id
    assert_equal false, redmine_issue.is_private

  end

  def test_abort_if_unknown_source_tool
    options = {
      source: 'test/test_file.xml',
      project_id: "183",
      source_tool: 'ms-windows'
    }

    exception = assert_raises(Exception) do
      Importer.initialize_importer(options)
    end
    assert_equal "Source tool unknown", exception.message

  end

  def test_if_format_date_is_correct
    date = BugzillaImporter.new('test').send(:format_date, '2014-01-01 16:48:00 +0200')

    assert_equal "2014-01-01", date
  end

end
