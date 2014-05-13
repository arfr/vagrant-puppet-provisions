class phpqatools::phpcs {
  exec { 'install-phpcs':
    command => 'sudo pear install PHP_CodeSniffer',
    unless  => 'which phpcs',
    require => Package['php-pear']
  }
}