class phpqatools::phpdox {
  exec { 'install-phpdox':
    command => 'sudo wget http://phpdox.de/releases/phpdox.phar &&
                sudo chmod +x phpdox.phar &&
                sudo mv phpdox.phar /usr/local/bin/phpdox',
    unless  => '[ -f /usr/local/bin/phpdox ]',
    require => Package['php-pear']
  }
}