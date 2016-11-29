async = require('promise-async');

function main() {
    testWithoutAsync()
    testWithAsync();
}

function testWithoutAsync() {
    var x;
    var y;
    var t1 = new Date().getTime();

    x = getFibs(43);
    y = getFibs(44);

    var sum = x + y
    var t2 = new Date().getTime();

    console.log('Without Async');
    console.log('Sum: ' + sum);
    console.log('Execution Time: ' + ((t2 - t1) / 1000) + 's');
}

function testWithAsync() {
    var x;
    var y;
    var t1 = new Date().getTime();

    return async.parallel([
        (callback) => {
            x = getFibs(43);
            callback();
        },
        (callback) => {
            y = getFibs(44);
            callback();
        }
    ]).then(() => {
        var sum = x + y;
        var t2 = new Date().getTime();

        console.log('With Async');
        console.log('Sum: ' + sum);
        console.log('Execution Time: ' + ((t2 - t1) / 1000) + 's');
    });
}

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

main();
