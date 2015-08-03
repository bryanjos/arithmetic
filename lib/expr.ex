defmodule Expr do
  @type t ::  String.t | integer | Expr.Add.t | Expr.Mul.t

  defmodule Add do
    @type t :: %Expr.Add{ 
      left: Expr.t,
      right: Expr.t,
    }
    defstruct [:left, :right]
  end

  defmodule Mul do
    @type t :: %Expr.Mul{ 
      left: Expr.t,
      right: Expr.t,
    }
    defstruct [:left, :right]
  end

  @spec simplify1(Expr.t) :: Expr.t
  def simplify1(%Add{ left: 0, right: right}) do
    right
  end

  def simplify1(%Add{ left: left, right: 0}) do
    left
  end

  def simplify1(%Mul{ left: 1, right: right}) do
    right
  end

  def simplify1(%Mul{ left: left, right: 1}) do
    left
  end

  def simplify1(%Mul{ left: left, right: 0}) do
    0
  end

  def simplify1(%Mul{ left: 0, right: right}) do
    0
  end

  def simplify1(%Add{ left: left, right: right}) when is_number(left) and is_number(right) do
    left + right
  end

  def simplify1(%Mul{ left: left, right: right}) when is_number(left) and is_number(right) do
    left * right
  end

  def simplify1(expr) do
    expr
  end

  @spec simplify(Expr.t) :: Expr.t
  def simplify(%Add{ left: left, right: right}) do
    simplify1(%Add{ left: simplify(left), right: simplify(right) })
  end

  def simplify(%Mul{ left: left, right: right}) do
    simplify1(%Mul{ left: simplify(left), right: simplify(right) })
  end

  def simplify(expr) do
    simplify1(expr)
  end

  @spec exprStr(Expr.t) :: String.t
  def exprStr(expr) when is_number(expr) do
    to_string(expr)
  end

  def exprStr(_expr) do
    "The expression could not be simplified to a constant."
  end
end