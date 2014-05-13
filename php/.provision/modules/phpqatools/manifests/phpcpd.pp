class phpqatools::phpcpd {
  exec { 'install-phpcpd':
    command => 'sudo wget --no-check-certificate https://phar.phpunit.de/phpcpd.phar &&
                sudo chmod +x phpcpd.phar &&
                sudo mv phpcpd.phar /usr/local/bin/phpcpd',
    unless  => '[ -f /usr/local/bin/phpcpd ]',
    require => Package['php-pear']
  }
}