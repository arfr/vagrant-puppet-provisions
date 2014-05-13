class exim {
  package { 'exim4':
    ensure => installed
  }

  service { 'exim4':
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    subscribe   => File['config'],
    require     => Package['exim4']
  }

  file { '/etc/exim4/update-exim4.conf.conf':
    ensure    => present,
    replace   => true,
    owner     => root,
    group     => root,
    alias     => 'config',
    content   => template('exim/update-exim4.conf.conf.erb'),
    require   => Package['exim4']
  }

  exec { 'update-exim4.conf':
    command   => 'sudo update-exim4.conf',
    subscribe => File['config'],
    require   => Package['exim4']
  }
}