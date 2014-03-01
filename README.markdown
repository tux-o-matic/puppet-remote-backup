# Puppet Remote Backup #

#### Manage hourly incremental backup of multiple folders
- Define one or multiple directories to backup and a destination.
- Module manages hourly job of incremental backup.
- Optionally use in combination with NFS to store your backups remotely in one definition.

-------

#### Example 
You can manage in a single definition a mount definition for your NFS storage and the directories to backup there.
```
 class { 'remote_backup':
       mount_path => "/mnt/backup,"
       nfs_server_ip => "10.0.0.1",
       nfs_server_path => "my_nfs_storage",
       backup_rule => {
         directories_to_backup => ["/var/log", "/var/www"],
      },
 }
```

By default the backup retention is set for 30 days, new incremental backup are generated every hour.
This module has only be tested on RedHat based distributions. Using it on other systems is possible but might require adapting the package name of the dependencies.

