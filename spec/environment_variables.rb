# frozen_string_literal: true

shared_context 'environment variables' do
  let(:previous_env) { {} }

  def set_env(key, value)
    previous_env[key] = ENV[key]
    ENV[key] = value
  end

  after do
    previous_env.each_with_index do |(key, value)|
      ENV[key] = value
    end
  end
end
