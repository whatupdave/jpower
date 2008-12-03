dir = File.dirname(__FILE__)

require 'rubygems'
require 'treetop'

require File.join(dir, 'js_grammar/nodes')

Treetop.load File.join(dir, 'js_grammar/arithmetic')
Treetop.load File.join(dir, 'js_grammar/js')