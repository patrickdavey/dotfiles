require "pp"
require "irb/completion"

# interactive editor: use vim/subl/etc from within irb
begin
  require "interactive_editor"
rescue LoadError
end

# awesome print
begin
  require "awesome_print"
  AwesomePrint.irb! if AwesomePrint.respond_to?(:irb!)
rescue LoadError
end

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV["HOME"]}/.irb-save-history"
IRB.conf[:USE_AUTOCOMPLETE] = false
IRB.conf[:ECHO_ON_ASSIGNMENT] = true

# Simple regular expression helper
# show_regexp - stolen from the pickaxe
def show_regexp(a, re)
  if a =~ re
    "#{$`}<<#{$&}>>#{$'}"
  else
    "no match"
  end
end

# Convenience method on Regexp so you can do
# /an/.show_match("banana") # => "b<>ana"
class Regexp
  def show_match(a)
    show_regexp(a, self)
  end
end

# Method to pretty-print object methods
# Coded by sebastian delmont
# http://snippets.dzone.com/posts/show/2916
class Object
  ANSI_BOLD       = "\033[1m"
  ANSI_RESET      = "\033[0m"
  ANSI_LGRAY    = "\033[0;37m"
  ANSI_GRAY     = "\033[1;30m"

  # Print object's methods
  def pm(*options)
    methods = self.methods
    methods -= Object.methods unless options.include? :more
    filter = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter

    data = methods.sort.collect do |name|
      method = self.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{ANSI_BOLD}#{item[0].to_s.rjust(max_name)}#{ANSI_RESET}"
      print "#{ANSI_LGRAY}#{item[1].to_s.ljust(max_args)}#{ANSI_RESET}"
      print "   #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
    end
    data.size
  end
end

def log_to_stdout
  if Object.const_defined?('Rails')
    Rails.logger.instance_variable_set("@log", STDOUT)
  end
end

log_to_stdout
