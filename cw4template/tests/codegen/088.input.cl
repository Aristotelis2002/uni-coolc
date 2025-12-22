class Main {
  main(): Object {
    let a: Int <- new IO.in_int() in
      new IO.out_int(a + 1).out_string("\n")
  };
};