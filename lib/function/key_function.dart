import 'dart:math';

class KeyFunction {
  static getKey() {
    String rand = '';
    for (int i = 0; i < 10; i++) {
      rand = rand + Random().nextInt(10).toString();
    }
    return rand;
  }

  static getSolve(key) {
    String a0 = key.toString().substring(0, 1);
    String a1 = key.toString().substring(1, 2);
    String a2 = key.toString().substring(2, 3);
    String a3 = key.toString().substring(3, 4);
    String a4 = key.toString().substring(4, 5);
    String a5 = key.toString().substring(5, 6);
    String a6 = key.toString().substring(6, 7);
    String a7 = key.toString().substring(7, 8);
    String a8 = key.toString().substring(8, 9);
    String a9 = key.toString().substring(9, 10);

    // ignore: unused_local_variable
    String basic = a3 + a5 + a7 + a0 + a8 + a6 + a1 + a9 + a4 + a2; //3570861942

    String basicTest1 = (10 - int.parse(a3)).toString() +
        (10 - int.parse(a5)).toString() +
        (10 - int.parse(a7)).toString() +
        (10 - int.parse(a0)).toString() +
        (10 - int.parse(a8)).toString() +
        (10 - int.parse(a6)).toString() +
        (10 - int.parse(a1)).toString() +
        (10 - int.parse(a9)).toString() +
        (10 - int.parse(a4)).toString() +
        (10 - int.parse(a2)).toString();

    String basicTest2 = (15 - int.parse(a3)).toString() +
        (15 - int.parse(a5)).toString() +
        (15 - int.parse(a7)).toString() +
        (15 - int.parse(a0)).toString() +
        (15 - int.parse(a8)).toString() +
        (15 - int.parse(a6)).toString() +
        (15 - int.parse(a1)).toString() +
        (15 - int.parse(a9)).toString() +
        (15 - int.parse(a4)).toString() +
        (15 - int.parse(a2)).toString();
    int key25 = int.parse(basicTest2) - int.parse(basicTest1);
    if (key25 < 0) {
      key25 = key25 * (-1);
    }
    key25 = key25*3;
    return key25.toString().substring(0,10);
  }
}