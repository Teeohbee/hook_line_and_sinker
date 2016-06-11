require 'jbuilder'
class StatCalculator

  def total_count
    Email.all.count
  end

  def calculate
    @totals_by_event = count_by_event
    @opened_per_type = count_by_emailtype("open")
    @clicked_per_type = count_by_emailtype("click")
    build_json(@totals_by_event, @opened_per_type, @clicked_per_type)
  end

  def build_json(events, opened, clicked)
    {
      totals: events,
      opened_per_type: opened,
      clicked_per_type: clicked
    }
  end

  def count_by_emailtype(event)
    @counts = Hash.new 0
    @emails = Email.all.select { |email| email.event == event}
    @emails.each do |email|
      @counts[email.emailtype.downcase.to_sym] += 1
    end
    @counts
  end

  def count_by_event
    @counts = Hash.new 0
    @emails = Email.all
    @emails.each do |email|
      @counts[email.event.downcase.to_sym] += 1
    end
    @counts
  end
end
