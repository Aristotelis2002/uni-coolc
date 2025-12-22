class Foo inherits Bazz {
     a : Foo <- self;

     b : Int <- a.doh();

     doh() : Int { 3 };
};

class Razz inherits Foo { };

class Bar inherits Razz { };

class Bazz inherits IO { };

class Main {
  b : Foo <- new Foo;

  main(): Foo { b.out_string("yay\n") };
};