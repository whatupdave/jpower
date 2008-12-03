class Weaver
  CODE_CALL = "JPower.code"
  ADD_CALL = "JPower.add"
  RECORD_CALL = "JPower.record"

  attr_reader :javascript
  def weave(file_name, javascript)
    parser = JSParser.new
    parse_tree = parser.parse(javascript)

    if parse_tree.nil?
       
      raise "Couldn't parse #{file_name}\n#{parser.failure_reason}\n\n  Source\n----------\n#{with_line_numbers(javascript)}"
    end

    statements = parse_tree.statements

    out_file = "#{CODE_CALL}('#{file_name}', '#{encode_javascript(javascript)}');\n"
    statements.each do |statement|
      out_file << "#{ADD_CALL}('#{file_name}', #{statement.begin}, #{statement.end - statement.begin});"
    end
    out_file << "\n"
    index = 0
    statements.each do |statement|
      out_file << javascript[index...statement.begin]
      out_file << "#{RECORD_CALL}('#{file_name}', #{statement.begin});"
      out_file << javascript[statement]
      index = statement.end
    end
    out_file << javascript[index, javascript.length - index]
  end

  def encode_javascript(js)
    js.gsub(/\r\n/,"\\r\\n").gsub(/[']/, '\\\\\'')
  end

  def with_line_numbers(js)
    i = 0
    with_lines = ""
    js.each_line do |line|
      i += 1
      with_lines << "#{i}\t#{line}"
    end
    with_lines
  end
end