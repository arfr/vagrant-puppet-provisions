class apache {
  package { 'apache2':
    ensure => installed
  }

  service { 'apache2':
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    require     => Package['apache2']
  }

  exec { 'enable-mod-rewrite':
    command => 'sudo a2enmod rewrite',
    unless  => 'ls -al /etc/apache2/mods-enabled/ | grep rewrite',
    require => Package['apache2'],
    notify  => Service['apache2']
  }

  exec { 'add-default-charset':
    command => 'sed -i s/#AddDefaultCharset/AddDefaultCharset/ /etc/apache2/conf-available/charset.conf',
    require => Package['apache2'],
    notify  => Service['apache2']
  }

  exec { 'add-server-name':
    command => 'echo ServerName localhost >> /etc/apache2/apache2.conf',
    unless  => "grep 'ServerName localhost' /etc/apache2/apache2.conf",
    require => Package['apache2'],
    notify  => Service['apache2']
  }

  # recurse is bad, very bad, have to find better solution
  # for production maybe okay, but not for the development the provision takes to long
  file { "/var/www/vagrant":
    ensure  => directory,
    recurse => true,
    mode    => '0777',
    owner   => 'vagrant',
    group   => 'vagrant',
    require => Package['apache2']
  }

  file { '/etc/apache2/sites-available/000-default.conf':
    ensure    => present,
    replace   => true,
    owner     => root,
    group     => root,
    content   => template('apache/000-default.conf.erb'),
    require   => [ Package['apache2'], File['/var/www/vagrant'] ],
    notify    => Service['apache2']
  }
}