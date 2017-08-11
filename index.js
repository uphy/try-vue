var express = require("express");
var app = express();

var server = app.listen(3000, function () {
    console.log("Node.js is listening to PORT:" + server.address().port);
});

app.use(express.static('client'));

app.get("/test", function (req, res, next) {
    res.json({
        "a": 1,
        "b": "123abc"
    });
});
