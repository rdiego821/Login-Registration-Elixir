import Config

config :ms_login_registration_e,
  timezone: "America/Bogota",
  env: :dev,
  http_port: 8083,
  enable_server: true,
  version: "0.0.1",
  custom_metrics_prefix_name: "ms_login_registration_e_local"

config :logger,
  level: :debug
