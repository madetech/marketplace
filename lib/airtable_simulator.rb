# frozen_string_literal: true

class AirtableSimulator
  def response
    {
      "records": [
        {
          "id": 'recg5IIoqQfQc8D0d',
          "fields": {
            "Location": '2nd Floor',
            "Name": '?',
            "Host": 'Chris',
            "Time": '2019-06-21T12:30:00.000Z',
            "Duration": 10_800,
            "Categories": [
              'Code'
            ],
            "Session Type": 'Mobbing'
          },
          "createdTime": '2019-06-24T15:13:11.000Z'
        },
        {
          "id": 'rechEB6htlziD9stw',
          "fields": {
            "Location": 'Kitchen',
            "Name": 'Training Videos',
            "Host": 'Craig',
            "Time": '2019-06-21T13:00:00.000Z',
            "Duration": 9000,
            "Categories": [
              'Code'
            ],
            "Session Type": 'Filming'
          },
          "createdTime": '2019-06-24T15:14:01.000Z'
        },
        {
          "id": 'recQRPX1ZDyWPatOk',
          "fields": {
            "Location": '1st Floor Pairing Space',
            "Name": 'Test Doubles - How do true mocks?',
            "Host": 'Ting',
            "Time": '2019-06-22T13:00:00.000Z',
            "Duration": 9000,
            "Categories": [
              'Code'
            ],
            "Session Type": 'Mobbing'
          },
          "createdTime": '2019-06-24T15:14:42.000Z'
        },
        {
          "id": 'recQRPX1ZDyWPatOk',
          "fields": {
            "Location": '1st Floor Pairing Space',
            "Name": 'This is a showcase!!',
            "Host": 'Maysa',
            "Time": '2019-06-22T15:30:00.000Z',
            "Duration": 600,
            "Categories": [
              'Code'
            ],
            "Session Type": 'Showcase'
          },
          "createdTime": '2019-06-24T15:14:42.000Z'
        },
        {
          "id": 'recQRPX1ZDyWPatOk',
          "fields": {
            "Location": '1st Floor Pairing Space',
            "Name": 'This is a showcase!!',
            "Host": 'Maysa',
            "Time": '2019-06-30T15:30:00.000Z',
            "Duration": 600,
            "Categories": [
              'Code'
            ],
            "Session Type": 'Asd'
          },
          "createdTime": '2019-06-24T15:14:42.000Z'
        }
      ],
      "offset": 'recQRPX1ZDyWPatOk'
    }.to_json
  end
end
