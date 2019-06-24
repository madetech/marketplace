# frozen_string_literal: true

describe 'the marketplace' do
  let(:view_sessions) { UseCase::ViewSessions.new(session_gateway: self) }
  let(:add_session) { UseCase::AddOrChangeSession.new(session_gateway: self) }
  let(:sessions) { [] }

  def all
    sessions
  end

  def save(session)
    unless session.id.nil?
      sessions[session.id] = session
      return
    end

    session.id = sessions.length
    sessions << session
    session.id
  end

  def find_by(id)
    sessions[id].dup
  end

  it 'views no sessions' do
    response = view_sessions.execute
    expect(response[:sessions]).to eq([])
  end

  it 'views a session' do
    add_session.execute(title: 'TDD Giraffe Pairing')

    response = view_sessions.execute

    expect(response[:sessions]).to eq([{ title: 'TDD Giraffe Pairing' }])
  end

  it 'updates a session' do
    response = add_session.execute(title: 'TDD Giraffe Pairing')

    add_session.execute(id: response[:id], title: 'TDD Wolf Pairing')

    response = view_sessions.execute

    expect(response[:sessions].length).to eq(1)
    expect(response[:sessions]).to eq([{ title: 'TDD Wolf Pairing' }])
  end
end
