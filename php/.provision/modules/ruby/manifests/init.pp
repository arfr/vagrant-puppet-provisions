class ruby {
  include ruby::mailcatcher

  #  exec { 'install-rvm':
  #    command => 'curl -sSL https://get.rvm.io | bash -s stable &&
  #                source .profile &&
  #                rvm reload &&
  #                rvm install 2.1.1 &&
  #                rvm use 2.1.1 --default',
  #    timeout => 1200
  #  }
}