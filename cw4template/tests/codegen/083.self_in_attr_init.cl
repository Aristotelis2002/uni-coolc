class Foo {
  a : Foo <- self;
  b : Int;
  set_b(c: Int): Int { b <- c };
  get_b(): Int { b };
  get_ab(): Int { a.get_b() };
};

class Main {
  main(): Object {
    let a: Foo <- new Foo in {
      a.set_b(3);
      new IO.out_int(a.get_ab())
        .out_string("\n");
    }
  };
};