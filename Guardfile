# frozen_string_literal: true

guard :rspec, cmd: '(bundle exec rubocop -a || true) && bundle exec rspec' do
  watch(%r{^.*?/(.+)\.rb$}) { 'spec' }
end
