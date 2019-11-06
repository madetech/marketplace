# frozen_string_literal: true

require 'rack-livereload'
require 'sinatra'
use Rack::LiveReload

require 'zeitwerk'
require 'dotenv/load'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/../lib/")
loader.enable_reloading
loader.setup

class Integer
  def ordinalize
    if (11..13).include?(self % 100)
      "#{self}th"
    else
      case self % 10
      when 1 then "#{self}st"
      when 2 then "#{self}nd"
      when 3 then "#{self}rd"
      else "#{self}th"
      end
    end
  end
end

before { loader.reload }

set :port, ENV['PORT'] || 4567

get '/' do
  response = UseCase::ViewSessions.new(
    session_gateway: Gateway::AirtableSessions.new
  ).execute
  erb :index, locals: response
end

get %r{/v0/.*} do
  AirtableSimulator.new.response
end
