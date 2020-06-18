/**
 *
 * Created by jdoyle on 6/13/2020.
 */
(function () {
    "use strict";
    let patterns = [
        /^\S*>.*$/gi,
        /^You feel.*$/gi,
        /^Stow what.*$/gi,
        /^You contribute.*$/gi,
        /^.*opens (his|her|its).*$/gi,
        /^You get.*$/gi,
        /^You sense.*$/gi,
        /^You continue to instruct.*$/gi,
        /^.*absorbing your teaching.*$/gi,
        /.*Nearby in the water you see.*$/gi
    ];

    let text = require("fs").readFileSync("../Logs/rathasnippet.log", "utf-8");
    let result;

    result = patterns.reduce(function (acc, pattern) {
        acc = acc.replace(pattern, "");
        return acc;
    }, text);

    console.log(result);

})();
