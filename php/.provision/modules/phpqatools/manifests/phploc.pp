class phpqatools::phploc {
  exec { 'install-phploc':
    command => 'sudo wget --no-check-certificate https://phar.phpunit.de/phploc.phar &&
                sudo chmod +x phploc.phar &&
                sudo mv phploc.phar /usr/local/bin/phploc',
    unless  => '[ -f /usr/local/bin/phploc ]',
    require => Package['php5']
  }
}