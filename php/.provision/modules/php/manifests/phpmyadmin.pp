class php::phpmyadmin {
  exec { 'setup-phpmyadmin':
    command => "sudo wget --no-check-certificate https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_1_14.zip &&
                sudo unzip RELEASE_4_1_14.zip &&
                sudo mv phpmyadmin-RELEASE_4_1_14 /var/www/phpmyadmin &&
                sudo mv /var/www/phpmyadmin/config.sample.inc.php /var/www/phpmyadmin/config.inc.php &&
                sudo rm -rf RELEASE_4_1_14.zip",
    unless  => '[ -d /var/www/phpmyadmin ]',
    require => [ Package['php5'], Package['apache2'] ]
  }

  file { '/etc/apache2/sites-enabled/001-phpmyadmin.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('php/001-phpmyadmin.conf.erb'),
    require => Package['apache2'],
    notify  => Service['apache2']
  }
}