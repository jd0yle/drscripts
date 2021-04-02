include libmaster.cmd
action goto needMore when ^What were you referring to\?

var orderItem %1

getLogbook:  
  gosub get my logbook
  goto getWorkorder
  goto getItem
  
getWorkorder:
  match getItem %1
  match getWorkorder Alright, this is an order for
  put ask master for hard shaping work
  matchwait 5
  
getItem:
  gosub get %1 from my workbag  
bundleItem:
  match readBook What were you
  matchre getItem You notate
  matchre orderDone ^You have already bundled enough
  match workOrderdrop quality
  put bundle %1 with my logbook
  matchwait

workOrderdrop:
  put drop my %1
  goto getItem
  
readBook:
  match needMore You must bundle and deliver 
  match orderDone Now give it to a crafting
  put read my logbook
  matchwait
  
needMore:
  echo *********************
  echo * More items needed.
  echo *********************
  exit

orderDone:
  gosub stow my %1 in my workbag
  put give master
  gosub stow my logbook in my workbag
  echo *********************
  echo * Order completed.
  echo *********************
  exit
