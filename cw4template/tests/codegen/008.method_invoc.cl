class Main inherits IO {
    foo(x: Int) : Object {
        self@IO.out_int(x)
    };

    main() : Object {
        let x: Int <- 5 in foo(x)
    };
};
