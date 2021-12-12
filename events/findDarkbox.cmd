include libmaster.cmd

if (matchre("$roomobjs", "Darkbox")) then goto done.foundDarkbox

var roomIds 1|2|3|4|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|41|43|46|47|49|50|51|52|53|54|55|56|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|96|97|98|99|100|101|102|107|110|111|112|115|117|119|121|123|124|129|130|131|132|135|136|137|138|139|140|141|142|143|149|151|158|159
var index 0

action var foundInRoomId $roomid; goto done.foundDarkbox when eval contains("$roomobjs", "the Darkbox")

if ($darkbox.lastKnownRoomId > 0) then gosub automove $darkbox.lastKnownRoomId

findDarkboxLoop:
	if ($roomid != %roomIds(%index)) then gosub automove %roomIds(%index)
	math index add 1
	if (%index > count("%roomIds", "|")) then goto done.notFoundDarkbox
	goto findDarkboxLoop


done.foundDarkbox:
	put #script abort automapper
	pause .5
	if (!matchre("$roomobjs", "Darkbox")) then {
		if ($roomid != %foundInRoomId) then gosub automove %foundInRoomId
	}
	put #tvar darkbox.lastKnownRoomId $roomid
	put #parse FINDDARKBOX DONE
	exit


done.notFoundDarkbox:
	echo NOT FOUND
	exit