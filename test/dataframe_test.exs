defmodule ExPolars.DataFrameTest do
  use ExUnit.Case

  alias ExPolars.DataFrame, as: Df
  alias ExPolars.Series

  test "read parquet as dataframe" do
    {:ok, df} = Df.read_parquet("test/data/testdata.parquet")
    assert Df.shape(df) == {:ok, {5, 3}}
  end

  test "read csv as dataframe" do
    {:ok, df} = Df.read_csv("test/data/testdata.csv")
    assert Df.shape(df) == {:ok, {5, 3}}
  end

  test "get column as series" do
    {:ok, df} = Df.read_parquet("test/data/testdata.parquet")
    {:ok, series} = Df.column(df, "b")
    assert Series.name(series) == {:ok, "b"}
    assert Series.len(series) == {:ok, 5}
  end

  test "slice via Access" do
    {:ok, df} = Df.read_parquet("test/data/testdata.parquet")
    assert Df.shape(df[1..3]) == {:ok, {2, 3}}
  end

  test "select columns via Access" do
    {:ok, df} = Df.read_parquet("test/data/testdata.parquet")
    assert Df.columns(df[["a", "b"]]) == {:ok, ["a", "b"]}
    assert Series.name(df["c"]) == {:ok, "c"}
  end
end