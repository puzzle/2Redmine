require 'require_all'
require 'minitest/autorun'
require 'date'
require 'json'
require 'restclient'
require_all 'lib'
require 'active_support/inflector'
require 'mocha/mini_test'
require 'sequel'

class OtrsImporterTest < Minitest::Test
  def test_otrs

    ticket =  {  id: 2462,
                 tn: "0313524598",
                 title: "test the test ticket for testing something for test reason",
                 queue_id: 40,
                 ticket_lock_id: 1,
                 type_id: 1,
                 service_id: nil,
                 sla_id: nil,
                 user_id: 1,
                 responsible_user_id: 1,
                 ticket_priority_id: 3,
                 ticket_state_id: 3,
                 customer_id: "test@test.ch",
                 customer_user_id: "test",
                 timeout: 0,
                 until_time: 0,
                 escalation_time: 0,
                 escalation_update_time: 0,
                 escalation_response_time: 0,
                 escalation_solution_time: 0,
                 create_time_unix: 1325842202,
                 create_time: "2012-01-06 10:30:02 +0100",
                 create_by: 1,
                 change_time: "2012-03-28 15:50:47 +0200",
                 change_by: 37,
                 archive_flag: 0}

    article =   [{create_time: "2012-01-06 10:30:02 +0100",
                 a_from: "Markus Tester <tester@test.ch>",
                 a_body: "Dies ist der body eines article und zugleich auch ein Test"}]


    @importer = OtrsImporter.new({query: "test", project_id: '666'})
    @importer.expects(:otrs_ticket_status).with(ticket[:ticket_state_id]).returns('new').at_most(3)
    @importer.expects(:ticket_article).with(ticket[:id]).returns(article).at_most(3)
    Importer.instance_variable_set(:@importer, @importer)

    redmine_issue = Importer.to_redmine_issue(ticket)

    assert_equal "666", redmine_issue.project_id
    assert_equal 2, redmine_issue.tracker_id
    assert_equal "test the test ticket for testing something for test reason", redmine_issue.subject
    description = "OTRS ticket \nReporting Customer: test@test.ch \n \n*2012-01-06 10:30:02 +0100, Markus Tester <tester@test.ch>:* \n<pre>Dies ist der body eines article und zugleich auch ein Test</pre>"
    assert_equal description, redmine_issue.description
    assert_equal "2012-01-06", redmine_issue.start_date
    assert_equal "2012-01-06", redmine_issue.created_on
    assert_equal "2012-03-28", redmine_issue.updated_on
    assert_equal nil, redmine_issue.story_points
    assert_equal 1, redmine_issue.status_id
    assert_equal 4, redmine_issue.prioriry_id
    assert_equal false, redmine_issue.is_private
  end


end
