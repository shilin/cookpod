defmodule CookpodWeb.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      # Telemetry poller will execute the given period measurements
      # every 10_000ms. Learn more here: https://hexdocs.pm/telemetry_metrics
      {:telemetry_poller, measurements: periodic_measurements(), period: 10_000},
      # Add reporters as children of your supervision tree.
      # {Telemetry.Metrics.ConsoleReporter, metrics: metrics()}
      {TelemetryMetricsPrometheus, metrics: metrics()}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def metrics do
    [
      # Phoenix Metrics
      last_value("phoenix.endpoint.stop.duration",
        unit: {:native, :millisecond}
      ),
      last_value("phoenix.router_dispatch.stop.duration",
        tags: [:route],
        unit: {:native, :millisecond}
      ),

      # Database Metrics
      last_value("cookpod.repo.query.total_time",
        unit: {:native, :millisecond},
        description: "The last value of the other measurements"
      ),
      last_value("cookpod.repo.query.decode_time",
        unit: {:native, :millisecond},
        description: "The last value of spent decoding the data received from the database"
      ),
      last_value("cookpod.repo.query.query_time",
        unit: {:native, :millisecond},
        description: "The last value of time spent executing the query"
      ),
      last_value("cookpod.repo.query.queue_time",
        unit: {:native, :millisecond},
        description: "The last value of time spent waiting for a database connection"
      ),
      last_value("cookpod.repo.query.idle_time",
        unit: {:native, :millisecond},
        description:
          "The last value of time the connection spent waiting before being checked out for the query"
      ),

      # VM Metrics
      last_value("vm.memory.total", unit: {:byte, :kilobyte}),
      last_value("vm.total_run_queue_lengths.total"),
      last_value("vm.total_run_queue_lengths.cpu"),
      last_value("vm.total_run_queue_lengths.io")
    ]
  end

  defp periodic_measurements do
    [
      # A module, function and arguments to be invoked periodically.
      # This function must call :telemetry.execute/3 and a metric must be added above.
      # {<%= web_namespace %>, :count_users, []}
    ]
  end
end
