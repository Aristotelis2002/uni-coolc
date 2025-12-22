class Main {
  main(): Object {
    -- here, there is no compile error, but the objects are not the same
    if let x: Object <- "hello", y: Object <- 3 in x = y then
      new IO.out_string("not ok\n")
    else
      new IO.out_string("ok\n")
    fi
  };
};
s