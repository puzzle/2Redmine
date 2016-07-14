# encoding: utf-8

#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

class OtrsImporter < Importer

  def initialize(params)
    @params = params
  end

  def import_source_entries
    @params[:query].nil? ? queue_tickets : queue_tickets_filter
  end

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

    ticket_article(ticket[:id]).all.each do |ta|
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
      when "new" then 1
      when "check efficacy" then 7
      else 3
    end
    redmine_status_id
  end

  def fixed_version_id(ticket)
    if otrs_ticket_status(ticket[:ticket_state_id]) == 'check efficacy'
      #to-do: Id from target-version 'wirksamkeit prüfen'
      843
    elsif article_check(ticket[:id]) == false && otrs_ticket_status(ticket[:ticket_state_id]) == 'closed successful'
      842
    end
  end

  def article_check(ticket_id)
    article = ticket_article(ticket_id)
    article.find {|a| a[:a_subject] == "Wirksamkeit geprüft"}.nil?
  end

  def otrs_ticket_status(ticket_state_id)
    db["select name from ticket_state where id=" + ticket_state_id.to_s].first[:name]
  end

  def format_date(date_str)
    Date.parse(date_str).to_s
  end

  def db_connect
    Sequel.mysql(:adapter => 'mysql2', :user => db_credentials['Username'], :host => db_credentials['Host'], :database => db_credentials['Database'], :password=> db_credentials['Password'], :encoding => 'utf8')
  end

  def db_credentials
    credentials = YAML.load(File.read("db_credentials.yml"))
  end

  def queue_id
    db["select id from queue where name like '" + @params[:queue]+"'"]
  end

  def ticket_status
    db[:ticket_state].where()
  end

  def queue_tickets
    db[:ticket].where(:queue_id => queue_id.first[:id].to_s)
  end

  def queue_tickets_filter
    queue_tickets.where(Sequel.like(:title, /#{@params[:query]}.*/))
  end

  def ticket_article(ticket_id)
    db[:article].where(:ticket_id => ticket_id)
  end

  def db
    @db ||= db_connect
  end
end
