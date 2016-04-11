#  Copyright (c) 2016, Puzzle ITC GmbH. This file is part of
#  2Redmine and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/2Redmine.

require 'active_resource'
require './modules/porter.rb'
require './modules/redmine.rb'
require './modules/option_handler.rb'

include Porter
include Redmine
include OptionHandler

def to_redmine
  options = OptionHandler.parse
  Porter.import(options[:file])
end

