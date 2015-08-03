defmodule ArithmeticTest do
  use ExUnit.Case
  alias Expr.Add
  alias Exp.Mul

  test "solves problem" do
    result = %Add{
      left: %Mul{
        left: %Add{
          left: 1,
          right: %Mul{
            left: 0,
            right: "x"
          }
        },
        right: 3
      },
      right: 12
    }
    |> Expr.simplify
    |> Expr.exprStr

    assert result == "15"
  end
end
