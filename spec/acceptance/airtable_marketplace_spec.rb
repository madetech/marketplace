# frozen_string_literal: true

describe 'the marketplace' do
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
              "Location": 'Snowdon',
              "Name": 'Another event',
              "Host": 'George',
              "Time": '2019-06-28T13:00:00.000Z',
              "Duration": 3600,
              "Categories": %w[Something],
              "Session Type": 'Workshop'
            }
          }
        ] }
  end

  let(:session_gateway) { Gateway::AirtableSessions.new }
  let(:view_sessions) do
    UseCase::ViewSessions.new(session_gateway: session_gateway)
  end

  before do
    set_env('AIRTABLE_TABLE', 'base')
    set_env('AIRTABLE_ALL_VIEW', 'filter')
    set_env('AIRTABLE_KEY', 'token')

    stub_request(
      :get,
      'https://api.airtable.com/v0/base/Marketplace?maxRecords=100&view=filter'
    ).with(
      headers: {
        'Authorization' => 'Bearer token'
      }
    ).to_return(status: 200, body: response.to_json, headers: {})
  end

  it 'views the sessions' do
    response = view_sessions.execute
    expect(response[:sessions]).to(
      eq(
        [
          {
            title: 'From Protokanban to Kanban',
            categories: %w[Lean Delivery],
            host: 'Craig',
            session_type: 'Seminar',
            location: '1st Floor Event Space',
            start_time: '13:45',
            end_time: '14:30'
          },
          {
            title: 'Another event',
            categories: %w[Something],
            host: 'George',
            session_type: 'Workshop',
            location: 'Snowdon',
            start_time: '14:00',
            end_time: '15:00'
          }
        ]
      )
    )
  end
end
