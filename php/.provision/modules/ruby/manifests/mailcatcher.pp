class ruby::mailcatcher {
  require base::development

  exec { 'install-mailcatcher':
    command => 'sudo gem install mailcatcher --no-rdoc --no-ri',
    unless  => 'which mailcatcher'
  }

  exec { 'start-mailcatcher':
    command => 'mailcatcher --http-ip=0.0.0.0',
    unless  => 'sudo lsof -i :1025 | grep mailcatch',
    require => Exec['install-mailcatcher']
  }

  file { '/etc/init/mailcatcher.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0664',
    content => template('ruby/mailcatcher.conf.erb'),
    require => Exec['install-mailcatcher']
  }
}