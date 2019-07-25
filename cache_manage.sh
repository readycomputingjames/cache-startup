#!/bin/bash
#########################################################################
# James Hipp
# System Support Engineer
# Ready Computing
#
# Main Bash script for Cache Manage Suite of Scripts
# This is a combo of Startup, Shutdown, and Restart
#
# We will already assume that Cache is installed on these Systems for now
#
# Our system OS use-case will be RHEL 7+ (or CentOS 7+)
#
# Usage = cache_manage.sh <startup|shutdown|restart|status>
#
# Ex: ./cache_manage.sh startup
# Ex: ./cache_manage.sh status
#
#
### CHANGE LOG ###
#
#
#########################################################################

input_command=$1

is_down()
{

   # Return False if any Instances show Running
   if [ "`sudo ccontrol list |grep running,`" ]
   then
      return 1
   else
      return 0
   fi

}

is_up()
{

   # Return False if any Instances show down
   if [ "`sudo ccontrol list |grep down,`" ]
   then
      return 1
   else
      return 0
   fi

}

stop_instances()
{

   # Load Instances into an Array, in case we have Multiple
   instances=()
   while IFS= read -r line; do
      instances+=( "$line" )
   done < <( sudo ccontrol list |grep Configuration |awk '{ print $2 }' |tr -d "'" )

   for i in ${instances[@]};
   do
      sudo ccontrol stop $i quietly > /dev/null 2>&1
   done

}

start_instances()
{

   # Load Instances into an Array, in case we have Multiple
   instances=()
   while IFS= read -r line; do
      instances+=( "$line" )
   done < <( sudo ccontrol list |grep Configuration |awk '{ print $2 }' |tr -d "'" )

   for i in ${instances[@]};
   do
      sudo ccontrol start $i > /dev/null 2>&1
   done

}

restart_instances()
{

   # Load Instances into an Array, in case we have Multiple
   instances=()
   while IFS= read -r line; do
      instances+=( "$line" )
   done < <( sudo ccontrol list |grep Configuration |awk '{ print $2 }' |tr -d "'" )

   for i in ${instances[@]};
   do
      sudo ccontrol stop $i quietly restart > /dev/null 2>&1
   done

}

main ()
{

   # Parse out CLI Argument to see what we Need to do
   

}

main




