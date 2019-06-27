# frozen_string_literal: true

describe Gateway::AirtableSessions do
  include_context 'environment variables'

  let(:response) do
    { "records":
        [
          {
            "fields": {
              "Location": '1st Floor Event Space',
              "Name": 'From Protokanban to Kanban',
              "Host": 'Craig',
              "Time": '2019-06-28T12:45:00.000Z',
              "Duration": 2700,
              "Categories": %w[Lean Delivery],
              "Session Type": 'Seminar'
            }
          },
          {
            "fields": {
              "Location": '1st Floor Event Space',
              "Name": 'Another event',
              "Host": 'George',
              "Time": '2019-06-28T12:45:00.000Z',
              "Duration": 2700,
              "Categories": %w[Delivery],
              "Session Type": 'Seminar'
            }
          }
        ] }
  end

  before do
    set_env('AIRTABLE_TABLE', 'thisisanid')
    set_env('AIRTABLE_ALL_VIEW', 'All')
    set_env('AIRTABLE_KEY', '1234verysecure')

    stub_request(
      :get,
      'https://api.airtable.com/v0/thisisanid/Marketplace?maxRecords=100&view=All'
    ).with(
      headers: {
        'Authorization' => 'Bearer 1234verysecure'
      }
    ).to_return(status: 200, body: response.to_json, headers: {})
  end

  it 'can show all upcoming sessions' do
    sessions = described_class.new.all

    sessions[0].tap do |session|
      expect(session.title).to eq('From Protokanban to Kanban')
      expect(session.categories).to eq(%w[Lean Delivery])
      expect(session.host).to eq('Craig')
      expect(session.start_time).to eq('13:45')
      expect(session.end_time).to eq('14:30')
      expect(session.location).to eq('1st Floor Event Space')
      expect(session.session_type).to eq('Seminar')
    end

    sessions[1].tap do |session|
      expect(session.title).to eq('Another event')
      expect(session.categories).to eq(%w[Delivery])
      expect(session.host).to eq('George')
    end
  end
end
