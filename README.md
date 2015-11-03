# Graph iostats

A simple how to for graphing iostats. The output of iostat is useful but its also nice if you can get it into a graph. The idea of this small repository is to show how this is done.

Acknoledgements to the following links where I drew inspiration:

http://www.linuxuser.co.uk/tutorials/create-a-graph-of-your-systems-performance

http://sysmagazine.com/posts/165855/


## Overview

Theres nothing more special here than a bunch of shell scripts that run gnuplot and could probably be very easily improved. There's a few things that will need to be setup beforehand though and you'll also need to run a iostat command to collect data. Note this was all tested on Centos Linux, you may run into problems running these scripts on a Mac. It's definitely not going to work on MS Windows, sorry!

Also a lot of the scripts are grouped by the type of measurement, i.e. queue length is in requests but queue size is in sectors. Otehr things like read/write requests are per second. I kept all the scripts seperate for now to keep things simpler to follow if for example you only wanted to graph one of two stats.

## Setup

You'll need to install the following:

- gnuplot
- iostat (usually installed on more common Linux distros)

## Collecting data

Run the following iostat command for a decent period of time to collect some data:

```
iostat -xk -t 5 | awk '// {print strftime("%Y-%m-%d %H:%M:%S"),$0}' > iostat-server1.out
```

You should see a resulting output something like so:

```
2015-10-29 17:20:18 10/29/2015 05:20:18 PM
2015-10-29 17:20:18 avg-cpu:  %user   %nice %system %iowait  %steal   %idle
2015-10-29 17:20:18            0.96    0.00    2.65    0.00    0.00   96.38
2015-10-29 17:20:18
2015-10-29 17:20:18 Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
2015-10-29 17:20:18 sda               0.00     1.80    0.00    2.00     0.00    12.80    12.80     0.00    0.00   0.00   0.00
2015-10-29 17:20:18 sdb               0.00     0.40    0.00    0.60     0.00     3.20    10.67     0.00    0.00   0.00   0.00
2015-10-29 17:20:18 sdc               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
```

## Figuring out which disks

In the above output it might be useful to grab all the devices. Here's a useful one-liner you can use for that:

```
sed -n "/sda/,/sdc/p" iostat-server1.out | cut -d\  -f3 | sort -u > disks
```

Where "sda" and "sdc" are the first and last disks in your iostat output respectively. Change those for your own needs. You can also redirect the output to a file as shown.

## Creating the graphs

This is the fun part, using the `disk-report.sh` script, you can then essentially loop through all the disks and then produce the output. For example

```
/disk-report.sh discs iostat-server1.out
```

*Note you might see some warnings on fonts* but you shouldnt see any errors

This will create a bunch of .png files which you can then view with your favourite image viewer and / or embed into presentations to woo your audiences :-)



