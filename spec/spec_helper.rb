dir = File.dirname(__FILE__)

require 'rubygems'
require 'treetop'
require 'spec'
 
load File.join(dir, '..', 'lib', 'js_grammar.rb')
load File.join(dir, '..', 'lib', 'weaver.rb')

Spec::Runner.configure do |config|

end

module SpecParser
  def parse(string)
    @result = @parser.parse(string)
    if @result.nil?
      nil.should equal(@parser.failure_reason)
    end
    @result
  end
end

class RequireA
  def initialize(line_number, start_column, length)
    @line_number = line_number
    @start_column = start_column
    @length = length
  end

  def matches?(target)
    target[:line_number].should == 0
    target[:start_column].should == 0
    target[:length].should == 10
  end

#  def failure_message
#    "expected #{@target.inspect} to require presence of #{@expected}"
#  end
#
#  def negative_failure_message
#    "expected #{@target.inspect} not to require presence of #{expected}"
#  end
end

