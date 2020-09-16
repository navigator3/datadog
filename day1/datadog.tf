resource "datadog_monitor" "foo" {
  name               = "From_terraform_alert"
  type               = "log alert"
  message            = "@sergei_shevtsov@epam.com  This is spesial mail!"
  escalation_message = "Escalation message @pagerduty"

  query = "logs(\"source:httpd\").index(\"*\").rollup(\"count\").last(\"5m\") > 5"

}

resource "datadog_monitor" "too" {
  name    = "From_terraform_HTTP_Connection_lose"
  type    = "metric alert"
  message = "@sergei_shevtsov@epam.com"

  query        = "min(last_1m):avg:network.http.can_connect{*} < 1"
  notify_audit = false
  locked       = false
  timeout_h    = 0

  no_data_timeframe   = null
  require_full_window = true
  new_host_delay      = 300
  notify_no_data      = false
  renotify_interval   = 0
  escalation_message  = ""

}
