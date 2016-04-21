require 'minitest/autorun'
require 'date'
require 'json'
require 'restclient'
require './lib/redmine_issue.rb'
require './lib/exporter.rb'
require './lib/option_handler.rb'
require './lib/importers/importer.rb'
require './lib/importers/bugzilla_importer.rb'

class ImporterTest < Minitest::Test


  def test_redmine_issue_output

    arguments = {:project_id=>"183",
               :tracker_id=>2,
               :subject=>"1 Test eines Testes",
               :description=>"BugzillaBug for Test (Logik) 2: \nStatus: NEW / Priority: P1 / Severity: enhancement \n2014-01-01 16:48:53 +0200, :\n \n        Test Issue for Script\n      ",
               :start_date=>"2014-01-01",
               :estimated_hours=>"64.00",
               :created_on=>"2014-01-01",
               :updated_on=>"2014-01-01",
               :story_points=>"64.00",
               :status_id=>1,
               :status_name=>"New",
               :prioriry_id=>4,
               :prioriry_name=>"Normal",
               :is_private=>false}

    expected = client_importer.to_redmine_issue(arguments)
    issues = client_importer.redmine_issues

    assert_equal issues[0].subject, expected.subject
    assert_equal issues[0].start_date, expected.start_date

  end

  def test_find_importer_abort
    exception = assert_raises(Exception) {
      client_unknown_source_tool.find_importer
     }
    assert_equal( "Source tool unknown", exception.message )

  end

  def client_importer

    params = {
      :file=>'test/test_file.xml',
      :project_id=>"183",
      :url=>"https://redmine.puzzle.ch",
      :source_tool=>"bugzilla"
    }

    client = Importer.new(params)
  end

  def client_unknown_source_tool
    params = {
      :file=>'test/test_file.xml',
      :project_id=>"183",
      :url=>"https://redmine.puzzle.ch",
      :source_tool=>"not"
    }

    Importer.new(params)
  end

end
