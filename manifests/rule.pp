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
# class { 'remote_backup::rule':
#       directories_to_backup => ["/var/log", "/var/www"],
#       destination => "/mnt/backup",
# }
#
class remote_backup::rule ($directories_to_backup = [], $destination = $remote_backup::mount_path, $expiration = '30') {
  include remote_backup

  package { "rdiff-backup": ensure => present }

  if $directories_to_backup {
    remote_backup::directory { $directories_to_backup: }
  }

  schedule { "hourly":
    range  => "0-23",
    period => hourly,
  }

  schedule { "daily":
    range  => "1-7",
    period => daily,
  }
}