# frozen_string_literal: true

class UseCase::ViewSessions
  def initialize(session_gateway:)
    @session_gateway = session_gateway
  end

  def execute(*)
    {
      sessions: all_sessions.map(&method(:to_presentable_session))
    }
  end

  private

  def to_presentable_session(session)
    presentable_session = {}
    all_presentable_fields(session).each do |(key, value)|
      presentable_session[key] = value
    end
    presentable_session
  end

  def all_presentable_fields(session)
    session
      .visible_fields
      .map { |f| [f, session.send(f)] }
  end

  def all_sessions
    @session_gateway.all
  end
end
