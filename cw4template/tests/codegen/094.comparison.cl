class Main {
  main(): Object {
    -- despite of the static type Object, the runtime should detect the dynamic type as String and perform String comparison
    if let x: Object <- ("hello, ".concat("there")), y: Object <- ("hello,".concat(" there")) in x = y then
      new IO.out_string("ok\n")
    else
      new IO.out_string("not ok\n")
    fi
  };
};
s