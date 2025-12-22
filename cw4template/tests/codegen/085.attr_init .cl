class Foo {
  a:Int <- 3;
  foo(): Object {
    new IO.out_int(a)
      .out_string("\n")
  };
};

class Main {
  main(): Object {
    new Foo.foo()
  };
};