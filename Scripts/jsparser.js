var sendQueue = [],
    triggers = [];

//*****************************
// COMMAND SENDING
//*****************************
var sendCommand = function (gameCommand) {
    var queue = getGlobal('command');
    if (queue == 'null') {
        setGlobal('command', gameCommand);
    }
    else {
        setGlobal('command', queue + ';' + gameCommand);
    }
};

var send = function (command) {
    sendQueue.push(command);
};

//*****************************
// TRIGGERS
//*****************************
triggers.addTrigger = function (params) {
    var uuid = Math.floor(Math.random() * Math.floor(10000)).toString() + new Date().getTime().toString();
    triggers.push({
        uuid: uuid,
        isActive: true,
        regex: params.regex,
        action: params.action
    });
    return uuid;
};

triggers.setTriggerState = function (uuid, state) {
    for (var i = 0; i < triggers.length; i++) {
        if (triggers[i].uuid === uuid) {
            triggers[i].isActive = state;
            break;
        }
    }
};

triggers.getTriggerState = function (uuid) {
    var state;
    for (var i = 0; i < triggers.length; i++) {
        if (triggers[i].uuid === uuid) {
            state = triggers[i].isActive;
            break;
        }
    }
    return state;
};


//*****************************
// HANDLE INCOMING TEXT
//*****************************
var textReceived = function(gameText) {
    if (sendQueue.length > 0) {
        // This ensures that we always wait for the next prompt before sending a command
        sendCommand(sendQueue.shift());
    }
    for (var i = 0; i < triggers.length; i++) {
        var trigger = triggers[i];
        var match;
        if (trigger) {
            if (trigger.isActive === true) {
                match = gameText.match(trigger.regex);
                if (match) {
                    trigger.action(match);
                }
            }
        }
    }
};
