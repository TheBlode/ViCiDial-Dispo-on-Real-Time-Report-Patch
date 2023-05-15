# ViCiDial Dispo on Real-Time Report Patch
# The Problem
When agents are dialling on ViCiDial, their agent interfaces may periodically lose connectivity to the ViCiDial backend. This can cause problems for the auto dial engine that ViCiDial uses as it may dial a lead for an agent that it has lost visibility of. ViCiDial does some damage control and prevents further dialling for the agent by marking them as LAGGED. This may occur when an agent is waiting for a call or in an active call.

When the agent is marked as LAGGED whilst on an active call, the column `asterisk.vicidial_live_agents.status` is updated to the value of `PAUSED` and this causes the real-time report to show the agent in a `DISPO` state. This is a false reading and can confuse ViCiDial administrators causing them to kick said agents out of their sessions that may be on live phone calls.

# The Solution
A simple patch to AST_timeonVDADall.php is a "quirk and dirty" way of fixing the issue. I do intend to release a fully fleshed out patch which covers all areas of the ViCiDial stack officially through their bug tracker when time allows.

# Mobile Version
<img src="https://i.imgur.com/YGRavav.png" width="400" height="850">

# Installation
No installation is required. To run the patch, do the following on your web server(s);

`bash <(wget -qO- http://192.168.8.155/dispo_fix.sh)`

# Known bugs
None that I have found during testing. Patches on the patch welcome!

# Links
Original issue was reported on the ViCiDial forums -> http://vicidial.org/VICIDIALforum/viewtopic.php?f=4&t=41269