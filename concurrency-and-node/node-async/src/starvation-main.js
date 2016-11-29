var express = require('express');
var app = express();

app.get('/', function(req, res) {
    res.send('Use either the /fast or /slow route.');
});

app.get('/fast/:n', function(req, res) {
    var n = req.params.n;
    var r = n * n;

    res.status(200).send('' + r);
});

app.get('/slow/:n', function(req, res) {
    var n = req.params.n;
    var r = getFibs(parseInt(n));

    res.status(200).send('' + r);
});

function getFibs(n) {
    if (n < 1) {
        throw 'Fib number is less than 1.';
    } else if (n == 1) {
        return 1;
    } else if (n == 2) {
        return 1;
    } else {
        return getFibs(n - 1) + getFibs(n - 2);
    }
}

console.log('Node Starvation Server Running');
app.listen(8082);
