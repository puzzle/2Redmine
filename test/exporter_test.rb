# encoding: utf-8

require 'require_all'
require 'minitest/autorun'
require 'date'
require 'json'
require 'restclient'
require_all 'lib'
require 'active_support/inflector'

class ExporterTest < Minitest::Test

  def test_if_export_raise_exception_and_url
    options = {
      source: 'test/test_file.xml',
      project_id: '666',
      source_tool: 'bugzilla',
      api_key: 'th1s1s4t3st',
      url:  'https://something.thisandthat-works.com'
    }
    redmine_issues = Importer.redmine_issues(options)

    exporter = Exporter.new(redmine_issues, options[:url], options[:api_key])

    exception = assert_raises(Exception) do
      exporter.export
    end

    assert_equal 'Connection failed, check your url and apikey', exception.message

  end


end
