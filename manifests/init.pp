#    Puppet module to manage incremental backup.
#    Copyright (C) 2014  Benjamin Merot (ben@busyasabee.org)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Parameters:
# directories_to_backup: An array of directory to backup with their full path
# destination: The path to recreate the structure and place the backup. For example, for a backup of /var/www to /mnt/backup, the result will be /mnt/backup/var/www.
# expiration: The retention period in days.
#
# Sample Usage:
# class { 'remote_backup':
#       mount_path => "/mnt/backup,"
#       nfs_server_ip => "10.0.0.1",
#       nfs_server_path => "my_nfs_storage",
#       backup_rule => {
#         directories_to_backup => ["/var/log", "/var/www"],
#      },
# }
#
# If the parent of the mount path does not exist, recent version of Puppet will throw an error until the path is created.
#
class remote_backup (
  $mount_path           = '/mnt/backup',
  $nfs_server_ip        = '',
  $nfs_server_path      = '',
  $mount_on_boot        = true,
  $replace              = false,
  $backup_rule          = {
  }
) {
  Class['remote_backup'] -> Class['remote_backup::rule']

  $rule_class = {
    'remote_backup::rule' => $backup_rule
  }

  create_resources('class', $rule_class)

  package { 'nfs-utils': ensure => present }

  file { $mount_path:
    ensure  => 'directory',
    replace => $replace,
  }

  mount { $mount_path:
    ensure  => 'mounted',
    name    => $mount_path,
    device  => "${nfs_server_ip}:/${nfs_server_path}",
    fstype  => 'nfs',
    options => 'nolock',
    atboot  => $mount_on_boot,
    require => Package['nfs-utils'],
  }

}
