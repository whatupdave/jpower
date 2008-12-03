class Treetop::Runtime::SyntaxNode
  def statements
    if @elements.nil?
         return []
    end 

    statements = []
    @elements.each do |e|
      statements << e.statements
    end
    statements.flatten
  end
end
