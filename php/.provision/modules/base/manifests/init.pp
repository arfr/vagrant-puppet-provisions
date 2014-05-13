class base {
  include base::development

  $packages = [
    'curl',
    'git',
    'subversion',
    'htop',
    'tree',
    'zip',
    'unzip',
    'tmux',
    'zsh'
  ]

  package { $packages:
    ensure => installed
  }

  file { '/home/vagrant/.vimrc':
    ensure  => present,
    owner   => vagrant,
    group   => vagrant,
    content => template('base/.vimrc.erb')
  }

  file { '/root/.vimrc':
    ensure  => present,
    owner   => root,
    group   => root,
    content => template('base/.vimrc.erb')
  }

}