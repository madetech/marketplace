# frozen_string_literal: true

class UseCase::AddOrChangeSession
  def initialize(session_gateway:)
    @session_gateway = session_gateway
  end

  def execute(title:, id: nil)
    session = if id.nil?
                Domain::Session.new
              else
                @session_gateway.find_by(id)
              end

    session.title = title
    id = @session_gateway.save(session)
    { id: id }
  end
end
