class php::phppgadmin {
  exec { 'setup-phppgadmin':
    command => "sudo wget --no-check-certificate https://github.com/phppgadmin/phppgadmin/archive/master.zip &&
                  sudo unzip master.zip &&
                  sudo mv phppgadmin-master /var/www/phppgadmin &&
                  sudo rm -rf master.zip",
    unless  => '[ -d /var/www/phppgadmin ]',
    require => [ Package['php5'], Package['apache2'] ]
  }

  file { '/var/www/phppgadmin/conf/config.inc.php':
    ensure  => present,
    owner   => vagrant,
    group   => vagrant,
    mode    => '0664',
    content => template('php/config.inc.php.erb'),
    require => Exec['setup-phppgadmin']
  }

  file { '/etc/apache2/sites-enabled/001-phppgadmin.conf':
    ensure  => present,
    owner   => vagrant,
    group   => vagrant,
    mode    => '0644',
    content => template('php/001-phppgadmin.conf.erb'),
    require => Exec['setup-phppgadmin'],
    notify  => Service['apache2']
  }
}