## Addon: Get Link - WOTLK
#### Search for items with full or partial name, returns item link(s).
- Fork of "[Get Link Classic](https://github.com/vxjt/getlink)" addon
- Updated for Wrath of the Lich King Expansion

![Example](https://i.imgur.com/ydjzZNk.png)
  
## How To
**Usage:**
```
/gl item
```

**Examples:**
```
/gl Ace of Storms
[20:12:15] [Ace of Storms]
[20:12:15] End of results.

/gl of Storms
[20:12:21] [Five of Storms]
[20:12:21] [Six of Storms]
[20:12:21] [Three of Storms]
[20:12:21] [Eight of Storms]
[20:12:21] [Two of Storms]
[20:12:21] [Ace of Storms]
[20:12:21] [Four of Storms]
[20:12:21] [Seven of Storms]
[20:12:21] End of results.
```

**Installation:**
```
1. Download Zip from releases page (https://github.com/r0ska/getlink-tbc/releases/)

Zip should contain one folder and two files:
📁 GetLinkWOTLK/
  📜 GetLinkWOTLK.lua
  📜 GetLinkWOTLK.toc

2. Extract folder (with the files) to "..\_classic_\Interface\AddOns\"

➡️ ..\_classic_\Interface\AddOns\GetLinkWOTLK\
➡️ ..\_classic_\Interface\AddOns\GetLinkWOTLK\GetLinkTBC.lua
➡️ ..\_classic_\Interface\AddOns\GetLinkWOTLK\GetLinkTBC.toc
```

**Troubleshooting:**
```
Make sure to disable other versions of Get Link!

Missing items? Not working? Errors? Try running '/gldev purge' ➡️ '/gldev build' ➡️ '/reload'

/gldev purge - Purges current saved variables
/gldev build - Force-updates the item database
```

**Other versions:**
```
Get Link TBC: https://github.com/r0ska/getlink-tbc
Get Link Classic: https://www.curseforge.com/wow/addons/get-link-classic
Get Link Retail: https://www.curseforge.com/wow/addons/getlink
```
