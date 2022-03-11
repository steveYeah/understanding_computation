statement = Sequence.new(
Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
Assign.new(:y, Multiply.new(Variable.new(:x), Number.new(3)))
)

statement = While.new(
LessThan.new(Variable.new(:x), Number.new(5)),
Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)

statement.evaluate({x: Number.new(1)})
