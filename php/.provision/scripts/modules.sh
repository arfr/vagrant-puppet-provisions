#!/bin/sh

module_list=`puppet module list`

if ! echo $module_list | grep -q puppetlabs-stdlib; then
    puppet module install puppetlabs-stdlib --version 3.2.1 --force
fi

if ! echo $module_list | grep -q puppetlabs-apt; then
    puppet module install puppetlabs-apt --version 1.4.2 --force
fi

if ! echo $module_list | grep -q puppetlabs-mysql; then
    puppet module install puppetlabs-mysql --version 2.2.3 --force
fi

if ! echo $module_list | grep -q puppetlabs-firewall; then
    puppet module install puppetlabs-firewall --version 1.0.2 --force
fi

if ! echo $module_list | grep -q puppetlabs-concat; then
    puppet module install puppetlabs-concat --version 1.0.2 --force
fi

if ! echo $module_list | grep -q puppetlabs-postgresql; then
    puppet module install puppetlabs-postgresql --version 3.3.3 --force
fi