var Calculator = {
    add: function(a, b) {
        return a + b;
    },

    divide: function(a, b) {
        if (b == 0) {
            return -1;
        }
        return a / b;
    }
};
