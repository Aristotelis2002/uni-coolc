class Main {
  main(): Object {
    (new IO).out_string(
      (new A2I).i2a(
        fact((new A2I).a2i((new IO).in_string()))
      ).concat("\n"))
  };

  fact(i: Int): Int {
    let fact: Int <- 1 in {
      while (not (i = 0)) loop {
        fact <- fact * i;
        i <- i - 1;
      } pool;
      fact;
    }
  };
};
