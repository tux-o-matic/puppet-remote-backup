[![Build Status](https://travis-ci.org/tux-o-matic/puppet-remote-backup.png?branch=master)](https://travis-ci.org/tux-o-matic/puppet-remote-backup)

# Puppet Remote Backup

## Manage hourly incremental backup of multiple folders
- Define one or multiple directories to backup.
- The module will automatically run hourly jobs for incremental backup (using rdiff).
- Optionally use in combination with NFS to store your backups remotely all in one definition.

## Example 
You can manage in a single definition a mount definition for your NFS storage and the directories to backup there.
```shell
 class { 'remote_backup':
       mount_path      => '/mnt/backup',
       nfs_server_ip   => '10.0.0.1',
       nfs_server_path => 'my_nfs_storage',
       backup_rule => {
         directories_to_backup => ['/var/log', '/var/www'],
      },
 }
```

Simple hourly incremental backup from one or more folder/partition to another
```shell
 class { 'remote_backup::rule':
       directories_to_backup => ['/var/log', '/var/www'],
       destination           => '/data',       
 }
```

By default the backup retention is set for 30 days.
This module has only been tested on RedHat based distributions. Using it on other systems is possible but might require adapting the package name of the dependencies.

