:: ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
:: ░ The Most Popular Adblock Lists. No Whitelist-Entries. ░
:: ░ https://github.com/eladkarako/Adblock-No-Whitelist    ░
:: ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
::@echo off
if exist ".\build\"   rmdir /q /s ".\build\">nul

aria2c.exe  --allow-overwrite=true          --auto-file-renaming=false          --check-certificate=false       ^
            --check-integrity=false         --console-log-level=notice          --continue=true                 ^
            --dir=".\build"                 --disable-ipv6=true                 --enable-http-keep-alive=true   ^
            --enable-http-pipelining=true   --file-allocation=prealloc          --http-auth-challenge=false     ^
            --human-readable=true           --input-file="list.txt"             --max-concurrent-downloads=10   ^
            --max-connection-per-server=8   --min-split-size=1M                 --rpc-secure=false              ^
            --split=3                       --user-agent="Mozilla/5.0 Chrome"

cd build


ren   "antiadblockfilters.txt"              "__Adblock_Warning_Removal_List.txt"                     
ren   "anti-adblock-killer-filters.txt"     "__Anti-Adblock_Killer_by_Reek.txt"                      
ren   "easylist.txt"                        "__EasyList.txt"                                         
ren   "easyprivacy.txt"                     "__EasyPrivacy.txt"                                      
ren   "easyprivacy_nointernational.txt"     "__EasyPrivacy_without_international_filters.txt"        
ren   "easylist_noelemhide.txt"             "__EasyList_without_element_hiding_rules.txt"            
ren   "fanboy-annoyance.txt"                "__Fanboys_Annoyance_List.txt"                           
ren   "fanboy-social.txt"                   "__Fanboys_Social_Blocking_List.txt"                     
ren   "easylistgermany.txt"                 "__EasyList_Germany.txt"                                 
ren   "easylistitaly.txt"                   "__EasyList_Italian.txt"                                 
ren   "easylistdutch.txt"                   "__EasyList_Dutch.txt"                                   
ren   "liste_fr.txt"                        "__EasyList_French.txt"                                  
ren   "easylistchina.txt"                   "__EasyList_Chinese.txt"                                 
ren   "cjx-annoyance.txt"                   "__EasyList_Chinese_CJX_Annoyance_List.txt"              
ren   "adblock_bg.txt"                      "__EasyList_Bulgarian.txt"                               
ren   "abpindo.txt"                         "__EasyList_Indonesian.txt"                              
ren   "Liste_AR.txt"                        "__EasyList_Arab.txt"                                    
ren   "filters.txt"                         "__EasyList_Czech_and_Slovak.txt"                        
ren   "latvian-list.txt"                    "__EasyList_Latvian.txt"                                 
ren   "EasyListHebrew.txt"                  "__EasyList_Hebrew.txt"                                  
ren   "easylistlithuania.txt"               "__EasyList_Lithuanian.txt"                              
ren   "easylistspanish.txt"                 "__EasyList_Spanish.txt"                                 
ren   "rolist.txt"                          "__EasyList_Romanian.txt"                                
ren   "advblock.txt"                        "__EasyList_Russian.txt"                                 
ren   "is.abp.txt"                          "__EasyList_Icelandic.txt"                               
ren   "abp_jp.txt"                          "__EasyList_Japanese.txt"                                
ren   "Blockzilla.txt"                      "__Blockzilla_by_zpacman.txt"                            
ren   "index.php"                           "__I_do_not_care_about_cookies.txt"                      
ren   "obtrusive.txt"                       "__Prebake_Filter_Obtrusive_Cookie_Notices.txt"          

for %%e in (*.txt) do (
  ..\grep.exe -v "\@\@" %%e | ..\grep.exe -v "#@#" | ..\grep.exe -v "^\ *~"   >__no_whitelist_%%e
)

for %%e in (__no_whitelist_*) do (
  ..\adblock_checksum_er.py <%%e >%%e_tmp
)

del __no_whitelist*.txt

ren "*.txt_tmp" "*.txt"

echo %DATE% %TIME%>___last_updated___.txt

cd ..

pause