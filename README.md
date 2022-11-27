# Webhooksh - A linux device swarm manager for IOT

Or, a bunch of scripts to automate various repetitive tasks that you really don't want to do manually when

* You have a set of Raspberry Pis that do various neat IOT things
* You have a set of similar servers which perform some cluster thingy
* You have a bunch or cloud boxes that need to be kept in control
* etc

## Why not something like Ansible or Puppet or similar?

There are multiple reasons why you definitely should use these. Use webhooksh if you want something little less enteriprisey and
less complex. You know, for cases where it's just better to whip up small script that gets the job done. When you just need to 
put that little if-statement in the mix for that one particular box out of all ten which needs something special.

I use webhooksh to manage my own RPI network where all hosts are running Zerotier and perform various home automation, status checking and
reporting tasks. 
