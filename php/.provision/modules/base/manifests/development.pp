class base::development {
  $packages = [
    'build-essential',
    'ruby-dev',
    'sqlite3',
    'libsqlite3-dev',
    'iptables-persistent'
  ]

  package { $packages:
    ensure => installed
  }
}