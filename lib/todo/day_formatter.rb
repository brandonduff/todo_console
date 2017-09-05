require 'date'

module Todo
  class DayFormatter
    def self.format(date_string)
      if date_string =~ /\d+-\d+/
        Date.parse(date_string + "-#{Date.today.strftime("%Y")}").strftime("%d-%m-%Y")
      elsif date_string == "today" || date_string == ""
        Date.today.strftime("%d-%m-%Y")
      else
        Date.parse(date_string).strftime("%d-%m-%Y")
      end
    end
  end
end
