class Foo {
     a : Foo <- self;
};

class Main {
  main(): IO { new IO.out_string("do nothing\n") };
};