# frozen_string_literal: true

class UseCase::ViewSessions
  def initialize(session_gateway:)
    @session_gateway = session_gateway
  end

  def execute(*)
    sessions = @session_gateway.all
    presentable_sessions = if sessions.empty?
                             []
                           else
                             [{ title: sessions.first.title }]
                           end
    { sessions: presentable_sessions }
  end
end
