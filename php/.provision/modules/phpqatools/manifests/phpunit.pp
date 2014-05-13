class phpqatools::phpunit {
  exec { 'install-phpunit':
    command => 'sudo wget --no-check-certificate https://phar.phpunit.de/phpunit.phar &&
                sudo chmod +x phpunit.phar &&
                sudo mv phpunit.phar /usr/local/bin/phpunit',
    unless  => '[ -f /usr/local/bin/phpunit ]',
    require => Package['php5']
  }
}