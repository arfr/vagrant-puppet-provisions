class phpqatools::pdepend {
  exec { 'install-pdepend':
    command => 'sudo wget http://static.pdepend.org/php/1.1.0/pdepend.phar &&
                sudo chmod +x pdepend.phar &&
                sudo mv pdepend.phar /usr/local/bin/pdepend',
    unless  => '[ -f /usr/local/bin/pdepend ]',
    require => Package['php5']
  }
}