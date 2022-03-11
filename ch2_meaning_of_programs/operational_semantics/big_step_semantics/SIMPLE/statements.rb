class DoNothing
  def evaluate(environment)
    environment
  end
end

class Assign < Struct.new(:name, :expression)
  def evaluate(environment)
    environment.merge({ name => expression.evaluate(environment) })
  end

  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      consequence.evaluate(environment)
    when Boolean.new(false)
      alternative.evaluate(environment)
    end
  end

  def to_s
    "if (#{condition}) then {#{consequence}} else {#{alternative}}"
  end

  def inspect
    "<<#{self}>>"
  end
end

class Sequence < Struct.new(:first, :second)
  def evaluate(environment)
    second.evaluate(first.evaluate(environment))
  end

  def to_s
    "#{first}; #{second}"
  end

  def inspect
    "<<#{self}>>"
  end
end

class While < Struct.new(:condition, :body)
  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      evaluate(body.evaluate(environment))
    when Boolean.new(false)
      environment
    end
  end

  def to_s
    "while (#{condition}) { #{body} }"
  end

  def inspect
    "<<#{self}>>"
  end
end
