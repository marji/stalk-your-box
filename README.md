# Stalk Your Box

This manifest was created as part of a simple demo for a presentation at DrupalCon Prague 2013:
  https://prague2013.drupal.org/session/have-you-been-stalking-your-serversrr

## Description
A small Puppet manifest to get you started with monitoring your dev LAMP server.
It installs the monitoring services on the LAMP server - so it will become the monitoring and monitored server.
Indeed, these two roles are better to split in a production environment, but even if on the same server, you can still get an email *before* bad thing happens (e.g. your root filesystem fills out) or you can analyse the graphs after a crash to see what was happening before it crashed.

Currently for Ubuntu 12.04 LTS (but likely to work on newer versions and other Debian based distributions).

## Used components
-    nagios3
-    munin, munin-node

## Requires
The box provisioned with this manifest needs to be able to deliver emails, at least to the nagios contact email address
(which is up to you to choose - it's a parameter of the nagios3 module).
The nagios3 package installs postfix as the default MTA (if none is instaled), but it probably won't get configured the way you would like. 

Apache2. Ideally, you will have a functional LAMP stack installed before using this. Apache2 is required by both munin and nagios.
If not installed, it will get installed (by requiring the apache2 package which will also install libapache2-mod-php5 if no php is installed).


## Usage
Go to the VM or server you want to provision and run the following commands.

If you don't have puppet installed, install it first:
```
sudo apt-get update && sudo apt-get --yes install puppet
```

If you don't have git installed, install it:
```
sudo apt-get update && sudo apt-get --yes install git
```

Get the repo: 
```
git clone git://github.com/marji/stalk-your-box.git /tmp/stalk-your-box
sudo mv /tmp/stalk-your-box /opt/stalk-your-box
```
Optional: edit / review manifest.pp in your favourite editor - e.g. to change the email address for nagios alerts, or perhaps to comment out the nagios or munin classes to prevent one of these components to install.

Then run puppet apply:  
```
sudo puppet apply --modulepath=/opt/puppet-drupal-box/modules /opt/puppet-drupal-box/manifest.pp'
```

The Web interface will be available at http://12.34.56.78/nagios3/ and http://12.34.56.78/munin/, where 12.34.56.78 is the IP address of the server this manifest is applied on. 

## Notes
-   If your dev server is in a home network and you don't get any emails, it might be that some providers block outgoing port 25.

-   If you have mysql installed before using this manifest, you will get up to 23 MySQL related graphs in Munin.


## Author
Marji Cermak <marji@morpht.com>, www.morpht.com
