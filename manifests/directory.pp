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
define remote_backup::directory () {
  include remote_backup::rule

  $program = "/usr/bin/rdiff-backup --create-full-path"
  $destination = "${remote_backup::rule::destination}${name}"
  $backupcmd = "${program} ${name} ${destination}"
  $cleanupcommand = "/usr/bin/rdiff-backup --force --remove-older-than ${remote_backup::rule::expiration}D ${destination}"

  exec { $backupcmd:
    schedule => "hourly",
    timeout  => 10000,
    require  => Package["rdiff-backup"],
  }

  exec { $cleanupcommand:
    schedule => "daily",
    timeout  => 9000
  }

}