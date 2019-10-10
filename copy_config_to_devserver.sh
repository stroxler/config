# WHAT IS THIS?
#
# This is an internal script that I use to copy some scripts
# to my servers internally at work. I'm keeping it in my config repo
# for now though, because none of the details are proprietary, and having
# this as a working example is pretty important going forward; rsync + reusing
# ssh connections has been a huge pain point and I always have to re-teach it
# to myself
set -e
set -x

# clear out the likely out-of-date known key
### cat  /Users/stroxler/.ssh/known_hosts | grep -v stroxler.sb.facebook.com >  /Users/stroxler/.ssh/known_hosts

devserver=${1}

# open an ssh connection we can reuse
if [[ "$2" != "--reuse-ssh" ]]; then
    ssh -nNf -o StrictHostKeyChecking=no -o ControlMaster=yes -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" "${devserver}"
fi


ssh_cmd="ssh -o 'ControlPath=$HOME/.ssh/ctl/%L-%r@%h:%p'"
# NOTE: the trailing slash is important, only on the source (not the target)
# - with no trailing slash on the source, it will get put *inside* the target
# - with a trailing slash, it will get put *on top of* (or "as") the target
#
# Again, what does *not* matter is
# - a trailing slash on the target doesn't change behavior in either case
# - whether the directory already exists in the target doesn't change behavior
#   ever (this is one of the points of rsync, it should be idempotent)
#
# also, because I symlink from ~/config I have to rsync from the original source
#rsync -e "$ssh_cmd" -avzh ~/config/ ${devserver}:/home/stroxler/
#rsync -e "$ssh_cmd" -avzh ~/.ssh/ ${devserver}:/home/stroxler/.ssh

#rsync -e "$ssh_cmd" -avzh ~/_devserver_scripts ${devserver}:/home/stroxler/tryit/_devserver_scripts

rsync -e "$ssh_cmd" -avzh ~/_devserver_scripts/ ${devserver}:/home/stroxler/_devserver_scripts

# I'm not sure what the problem here is, it won't copy for some reason
#rsync -e "$ssh_cmd" -avzh ~/basic-vim/ ${devserver}:/home/stroxler/basic-vim


# close the ssh connection
if [[ "$2" != "--reuse-ssh" ]]; then
    ssh -O exit -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" ${devserver}
fi

