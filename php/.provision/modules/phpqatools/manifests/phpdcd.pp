class phpqatools::phpdcd {
  exec { 'install-phpdcd':
    command => 'sudo wget --no-check-certificate https://phar.phpunit.de/phpdcd.phar &&
                sudo chmod +x phpdcd.phar &&
                sudo mv phpdcd.phar /usr/local/bin/phpdcd',
    unless  => '[ -f /usr/local/bin/phpdcd ]',
    require => Package['php-pear']
  }
}