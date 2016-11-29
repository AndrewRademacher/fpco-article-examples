async = require('promise-async');
request = require('request-promise');

function main() {
    testWithoutAsync()
        .then(() => {
            return testWithAsync();
        });
}

function testWithoutAsync() {
    var x;
    var y;
    var t1 = new Date().getTime();

    return request('http://localhost:8080/api/fibs/43')
        .then((xStr) => {
            x = JSON.parse(xStr).fibResult;
            return request('http://localhost:8080/api/fibs/44');
        })
        .then((yStr) => {
            y = JSON.parse(yStr).fibResult;

            var sum = x + y;
            var t2 = new Date().getTime();

            console.log('Without Async');
            console.log('Sum: ' + sum);
            console.log('Execution Time: ' + ((t2 - t1) / 1000) + 's');
        })
}

function testWithAsync() {
    var x;
    var y;
    var t1 = new Date().getTime();

    return async.parallel([
        (callback) => {
            request('http://localhost:8080/api/fibs/43')
                .then((xStr) => {
                    x = JSON.parse(xStr).fibResult;
                    callback();
                });
        },
        (callback) => {
            request('http://localhost:8080/api/fibs/44')
                .then((yStr) => {
                    y = JSON.parse(yStr).fibResult;
                    callback();
                });
        }
    ]).then(() => {
        var sum = x + y;
        var t2 = new Date().getTime();

        console.log('With Async');
        console.log('Sum: ' + sum);
        console.log('Execution Time: ' + ((t2 - t1) / 1000) + 's');
    });
}

main();
