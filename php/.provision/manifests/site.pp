Exec { path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin' }

include base
include apache
include php
include phpqatools
include exim
include ruby::mailcatcher
#include ruby
include samba

class { '::mysql::server':
  override_options => hiera_hash('mysql::server::override_options')
}

include mysql::client

mysql_grant { 'root@%/*.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'root@%',
  require    => Class['mysql::server']
}
->
mysql_user { 'root@%':
  ensure                   => 'present',
  max_connections_per_hour => '0',
  max_queries_per_hour     => '0',
  max_updates_per_hour     => '0',
  max_user_connections     => '0',
  password_hash            => mysql_password(hiera('mysql::server::root_password'))
}

class { 'postgresql::globals':
  version             => '9.3',
  manage_package_repo => true,
  encoding            => 'UTF8',
  locale              => 'en_US'
}
->
class { 'postgresql::server':
  ip_mask_deny_postgres_user => hiera('postgresql::ip_mask_deny_postgres_user'),
  ip_mask_allow_all_users    => hiera('postgresql::ip_mask_allow_all_users'),
  listen_addresses           => hiera('postgresql::listen_addresses'),
  postgres_password          => hiera('postgresql::postgres_password')
}