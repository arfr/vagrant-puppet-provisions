class samba {
  package { 'samba':
    ensure => installed
  }

  service { 'smbd':
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    alias       => 'samba',
    require     => Package['samba']
  }

  file { '/etc/samba/smb.conf':
    ensure    => present,
    replace   => true,
    owner     => root,
    group     => root,
    content   => template('samba/smb.conf.erb'),
    require   => [ Package['samba'], Package['apache2'] ],
    notify    => Service['samba']
  }

  exec { 'add-smb-user':
    command => 'sudo echo -e "vagrant\nvagrant" | smbpasswd -s -a vagrant',
    require => Package['samba'],
    notify  => Service['samba']
  }
}