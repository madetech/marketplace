# frozen_string_literal: true

class Domain::Session
  VISIBLE_FIELDS = %i[
    title
    categories
    host
    session_type
    location
    start_time
    end_time
  ].freeze

  attr_accessor *VISIBLE_FIELDS, :date

  def visible_fields
    VISIBLE_FIELDS
  end

  def fields
    VISIBLE_FIELDS + [:date]
  end

  def month
    Date.parse(date).strftime('%B')
  end
end
