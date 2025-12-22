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
    main(): Object {
        let a: A <- new A in {
            a.foo();
            a <- new B;
            a.foo();
            a <- new C;
            a.foo();
        }
    };
};