# == Class: pgbouncer
#
# Full description of class pgbouncer here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class pgbouncer (
  $package_name              = $pgbouncer::params::package_name,
  $service_name              = $pgbouncer::params::service_name,
  $logfile                   = $pgbouncer::params::logfile,
  $pidfile                   = $pgbouncer::params::pidfile,
  $configfile                = $pgbouncer::params::configfile,
  $listen_addr               = '127.0.0.1',
  $listen_port               = '6432',
  $unix_socket_dir           = $pgbouncer::params::unix_socket_dir,
  $unix_socket_mode          = undef,
  $unix_socket_group         = undef,
  $auth_type                 = 'trust',
  $auth_file                 = $pgbouncer::params::auth_file,
  $admin_users               = [],
  $stats_users               = [],
  $pool_mode                 = 'session',
  $server_reset_query        = 'DISCARD ALL',
  $ignore_startup_parameters = [],
  $server_check_query        = undef,
  $server_check_delay        = undef,
  $max_client_conn           = 100,
  $default_pool_size         = 20,
  $min_pool_size             = undef,
  $reserve_pool_size         = undef,
  $reserve_pool_timeout      = undef,
  $log_connections           = undef,
  $log_disconnections        = undef,
  $log_pooler_errors         = undef,
  $server_round_robin        = undef,
  $server_lifetime           = undef,
  $server_idle_timeout       = undef,
  $server_connect_timeout    = undef,
  $server_login_retry        = undef,
  $query_timeout             = undef,
  $query_wait_timeout        = undef,
  $client_idle_timeout       = undef,
  $client_login_timeout      = undef,
  $autodb_idle_timeout       = undef,
  $pkt_buf                   = undef,
  $listen_backlog            = undef,
  $tcp_defer_accept          = undef,
  $tcp_socket_buffer         = undef,
  $tcp_keepalive             = undef,
  $tcp_keepcnt               = undef,
  $tcp_keepidle              = undef,
  $tcp_keepintvl             = undef,
  $dns_max_ttl               = undef,
  $dns_zone_check_period     = undef,
) inherits pgbouncer::params {

  # validate parameters here
  validate_array($admin_users)
  validate_array($stats_users)
  validate_array($ignore_startup_parameters)

  include pgbouncer::install
  include pgbouncer::config
  include pgbouncer::service

  anchor { ['pgbouncer::begin', 'pgbouncer::end']: }
  Anchor['pgbouncer::begin'] -> Class['pgbouncer::install'] -> Class['pgbouncer::config'] ~> Class['pgbouncer::service'] -> Anchor['pgbouncer::end']

}
