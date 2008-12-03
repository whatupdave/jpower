test("Can add 2 numbers", function(){
    equals(Calculator.add(8,2), 10);
});

test("Can subtract 2 numbers", function(){
    equals(Calculator.subtract(5,2), 3);
});

test("can multiply 2 numbers", function() {
  equals(Calculator.multiply(6,2), 12);
});
// 
// test("can divide 2 numbers", function() {
//  equals(Calculator.divide(1,2), 0.5);
// });
// 
// test("on divide by 0 should return -1", function(){
//    equals(Calculator.divide(5,0), -1);
// });