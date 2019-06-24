# frozen_string_literal: true

describe UseCase::ViewSessions do
  it 'can display no sessions' do
    response = described_class.new(session_gateway: double(all: [])).execute({})
    expect(response[:sessions]).to eq([])
  end

  it 'can display a session' do
    session = Class.new do
      def title
        'Hello'
      end
    end.new

    response = described_class.new(session_gateway: double(all: [session])).execute({})
    expect(response.dig(:sessions, 0, :title)).to eq('Hello')
  end
end
