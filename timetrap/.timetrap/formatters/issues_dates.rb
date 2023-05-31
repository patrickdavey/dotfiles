['erb', 'timetrap/formatters/csv', 'timetrap/formatters/text', 'active_support/core_ext/time/calculations.rb'].each do |lib|
  begin
    require lib
  rescue LoadError => e
    puts "error loading required library: #{lib}, #{e.message}"
    exit -1
  end
end

class Issue
  attr_reader :number, :entries

  def initialize(issue_text, entries)
    @number = issue_text.match(/(?<number>\d+)/)[:number].to_i
    @entries = entries.select { |e| e.note.include?(issue_text) }
  end

  def timesheet
    Timetrap::Formatters::Text.new(entries).output
  end

  def title
    "Issue #{number}"
  end

  def id
    "issue_#{number}"
  end

  def <=>(other)
    other.number <=> number
  end
end

class Month
  attr_reader :entries, :start, :finish

  def initialize(month, entries)
    @start = month
    @finish = month.end_of_month
    @entries = entries.select { |e| (start..finish).include?(e.start) }
  end

  def timesheet
    Timetrap::Formatters::Text.new(entries).output
  end

  def title
    start.strftime("%Y-%b")
  end

  def id
    start.strftime("month-%Y-%b")
  end

  def <=>(other)
    other.start <=> start
  end
end

class Timetrap::Formatters::IssuesDates
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def output
    @complete_timesheet = Timetrap::Formatters::Text.new(entries).output
    complete_timesheet_csv = Timetrap::Formatters::Csv.new(entries).output
    File.write("./timesheet.csv", complete_timesheet_csv)

    renderer = ERB.new(File.read "/home/patrick/.timetrap/formatters/template.html.erb")
    @unique_issues = @complete_timesheet.split.join("|").scan(/\bissue_\d{3,}\b/).uniq
    @unique_issues = @unique_issues.map{|issue| Issue.new(issue, entries) }.sort
    @months = entries.map { |e| e.start.beginning_of_month }.uniq
    @months = @months.map{|month| Month.new(month, entries) }.sort
    output = renderer.result(binding)
    File.write("./index.html", output)
  end
end
