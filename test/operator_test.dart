main() {
  final tuple = Tuple(3);
  final square = Squre(9);
  print(tuple - square);
}

abstract class Shape {
  int get size;
}

class Squre implements Shape {
  final int number;
  Squre(this.number);

  @override
  int get size => number;
}

class Tuple implements Shape {
  final int number;
  Tuple(this.number);

  int operator *(Shape object) => number * object.size;
  int operator -(Shape object) => number - object.size;

  @override
  int get size => number;
}
