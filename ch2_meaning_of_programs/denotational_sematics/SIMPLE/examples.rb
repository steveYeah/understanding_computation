# The important part is what "to_ruby" returns as this is the language we are translating to
# We only call eval to see if the translation is correct. It is not the goal

# Number
proc = eval(Number.new(5).to_ruby)
proc.call({})

# Variable
expression = Variable.new(:x)
proc = eval(expression.to_ruby)
proc.call({x: 7})

# Add
environment = {x: 3}
proc = eval(Add.new(Variable.new(:x), Number.new(1)).to_ruby)
proc.call(environment)

# LessThan
environment = {x: 3}
proc = eval(LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby)
proc.call(environment)

# Assign
statement = Assign.new(:y, Add.new(Variable.new(:x), Number.new(1)))
proc = eval(statement.to_ruby)
proc.call({x: 3})

# While
statement = While.new(
  LessThan.new(Variable.new(:x), Number.new(5)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)
proc = eval(statement.to_ruby)
proc.call({x: 1})
