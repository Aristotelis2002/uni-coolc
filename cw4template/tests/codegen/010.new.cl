class A inherits IO {
    foo(): Object {
        self@IO.out_string("a\n")
    };
};

class Main {
    main(): Object {
        let a: A <- new A in a.foo()
    };
};