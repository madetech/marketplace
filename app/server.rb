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
