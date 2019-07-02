# frozen_string_literal: true

class UseCase::ViewSessions
  def initialize(session_gateway:)
    @session_gateway = session_gateway
  end

  def execute(*)
    response_builder = ResponseBuilder.new

    @session_gateway.all.each do |session|
      response_builder.date(session.date)

      if showcase?(session)
        response_builder.showcase to_presentable(session)
      else
        response_builder.session to_presentable(session)
      end
    end

    response_builder.build
  end

  private

  class ResponseBuilder
    def initialize
      @presentable_sessions = {}
      @presentable_showcases = {}
      @last_date = nil
    end

    def build
      {
        sessions: @presentable_sessions,
        showcases: @presentable_showcases
      }
    end

    def date(date)
      @presentable_sessions[date] ||= []
      @presentable_showcases[date] ||= []
      @last_date = date
    end

    def showcase(showcase)
      @presentable_showcases[@last_date] << showcase
    end

    def session(session)
      @presentable_sessions[@last_date] << session
    end
  end

  def showcase?(session)
    session.session_type == 'Showcase'
  end

  def to_presentable(session)
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
end
