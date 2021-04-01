

triggers.addTrigger({
    regex: /(\S+) ring/g,
    action: function (matches) {
        echo("Found a " + matches[1] + " ring");
    }
});

send("rummage my backpack");
