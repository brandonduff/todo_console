require 'date'

module Todo
  class DayFormatter
    def self.format(date_string)
      if date_string == "today" || date_string == ""
        Date.today.strftime("%d-%m-%Y")
      else
        date_string
      end
    end
  end
end
