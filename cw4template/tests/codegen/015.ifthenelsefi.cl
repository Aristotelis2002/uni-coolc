class Main inherits IO {
    x: Int <- 3;
    y: Int <- 4;
    main() : Object {
        self@IO.out_int(if false then x else y fi)
    };
};
