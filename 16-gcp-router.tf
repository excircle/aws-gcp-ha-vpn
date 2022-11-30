variable "router_advertise_config" {
  description = "Router custom advertisement configuration, ip_ranges is a map of address ranges and descriptions. More info can be found here https://www.terraform.io/docs/providers/google/r/compute_router.html#bgp (Default:  null)"
  default     = null

  type = object({
    groups    = list(string)
    ip_ranges = map(string)
    mode      = string
  })
}

resource "google_compute_router" "router" {
  provider    = google-beta
  name        = "cr-to-aws-tgw-ha-vpn-${data.aws_region.current.name}-akalaj"
  network     = "default"
  description = "Google to AWS via Transit GW connection for AWS region ${data.aws_region.current.name}"
  bgp {
    asn = 64512
    advertise_mode = (
      var.router_advertise_config == null
      ? null
      : var.router_advertise_config.mode
    )
    advertised_groups = (
      var.router_advertise_config == null ? null : (
        var.router_advertise_config.mode != "CUSTOM"
        ? null
        : var.router_advertise_config.groups
      )
    )
    dynamic "advertised_ip_ranges" {
      for_each = (
        var.router_advertise_config == null ? {} : (
          var.router_advertise_config.mode != "CUSTOM"
          ? null
          : var.router_advertise_config.ip_ranges
        )
      )
      iterator = range
      content {
        range       = range.key
        description = range.value
      }
    }
  }
}
