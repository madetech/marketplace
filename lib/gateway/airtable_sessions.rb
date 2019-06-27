# frozen_string_literal: true

require 'net/http'
require 'active_support/core_ext/numeric/time'

class Gateway::AirtableSessions
  def all
    response = get_as_json('https://api.airtable.com/' \
      "v0/#{ENV['AIRTABLE_TABLE']}/Marketplace" \
      "?maxRecords=100&view=#{ENV['AIRTABLE_ALL_VIEW']}")

    response['records'].map do |record|
      fields = record['fields']

      start_time = start_time_in_london_timezone(fields['Time'])
      formatted_start_time = format_time(start_time)
      formatted_end_time = format_time(end_time(start_time, fields['Duration']))

      Builder::Session.new.with_block do
        with_title fields['Name']
        with_categories fields['Categories']
        with_host fields['Host']
        with_location fields['Location']
        with_session_type fields['Session Type']

        with_start_time formatted_start_time
        with_end_time formatted_end_time
      end.build
    end
  end

  private

  def end_time(start_time, var)
    (start_time + var.seconds)
  end

  def format_time(start_time)
    start_time.strftime('%H:%M')
  end

  def start_time_in_london_timezone(var)
    DateTime.parse(var).to_time.in_time_zone('Europe/London')
  end

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
