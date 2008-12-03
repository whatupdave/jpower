require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe JSParser do
  include SpecParser
  
  before :all do
    @parser = JSParser.new
  end

  describe 'should be parseable with no statements'
    after(:each) do
       @result.should have(0).statements
    end

    it "empty string" do
        parse('')
    end

    it 'space characters' do
      parse('      ')
    end

    it 'multi-line space characters' do
      parse('
          ')
    end

  it "single line comment" do
    parse('// this is a comment')
    @result.should have(1).elements
  end

  it "multi line comment" do
    parse("/* this is a // * / comment
this is still a comment */")
    @result.should have(1).elements
  end

end