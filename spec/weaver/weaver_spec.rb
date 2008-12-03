require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Weaver should weave" do

  before(:each) do
      @weaver = Weaver.new
  end

  it "single statement" do
    result = @weaver.weave('test.js', 'var a = 1;')

    result.should == "JPower.code('test.js', 'var a = 1;');\nJPower.add('test.js', 0, 10);\nJPower.record('test.js', 0);var a = 1;"
  end

  it "multiple statements" do
    js = <<-EOS
var a = 1;
var b = 3;
EOS
    result = @weaver.weave('test.js', js )
     result.should == <<-EOS
JPower.code('test.js', 'var a = 1;\nvar b = 3;\n');
JPower.add('test.js', 0, 10);JPower.add('test.js', 11, 10);
JPower.record('test.js', 0);var a = 1;
JPower.record('test.js', 11);var b = 3;
EOS
  end
end

describe 'Weaver should encode' do
  before(:each) do
      @weaver = Weaver.new
  end
  
  it 'statement with quote' do
    result = @weaver.encode_javascript("alert('hello world');")

    result.should == "alert(\\'hello world\\');"
  end
end