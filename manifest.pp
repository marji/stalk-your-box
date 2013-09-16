# == Manifest: manifest.pp
#
# Installs nagios3, munin and dependencies.
#  
# For Debian based systems.
#
# === Details:
#
# This manifest was created as a simple demo for a presentation at DrupalCon Prague 2013:
#   https://prague2013.drupal.org/session/have-you-been-stalking-your-servers
#
# Tested on Ubuntu 12.04 LTS
#
# === Requires:
#
# Configured MTA. Otherwise, the nagios3 package will install (but probably won't configure the way you would like) postfix.
#
# Please see README.md for other details.
#
# === Authors
#
# Marji Cermak <marji@morpht.com>, www.morpht.com
#


# Execute apt-get update before any package is installed:
exec { 'apt-update':
    command => '/usr/bin/apt-get update',
    unless  => '/usr/bin/test $(find /var/cache/apt/pkgcache.bin -mtime 0 | wc -l ) -eq 1',
    # but don't run in if more than once a day.
}
Exec['apt-update'] -> Package <| |>


class { 'munin::node': }
class { 'munin::server':
  htuser => 'marji',
  htpass => 'Prague2013'
} 

class { 'nagios::server':
  contact_email => 'cermak.m@gmail.com',
  htpass        => 'Prague2013'
}
