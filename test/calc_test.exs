defmodule CalcTest do
  use ExUnit.Case

  test "is a process" do
    calc = spawn(&Calc.start/0)
    assert Process.alive?(calc)

    Process.exit(calc, :exit)
    refute Process.alive?(calc)
  end

  test "starts with zero" do
    calc = spawn(&Calc.start/0)

    send(calc, {:print, self()})
    assert_receive 0
  end

  test "adding" do
    calc = spawn(&Calc.start/0)

    send(calc, {:+, 1})
    send(calc, {:+, 1})

    send(calc, {:print, self()})
    assert_receive 2
  end

  test "substracting" do
    calc = spawn(&Calc.start/0)

    send(calc, {:-, 1})
    send(calc, {:-, 1})

    send(calc, {:print, self()})
    assert_receive -2
  end

  test "sending anything else does not crash the calc" do
    calc = spawn(&Calc.start/0)

    send(calc, :hello)
    send(calc, nil)
    send(calc, [])

    send(calc, {:print, self()})
    assert_receive 0

    assert Process.alive?(calc)
  end
end
