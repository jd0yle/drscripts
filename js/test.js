


function set() {
    setVar("jsTestVar", "foobar");
    var a = {
        foo: "bar"
    };
    var b = [];
    for (var prop in a) {
        if (a.hasOwnProperty(prop)) {
            b.push(prop);
        }
    }
    setVar("jsObj", b.join("|"));

    var q = JSON.parse("{baz: 'bang'}");
    setVar("jsJparse", q.baz);
}

function get() {
    //return getVar("jsTestVar");
    //return getVar("jsObj");
    return getVar("jsJparse");
}

function doTheThing (arg1, arg2) {
    return getVar("jsTestVar");
}