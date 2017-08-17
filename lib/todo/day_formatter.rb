require 'date'

module Todo
  class DayFormatter
    def self.format(date_string)
      date_string == "today" ? Date.today.strftime("%d-%m-%Y") : date_string
    end
  end
end