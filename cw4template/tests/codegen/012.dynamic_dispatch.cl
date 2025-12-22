class A inherits IO {
    foo(): Object {
        self@IO.out_string("a\n")
    };
};

class B inherits A {
    foo(): Object {
        self@IO.out_string("b\n")
    };
};

class C inherits A {
    foo(): Object {
        self@IO.out_string("c\n")
    };
};

class Main {
    main(): Object {{
        let a: A <- new A in a.foo();
        let a: A <- new B in a.foo();
        let a: A <- new C in a.foo();
    }};
};