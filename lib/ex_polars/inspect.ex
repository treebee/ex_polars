defimpl Inspect, for: ExPolars.DataFrame do
  alias ExPolars.DataFrame
  import Inspect.Algebra

  def inspect(data, _opts) do
    case DataFrame.as_str(data) do
      {:ok, s} -> s
      _ -> "Cannot output dataframe"
    end
  end
end