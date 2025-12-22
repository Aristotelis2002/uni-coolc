class Main inherits IO {
    main() : Object {
        let x: Int <- 5 in {
            self@IO.out_int(x);
            x <- 6;
            self@IO.out_int(x);
        }
    };
};
