class phpqatools::behat {
  exec { 'install-behat':
    command => 'sudo wget http://behat.org/downloads/behat.phar &&
                sudo chmod +x behat.phar &&
                sudo mv behat.phar /usr/local/bin/behat',
    unless  => '[ -f /usr/local/bin/behat ]',
    require => Package['php5']
  }
}