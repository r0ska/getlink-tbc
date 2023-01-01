## Addon: Get Link - TBC
#### Search for items with full or partial name, returns item link(s).
- Fork of "[Get Link Classic](https://github.com/vxjt/getlink)" addon
- Updated for The Burning Crusade Expansion

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

Zip should include one folder and two files:
📁 GetLinkTBC/
  📜 GetLinkTBC.lua
  📜 GetLinkTBC.toc

2. Extract folder (with the files) to "..\_classic_\Interface\AddOns\"

➡️ ..\_classic_\Interface\AddOns\GetLinkTBC\
➡️ ..\_classic_\Interface\AddOns\GetLinkTBC\GetLinkTBC.lua
➡️ ..\_classic_\Interface\AddOns\GetLinkTBC\GetLinkTBC.toc
```

**Troubleshooting:**
```
Missing items? Not working? Errors? Try running '/gldev purge' ➡️ '/gldev build' ➡️ '/reload'

/gldev purge - Purges current saved variables
/gldev build - Force-updates the item database
```

**Other versions:**
```
Get Link WOTLK: https://github.com/r0ska/getlink-tbc/tree/wotlk
Get Link Classic: https://www.curseforge.com/wow/addons/get-link-classic
Get Link Retail: https://www.curseforge.com/wow/addons/getlink
```
