JPower.code('../examples/qunit/calculator.js', 'var Calculator = {\r\n    add: function(a, b) {\r\n        return a + b;\r\n    },\r\n\r\n    subtract: function(a, b) {\r\n        return a - b;\r\n\r\n    },\r\n\r\n    multiply: function(a, b) {\r\n        return a * b;\r\n    },\r\n\r\n    divide: function(a, b) {\r\n        if (b == 0) {\r\n            return -1;\r\n        }\r\n        \r\n        return a / b;\r\n    }\r\n};\r\n');
JPower.add('../examples/qunit/calculator.js', 0, 16);JPower.add('../examples/qunit/calculator.js', 55, 13);JPower.add('../examples/qunit/calculator.js', 120, 13);JPower.add('../examples/qunit/calculator.js', 187, 13);JPower.add('../examples/qunit/calculator.js', 250, 11);JPower.add('../examples/qunit/calculator.js', 277, 10);JPower.add('../examples/qunit/calculator.js', 318, 13);
JPower.record('../examples/qunit/calculator.js', 0);var Calculator = {
    add: function(a, b) {
        JPower.record('../examples/qunit/calculator.js', 55);return a + b;
    },

    subtract: function(a, b) {
        JPower.record('../examples/qunit/calculator.js', 120);return a - b;

    },

    multiply: function(a, b) {
        JPower.record('../examples/qunit/calculator.js', 187);return a * b;
    },

    divide: function(a, b) {
        JPower.record('../examples/qunit/calculator.js', 250);if (b == 0) {
            JPower.record('../examples/qunit/calculator.js', 277);return -1;
        }
        
        JPower.record('../examples/qunit/calculator.js', 318);return a / b;
    }
};
