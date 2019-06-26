# frozen_string_literal: true

require 'net/http'
require 'active_support/core_ext/numeric/time'

class Gateway::AirtableSessions
  def all
    response = get_as_json('https://api.airtable.com/' \
      "v0/#{ENV['AIRTABLE_TABLE']}/Marketplace" \
      "?maxRecords=100&view=#{ENV['AIRTABLE_ALL_VIEW']}")

    response['records'].map do |record|
      Builder::Session.new.with_block do
        with_title record['fields']['Name']
        with_categories record['fields']['Categories']
        with_host record['fields']['Host']
        with_location record['fields']['Location']
        with_session_type record['fields']['Session Type']
        start_time = DateTime.parse(record['fields']['Time'])
        with_start_time start_time.strftime('%H:%M')
        with_end_time (start_time + record['fields']['Duration'].seconds).strftime('%H:%M')
      end.build
    end
  end

  private

  def get_as_json(url)
    url = URI.parse(url)
    req = Net::HTTP::Get.new(url.to_s)
    req['Authorization'] = "Bearer #{ENV['AIRTABLE_KEY']}"

    res = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
      http.request(req)
    end

    JSON.parse(res.body)
  end
end
