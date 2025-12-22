class Main inherits IO {
    x: Int <- 3;
    y: Int <- 4;
    z: Main;
    main() : Object {
        self@IO.out_int(if isvoid z then x else y fi)
    };
};
