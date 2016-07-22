# encoding: utf-8

#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

class OtrsImporter < Importer

  def initialize(params)
    @params = params
  end

  #
  # Main method
  #
  def import_source_entries
    otrs_tickets = @params[:queue].nil? ? tickets : queue_tickets
    @params[:query].nil? ? otrs_tickets : query_tickets_filter(otrs_tickets)
  end

  #
  # redmine_issues Attributes
  #
  def project_id(ticket)
    @params[:project_id]
  end

  def start_date(ticket)
    format_date(ticket[:create_time].to_s)
  end

  def created_on(ticket)
    format_date(ticket[:create_time].to_s)
  end

  def updated_on(ticket)
    format_date(ticket[:change_time].to_s)
  end

  def description(ticket)
    desc = "OTRS ticket \n"
    ticket[:customer_id].nil? ? desc += "\n \n" : desc += "Reporting Customer: #{ticket[:customer_id]} \n \n"

    ticket_articles(ticket[:id]).each do |ta|
      desc += "*#{ta[:create_time]}, #{ta[:a_from]}:* \n"
      desc += "<pre>#{ta[:a_body]}</pre>"
    end
    desc
  end

  def subject(ticket)
    ticket[:title]
  end

  def status_id(ticket)
    status = otrs_ticket_status(ticket[:ticket_state_id])
    redmine_status_id = case status
    when 'new' then 1
    when 'check efficacy' then 7
    else 3
    end
    redmine_status_id
  end

  def fixed_version_id(ticket)
    if ticket_status_check_efficacy(ticket)
      843
    elsif ticket_status_closed_successful(ticket)
      842
    end
  end

  private
  #
  # Helpermethods
  #
  def ticket_status_check_efficacy(ticket)
    otrs_ticket_status(ticket[:ticket_state_id]) == 'check efficacy'
  end

  def ticket_status_closed_successful(ticket)
    !article_check(ticket[:id]) && otrs_ticket_status(ticket[:ticket_state_id]) == 'closed successful'
  end

  def article_check(ticket_id)
    article = ticket_articles(ticket_id)
    article.find {|a| a[:a_subject] == 'Wirksamkeit geprüft'}.nil?
  end

  def format_date(date_str)
    Date.parse(date_str).to_s
  end

  def query_tickets_filter(otrs_tickets)
    otrs_tickets.where(Sequel.like(:title, /#{@params[:query]}.*/))
  end

  #
  # Database connection and credentials
  #
  def db_connect
    con = Sequel.mysql(adapter: 'mysql2',
                       user: db_credentials['Username'],
                       host: db_credentials['Host'],
                       database: db_credentials['Database'],
                       password: db_credentials['Password'],
                       encoding: 'utf8')
    con.test_connection rescue abort "Can't connect to Database"
    con
  end

  def db_credentials
    credentials = YAML.load(File.read('db_credentials.yml'))
  end

  #
  # Database Requests
  #
  def otrs_ticket_status(ticket_state_id)
    otrs_db["select name from ticket_state where id = #{ticket_state_id.to_s}"].first[:name]
  end

  def queue_id
    otrs_db["select id from queue where name like '#{@params[:queue]}'"]
  end

  def tickets
    otrs_db[:ticket]
  end

  def queue_tickets
    tickets.where(queue_id: queue_id.first[:id].to_s)
  rescue
    puts 'Queue not found in database'
  end

  def ticket_articles(ticket_id)
    otrs_db[:article].where(ticket_id: ticket_id)
  end

  def otrs_db
    @db ||= db_connect
  end
end
