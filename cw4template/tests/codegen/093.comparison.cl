class Main {
  main(): Object {
    -- despite of the static type Object, the runtime should detect the dynamic type as Int and perform Int comparison
    if let x: Object <- (1+2), y: Object <- (6-3) in x = y then
      new IO.out_string("ok\n")
    else
      new IO.out_string("not ok\n")
    fi
  };
};
s