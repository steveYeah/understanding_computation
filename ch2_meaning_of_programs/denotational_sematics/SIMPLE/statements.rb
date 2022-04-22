class DoNothing
  def to_ruby
    " -> e { e }"
  end
end

class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end

  def to_ruby
    " -> e { e.merge( { #{name.inspect} => (#{expression.to_ruby}).call(e) } ) }"
  end

end

class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) then {#{consequence}} else {#{alternative}}"
  end

  def inspect
    "<<#{self}>>"
  end

  def to_ruby
    " -> e { if (#{condition.to_ruby}).call(e) " +
      " then (#{consequence.to_ruby}).call(e) " +
      " else (#{consequence.to_ruby}).call(e) " +
      " end }"
  end
end

class Sequence < Struct.new(:first, :second)
  def to_s
    "#{first}; #{second}"
  end

  def inspect
    "<<#{self}>>"
  end

  def to_ruby
    " -> e { (#{second.to_ruby}).call((#{first.to_ruby}).call(e)) }"
  end
end

class While < Struct.new(:condition, :body)
  def to_s
    "while (#{condition}) { #{body} }"
  end

  def inspect
    "<<#{self}>>"
  end

  def to_ruby
    " -> e {" +
      " while (#{condition.to_ruby}).call(e); e = (#{body.to_ruby}).call(e); end;" +
      " e" +
      " }"
  end
end
