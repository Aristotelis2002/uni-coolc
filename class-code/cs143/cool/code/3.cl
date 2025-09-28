class List {
  object: Object;
  next: List;

  init(o: Object, n: List): List {{
    object <- o;
    next <- n;
    self;
  }};

  flatten(): String {
    let string: String <-
      case object of
        i: Int => (new A2I).i2a(i);
        s: String => s;
        o: Object => { abort(); ""; };
      esac
    in
      if isvoid next then
        string
      else
        string.concat(next.flatten())
      fi
  };

};

class Main {
  main(): Object {
    let
      hello: String <- "Hello ",
      world: String <- "World!",
      i: Int <- 43,
      newline: String <- "\n",
      nil: List,
      list: List <- (new List).init(hello,
                      (new List).init(world,
                        (new List).init(i,
                          (new List).init(newline, nil))))
    in
      (new IO).out_string(list.flatten())
  };
};
