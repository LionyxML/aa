aa.sh - Status Line - aa and voilá!
-----------------------------------

Type aa.sh and bash you return a status line like this:


```[C:My_wifi] [L:0.60] [D:57%] [M:150M] [S:Mute] [B:50%] [01.09.2017 15:07]
```
This features:
- C: Network connected to
- L: CPU Load
- D: Disk usage
- M: Memory usage
- S: Sound Level
- B: Battery Level
- Date and time

You can use it with watch to have a "top in line" application:

```
$ watch -n 1 aa.sh
```

Or pipe it into other software, like i3bar on i3wm

Screenshot
----------
In this example I've symbolic linked aa to aa.sh, now I am addicted to aa...

![Example](images/1.png)



