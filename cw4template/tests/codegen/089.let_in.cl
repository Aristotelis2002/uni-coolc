class Main {
  foo(): Int {
    let a: Int <- 0 in 1
  };

  main(): Object {
    new IO.out_int(foo()).out_string("\n")
  };
};