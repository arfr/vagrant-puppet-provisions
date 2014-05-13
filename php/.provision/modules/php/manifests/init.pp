class php (
  $timezone = hiera('php.timezone', 'Europe/Berlin'),
  $email = hiera('php.email', 'webmaster@localhost')
) {
  include php::composer
  include php::phpmyadmin
  include php::phppgadmin

  package { 'php5':
    ensure => installed
  }

  $packages = [
    'php5-dev',
    'php5-cli',
    'php-pear',
    'php5-mysql',
    'php5-pgsql',
    'php5-sqlite',
    'php-apc',
    'php5-intl',
    'php5-mcrypt',
    'php5-gd',
    'php5-curl',
    'php5-xdebug',
    'php5-imagick',
    'php5-imap',
    'php5-memcache',
    'php5-memcached',
    'php5-ps',
    'php5-pspell',
    'php5-recode',
    'php5-tidy',
    'php5-xmlrpc',
    'php5-xsl',
    'mcrypt'
  ]

  package { $packages:
    ensure  => installed,
    require => Package['php5'],
    notify  => Service['apache2']
  }

  file { '/etc/php5/apache2/conf.d/custom.ini':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0664',
    content => template('php/custom.ini.erb'),
    require => Package['php5'],
    notify  => Service['apache2']
  }

  file { '/etc/php5/cli/conf.d/custom.ini':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0664',
    content => template('php/custom.ini.erb'),
    require => Package['php5-cli']
  }

  $xdebug_dirs = [ '/tmp/xdebug', '/tmp/xdebug/profiler', '/tmp/xdebug/trace' ]

  file { $xdebug_dirs:
    ensure  => 'directory',
    owner   => 'vagrant',
    group   => 'www-data',
    mode    => '0777'
  }

  file { '/var/www/php':
    ensure  => 'directory',
    owner   => 'vagrant',
    group   => 'vagrant',
    mode    => '0777',
    require => Package['apache2']
  }

  # create a link ala a2ensite sites-enabled from sites-available
  # @todo: fix it
  file { '/etc/apache2/sites-enabled/001-php.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('php/001-php.conf.erb'),
    require => Package['apache2'],
    notify  => Service['apache2']
  }

  file { '/var/www/php/info.php':
    ensure  => present,
    content => '<?php phpinfo();',
    require => File['/var/www/php']
  }

  file { '/var/www/php/mail.php':
    ensure  => present,
    content => "<?php mail('${email}', 'Subject', 'Message','From: php <php@local>');",
    require => File['/var/www/php']
  }
}