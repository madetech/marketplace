# frozen_string_literal: true

group 'tests' do
  guard :rspec, cmd: '(bundle exec rubocop -a || true) && bundle exec rspec' do
    watch(%r{^.*?/(.+)\.rb$}) { 'spec' }
  end
end

group 'serve' do
  guard :livereload do
    watch(%r{^.*?/(.+)\.(rb|erb|html|css|js)$})
  end
end
