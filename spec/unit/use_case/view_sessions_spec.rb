# frozen_string_literal: true

describe UseCase::ViewSessions do
  it 'can display no sessions' do
    response = view_sessions([])
    expect(response[:sessions]).to eq({})
  end

  def view_sessions(sessions)
    described_class.new(session_gateway: double(all: sessions))
                   .execute({})
  end

  def expect_first_session(field)
    expect(response.dig(:sessions, '2019-06-29', 0, field))
  end

  def expect_second_session(field)
    expect(response.dig(:sessions, '2019-06-25', 0, field))
  end

  def a_session(&block)
    b = Builder::Session.new
    b.with_block(&block)
    b.build
  end

  context 'given some sessions' do
    let(:sessions) { [] }
    let(:response) do
      view_sessions(sessions)
    end

    before do
      sessions << a_session do
        with_title('Hello?')
        with_categories(%w[Lean Agile])
        with_host('Craig')
        with_session_type('Workshop')
        with_location('London')
        with_start_time('14:00')
        with_end_time('17:00')
        with_date('2019-06-29')
      end

      sessions << a_session do
        with_title('Hello!')
        with_categories(%w[Hello There])
        with_session_type('')
        with_location('Manchester')
        with_start_time('14:01')
        with_end_time('17:01')
        with_date('2019-06-25')
      end
    end

    context 'and some showcases' do
      before do
        sessions << a_session do
          with_title('I am a showcase')
          with_host('Craig')
          with_categories(%w[Hello There])
          with_session_type('Showcase')
          with_location('Manchester')
          with_start_time('16:30')
          with_end_time('16:40')
          with_date('2019-06-25')
        end

        sessions << a_session do
          with_title('Another one')
          with_host('Emma')
          with_categories(%w[Hello There])
          with_session_type('Showcase')
          with_location('Manchester')
          with_start_time('16:40')
          with_end_time('16:50')
          with_date('2019-06-25')
        end
      end

      it 'only has 1 session on the 25th still' do
        expect(response[:sessions]['2019-06-25'].length).to eq(1)
      end

      it 'can view the showcases' do
        expect(response[:showcases]['2019-06-25'][0]).to eq(
          title: 'I am a showcase',
          host: 'Craig',
          session_type: 'Showcase',
          categories: %w[Hello There],
          location: 'Manchester',
          start_time: '16:30',
          end_time: '16:40'
        )
        expect(response[:showcases]['2019-06-25'][1]).to eq(
          title: 'Another one',
          host: 'Emma',
          session_type: 'Showcase',
          categories: %w[Hello There],
          location: 'Manchester',
          start_time: '16:40',
          end_time: '16:50'
        )
      end
    end

    it 'can view the titles' do
      expect_first_session(:title).to eq('Hello?')
      expect_second_session(:title).to eq('Hello!')
    end

    it 'can view the categories' do
      expect_first_session(:categories).to eq(%w[Lean Agile])
      expect_second_session(:categories).to eq(%w[Hello There])
    end

    it 'can view the host' do
      expect_first_session(:host).to eq('Craig')
      expect_second_session(:host).to eq(nil)
    end

    it 'can view the session type' do
      expect_first_session(:session_type).to eq('Workshop')
      expect_second_session(:session_type).to eq('')
    end

    it 'can view the location' do
      expect_first_session(:location).to eq('London')
      expect_second_session(:location).to eq('Manchester')
    end

    it 'can view the start time' do
      expect_first_session(:start_time).to eq('14:00')
      expect_second_session(:start_time).to eq('14:01')
    end

    it 'can view the end time' do
      expect_first_session(:end_time).to eq('17:00')
      expect_second_session(:end_time).to eq('17:01')
    end
  end
end
