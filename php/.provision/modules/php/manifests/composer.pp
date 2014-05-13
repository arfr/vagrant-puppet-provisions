class php::composer {
  exec { 'setup-composer':
    command => 'curl -sS https://getcomposer.org/installer | php &&
                  sudo mv composer.phar /usr/local/bin/composer',
    unless  => '[ -f /usr/local/bin/composer ]',
    require => [ Package['php5-cli'], Package['curl'] ]
  }
}