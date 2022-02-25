class DoNothing
  def reducible?
    false
  end

  def ==(other_statement)
    other_statement.instance_of?(DoNothing)
  end

  def to_s
    'do-nothing'
  end

  def inspect
    "<<#{self}>>"
  end
end

class Assign < Struct.new(:name, :expression)
  def reducible?
    true
  end

  def reduce(environment)
    if expression.reducible?
      [Assign.new(name, expression.reduce(environment)), environment]
    else
      [DoNothing.new, environment.merge({name => expression})]
    end
  end

  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  def reducible?
    true
  end

  def reduce(environment)
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition
      when Boolean.new(true)
        [consequence, environment]
      when Boolean.new(false)
        [alternative, environment]
      end
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
  def reducible?
    true
  end

  def reduce(environment)
    case first
    when DoNothing.new
      [second, environment]
    else
      reduced_first, reduced_environment = first.reduce(environment)
      [Sequence.new(reduced_first, second), reduced_environment]
    end
  end

  def to_s
    "#{first}; #{second}"
  end

  def inspect
    "<<#{self}>>"
  end
end

class While < Struct.new(:condition, :body)
  def reducible?
    true
  end

  def reduce(environment)
    [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
  end

  def to_s
    "while (#{condition}) { #{body} }"
  end

  def inspect
    "<<#{self}>>"
  end
end
