# Big Step Semantics

Small step semantics explain in granular detail how each statement or expression can be evaluated by taking only one small step to reduce the statement. We do this continuously until we get a result.
As a results we get lots of detail, but no complete explanation on how the statement is evaluated

This is the aim of Big step semantics. Each type of statement is evaluated in one swoop, straight to a result by evaluating each sub expression and combining their result to get our answer.

This feels more natural, as it moves from statement to result, but we loose the detail of how this were computed
