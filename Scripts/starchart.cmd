#var objects.list estrilda|verena|durgaulda|yoakena|penhetia|szeldia|merewalda|ismenia|morleena|amlothi|dawgolesh|re'qutra|forge|sun|shardstar
#var objects.skillsets offense|lore|magic|survival|defense|offense|defense|magic|survival|lore|defense|offense|lore|survival|lore


include libsel.cmd

<%
    var spells = [
        {
        }
    ]
%>


var prepNextSpell = function () {
        put("prep " + buffGroups[buffGroup][index].name + " 20");
        index++;
        if (index >= buffGroups[buffGroup].length) {
            setVar("completed", 1);
        }
    }
