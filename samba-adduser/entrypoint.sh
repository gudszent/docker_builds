#!/bin/bash

CONFIG_FILE="/etc/samba/smb.conf"
FIRSTTIME=true

  while getopts ":u:s:h" opt; do
    case $opt in
      h)
        cat <<EOH
Samba server container

ATTENTION: This is a recipe highly adapted to my needs, it might not fit yours.
Deal with local filesystem permissions, container permissions and Samba permissions is a Hell, so I've made a workarround to keep things as simple as possible.
I want avoid that the usage of this conainer would affect current file permisions of my local system, so, I've "synchronized" the owner of the path to be shared with Samba user. This mean that some commitments and limitations must be assumed.

Container will be configured as samba sharing server and it just needs:
 * host directories to be mounted,
 * users (one or more uid:gid:username:usergroup:password tuples) provided,
 * shares defined (name, path, users).

 -u uid:gid:username:usergroup:password         add uid from user p.e. 1000
                                                add gid from group that user belong p.e. 1000
                                                add a username p.e. alice
                                                add a usergroup (wich user must belong) p.e. alice
                                                protected by 'password' (The password may be different from the user's actual password from your host filesystem)

 -s name:path:rw:user1[,user2[,userN]]
                              add share, that is visible as 'name', exposing
                              contents of 'path' directory for read+write (rw)
                              or read-only (ro) access for specified logins
                              user1, user2, .., userN

To adjust the global samba options, create a volume mapping to /config

Example:
docker run -d -p 445:445 \\
  -- hostname any-host-name \\ # Optional
  -v /any/path:/share/data \\ # Replace /any/path with some path in your system owned by a real user from your host filesystem
  elswork/samba \\
  -u "1000:1000:alice:alice:put-any-password-here" \\ # At least the first user must match (password can be different) with a real user from your host filesystem
  -u "1001:1001:bob:bob:secret" \\
  -u "1002:1002:guest:guest:guest" \\
  -s "Backup directory:/share/backups:rw:alice,bob" \\ 
  -s "Alice (private):/share/data/alice:rw:alice" \\
  -s "Bob (private):/share/data/bob:rw:bob" \\
  -s "Documents (readonly):/share/data/documents:ro:guest,alice,bob"

EOH
        exit 1
        ;;
      u)
        echo -n "Add user "
        IFS=: read uid group username groupname password <<<"$OPTARG"
        echo -n "'$username' "
        if [[ $FIRSTTIME ]] ; then
          id -g "$group" &>/dev/null || id -gn "$groupname" &>/dev/null || addgroup -g "$group" -S "$groupname"
          id -u "$uid" &>/dev/null || id -un "$username" &>/dev/null || adduser -u "$uid" -G "$groupname" "$username" -SHD
          FIRSTTIME=false
        fi
        echo -n "with password '$password' "
        echo "$password" |tee - |smbpasswd -s -a "$username"
        echo "DONE"
        ;;
      :)
        echo "Option -$OPTARG requires an argument."
        exit 1
        ;;
    esac
  done
nmbd -D
exec ionice -c 3 smbd -FS --no-process-group --configfile="$CONFIG_FILE" < /dev/null