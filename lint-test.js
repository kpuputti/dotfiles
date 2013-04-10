// GLOBALS

console.log(
    process,
    require,
    define,
    module,
    exports,
    document.body,
    window,
    location,
    jQuery,
    $,
    _,
    Backbone
);

alert();
prompt();
confirm();
setTimeout();
setInterval();
clearTimeout();
clearInterval();

// BITWISE

console.log(0xff << 2);

// CAMELCASE

var under_case = 'under';
var camelCase = 'camel';

console.log(under_case, camelCase);

// CURLY

if (false) console.error('error');

if (false)
    console.error('error');

// EQEQEQ

console.log(1 == '1');
console.log(1 === '1');

// FORIN

var obj = {a: 1, b: 2};
var key;

for (key in obj) {
    console.log(key);
}
for (key in obj) {
    if (obj.hasOwnProperty(key)) {
        console.log(key);
    }
}

// IMMED

var f1 = function () { alert('jee'); }();
var f2 = (function () { alert('jee'); }());
var f3 = (function () { alert('jee'); })();

console.log(f1, f2, f3);

// INDENT

if (false)
  alert('bad indent');

// LATEDEF

late();

function late() {
    return 'yes I am';
}

// NEWCAP

function Type1(name) {
    this.name = name;
}

Type1.prototype.getName = function () {
    return this.name;
};

function type2(name) {
    this.name = name;
}

type2.prototype.getName = function () {
    return this.name;
};

var t1 = new Type1('1');
var t2 = new type2('2');

console.log(t1, t2);

// NOARG

function cal() {
    console.log(arguments.callee);
}
cal();

// NOEMPTY

if (true) {

}

console.log('empty');

// NONEW

function N(name) {
    this.name = name;
}

new N('nonew');

// PLUSPLUS

var one = 1;
one++;

// QUOTMARK

console.log('single', "double");

// UNDEF

console.log(undef);

// UNUSED

var unused = 'not used';

// STRICT

function strictFn() {
    'use strict';
    return 'strict';
}

function nonStrictFn() {
    return 'not strict';
}

console.log(strictFn(), nonStrictFn());

// TRAILING

console.log('trailing');  

// LASTSEMIC

function id(o) { return o.id }
console.log(id({id: 'my id'}));

// LAXCOMMA

var first
    , second
    , third;

console.log(first, second, third);
