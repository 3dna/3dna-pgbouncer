# == Class pgbouncer::service
#
# This class is meant to be called from pgbouncer
# It ensure the service is running
#
class pgbouncer::service inherits pgbouncer {

  service { $pgbouncer::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => "/usr/sbin/service ${::pgbouncer::service_name} reload",
  }
}
