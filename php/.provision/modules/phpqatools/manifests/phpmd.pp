class phpqatools::phpmd {
  exec { 'install-phpmd':
    command => 'sudo wget --no-check-certificate http://static.phpmd.org/php/1.5.0/phpmd.phar &&
                sudo chmod +x phpmd.phar &&
                sudo mv phpmd.phar /usr/local/bin/phpmd',
    unless  => '[ -f /usr/local/bin/phpmd ]',
    require => Exec['install-pdepend']
  }
}