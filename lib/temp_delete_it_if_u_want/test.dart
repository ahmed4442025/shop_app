import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestTemp {
  void void1(String name, int age) {} // 1

  void void2({String name = 'name', int age = 10}) {} // 2

  void void3({required String name, int age = 10}) {} // 3

  void void4(String name, {required int age, int temp = 0}) {} // 4

}

class runTest {
  void run() {
    TestTemp temp = TestTemp();

    temp.void1('my name', 20); // 1

    temp.void2(name: 'my name', age: 20); // 2
    temp.void2(name: 'my name'); // age is optional

    temp.void3(name: 'my name', age: 20); // 3
    // temp.void3(age: 20); // error need name

    temp.void4('my name', age: 10, temp: 0); // 4
    temp.void4('my name', age: 10); // we don't use " name : "
  }
}

class temp2 {

  Widget cont({Widget? child}) {
    return Container(
      child: child,
    );
  }

  void run(){
    cont(child: Icon(Icons.star));
  }

}
