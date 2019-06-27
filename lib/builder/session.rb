# frozen_string_literal: true

class Builder::Session
  def initialize
    @session = Domain::Session.new

    generate_methods
  end

  def with_block(&block)
    instance_eval(&block)
    self
  end

  def build
    @session.fields.each do |f|
      @session.send "#{f}=", instance_variable_get("@#{f}")
    end
    @session
  end

  private

  def generate_methods
    @session.fields.each do |f|
      self.class.define_method "with_#{f}" do |v|
        instance_variable_set("@#{f}", v)
        self
      end
    end
  end
end
