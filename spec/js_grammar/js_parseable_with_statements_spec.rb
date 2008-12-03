require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
 
describe "JSParser should parse" do
  include SpecParser

  before :all do
    @parser = JSParser.new
  end
  
  describe 'let' do
    it "should contain 1 statement" do
      parse('var x = 1;')

      @result.should have(1).statements
      @result.statements[0].should == (0...10)
#      @result.statements[1].should == (0...10)
    end
  end

  describe 'calling function' do
    it "should contain 1 statement" do
      parse('hey();').should have(1).statements
    end
  end

  describe 'calling function with double quoted string arg' do
    it "should contain 1 statement" do
      parse('hey("you");').should have(1).statements
    end
  end

  describe 'calling function with single quoted string arg' do
    it "should contain 1 statement" do
      parse("hey('you');").should have(1).statements
    end
  end

  describe 'calling function with hash' do
    it "should contain 1 statement" do
      parse('hey({ a:"b" });').should have(1).statements
    end
  end

  describe 'calling namespaced function' do
    it "should contain 1 statement" do
      parse('var a = $blanket.statements.add(1).result;').should have(1).statements
    end
  end

  describe 'calling function with multiple args' do
    it "should contain 1 statement" do
      parse('fn(b, { a: 1} );').should have(1).statements
    end
  end


  describe 'if with braces' do
    before do
     parse('if (true) { var x = 1; }')
    end

    it "should contain 2 statements" do
      @result.should have(2).statements
      @result.statements[0].should == (0...9)
      @result.statements[1].should == (12...22)
    end
  end

  describe 'if else with braces' do
    before do
     parse('if (true) { return 1; } else { return 0; }')
    end

    it "should contain 3 statements" do
      @result.should have(3).statements

      @result.statements[0].should == (0...9)
      @result.statements[1].should == (12...21)
      @result.statements[2].should == (31...40)
    end
  end

  describe 'if without braces' do
    before do
     parse('if (true) return 1;')
    end

    it "should contain 2 statements" do
      @result.should have(2).statements
      @result.statements[0].should == (0...9)
      @result.statements[1].should == (10...19)
    end
  end

  describe 'block' do
    before do
      parse('{ var x = 1; }')
    end

    it "should contain statements" do
      @result.should have(1).statements
      @result.statements[0].should == (2...12)
    end
  end

  describe 'assigning hash' do
    before do
      parse('var x = { a:"b" };')
    end
  
    it "should contain statements" do
      @result.should have(1).statements
      @result.statements[0].should == (0...18)
    end
  end

  describe 'assigning hash with function' do
    before do
      parse('var x = { a : function(hello) { return true; } };')
    end

    it "should contain statements" do
      @result.should have(2).statements
      @result.statements[0].should == (0...7)
      @result.statements[1].should == (32...44)
    end
  end

  describe 'assigning hash with multiple functions' do
    before do
      parse('var x = { a: function() { return 0; }, b: function() { return 1; } };')
    end

    it "should contain statements" do
      @result.should have(3).statements
      @result.statements[0].should == (0...7)
      @result.statements[1].should == (26...35)
      @result.statements[2].should == (55...64)
    end
  end

  describe "single line function" do
    before do
      parse('function hello() { var x = 1; }')
    end

    it "should contain statements" do
        @result.should have(1).statements

        @result.statements[0].should == (19...29)
    end
  end

  describe "multiline function" do
    before do
      parse("function hello() {
          var x = 1;
        }")
    end

    it "should contain statements" do
      @result.should have(1).statements
      @result.statements[0].should == (29...39)
    end
  end

  describe "function with simple arguments" do
    before do
      parse('function hello(arg1, arg2) { return arg1 > arg2; }')
    end

    it "should contain statements" do
        @result.should have(1).statements
        @result.statements[0].should == (29...48)
    end
  end

  describe "assigning anonymous function" do
    before do
      parse('var h = function(arg1) { return true; };')
    end

    it "should contain statements" do
        @result.should have(2).statements
        @result.statements[0].should == (0...7)
        @result.statements[1].should == (25...37)
    end
  end


  describe "multiple functions" do
    before do
      parse("
       function a() {
          b();
        }

        function b() {
          return 'hey';
        }")
    end

    it "should contain statements" do
      @result.should have(2).statements
      @result.statements[0].should == (35...39)
      @result.statements[1].should == (84...97)
    end
  end

  describe "for loop" do
    before do; parse('for (var i = 1; i < 10; i++) console.log(i);'); end

    it "should contain 4 statements" do
      @result.should have(4).statements
      @result.statements[0].should == (5...15)
      @result.statements[1].should == (16...23)
      @result.statements[2].should == (24...27)
      @result.statements[3].should == (29...44)
    end
  end

  describe "for..in loop" do
    before do; parse('for(var start in statements) { return true; }'); end

    it "should contain 2 statements" do
      @result.should have(2).statements
      @result.statements[0].should == (0...28)
      @result.statements[1].should == (31...43)
    end
  end

  describe "ternary" do
    before do; parse('var x = true ? "a" : "b";'); end;

    it "should contain 3 statements" do
      @result.should have(3).statements
      @result.statements[0].should == (0...12)
      @result.statements[1].should == (15...18)
      @result.statements[2].should == (21...24)
    end
  end

  describe "anonymous function call" do
    before do; parse('var a = (function(){ return true; })();'); end;

    it "should contain 1 statements" do
      @result.should have(2).statements
      @result.statements[0].should == (0...7)
      @result.statements[1].should == (21...33)
    end
  end

  describe "assigning empty function block" do
    before do
      parse('var a = function() { };')
    end

    it "should contain statements" do
      @result.should have(1).statements
    end
  end

  describe "assigning multiple functions" do
    before do
      parse('a = function() {}; b = function() {};')
    end

    it "should contain statements" do
#      @result.should have(1).statements
    end
  end

end