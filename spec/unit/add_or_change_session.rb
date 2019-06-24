# frozen_string_literal: true

describe UseCase::AddOrChangeSession do
  [
    'My first title',
    'Untitled session'
  ].each do |session_title|
    it 'can add a session' do
      gateway = spy(save: nil)
      add_session = described_class.new(session_gateway: gateway)
      add_session.execute(title: session_title)

      expect(gateway).to have_received(:save) do |session|
        expect(session.title).to eq(session_title)
      end
    end
  end

  it 'responds with an id' do
    gateway = double(save: 1)
    add_session = described_class.new(session_gateway: gateway)
    response = add_session.execute(title: '')

    expect(response[:id]).to eq(1)
  end

  it 'can update a session' do
    session = Domain::Session.new
    session.title = 'Old Title'
    session.id = 1

    gateway = double(save: 1, find_by: session)

    add_session = described_class.new(session_gateway: gateway)
    add_session.execute(id: 1, title: 'New Title')

    expect(gateway).to have_received(:find_by).with(1)
    expect(gateway).to have_received(:save) do |session|
      expect(session.title).to eq('New Title')
      expect(session.id).to eq(1)
    end
  end
end
