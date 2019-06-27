# frozen_string_literal: true

class UseCase::ViewSessions
  def initialize(session_gateway:)
    @session_gateway = session_gateway
  end

  def execute(*)
    presentable_sessions = {}

    @session_gateway.all.each do |session|
      presentable_session = {}
      all_presentable_fields(session).each do |(key, value)|
        presentable_session[key] = value
      end

      presentable_sessions[session.date] ||= []
      presentable_sessions[session.date] << presentable_session
    end

    {
      sessions: presentable_sessions
    }
  end

  private

  def all_presentable_fields(session)
    session
      .visible_fields
      .map { |f| [f, session.send(f)] }
  end
end
