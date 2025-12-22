class Main {
  foo(): Int {{
    let x: Int <- 5 in while 0 < x loop x <- x - 1 pool;
    1;
  }};

  main(): Object {
    new IO.out_int(foo()).out_string("\n")
  };
};