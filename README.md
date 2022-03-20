## Addon: Get Link - TBC

- Fork of Get Link addon, works with The Burning Crusade expansion. 
- Search for items with full or partial name, returns item link(s).  

![Example](https://i.imgur.com/ydjzZNk.png)
  
## How To    
**Installation:**  
```
Get ZIP from releases (https://github.com/r0ska/getlink-tbc/releases/) or clone repo. Zip includes one folder and two files:
📁 GetLinkTBC/
   📜 GetLinkTBC.lua
   📜 GetLinkTBC.toc

Folder (with the files) needs to be extracted to "..\_classic_\Interface\AddOns\":
➡️ ..\_classic_\Interface\AddOns\GetLinkTBC\GetLinkTBC.lua 
➡️ ..\_classic_\Interface\AddOns\GetLinkTBC\GetLinkTBC.toc
```

**Usage:**
```
/gl item name
```

**Example:**
```
/gl furies
[19:23:54] [Eight of Furies]
[19:23:54] [Four of Furies]
[19:23:54] [Six of Furies]
[19:23:54] [Seven of Furies]
..
..
```

**Troubleshooting:**
```
Missing Items? Not working? Errors? Try running '/gldev purge' ➡️ '/gldev build' ➡️ '/reload'
/gldev purge - Purges current saved variables
/gldev build - Force-updates the database
```

**Other versions:**
```
Get Link Classic: https://www.curseforge.com/wow/addons/get-link-classic
Get Link Retail: https://www.curseforge.com/wow/addons/getlink
```
