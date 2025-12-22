class Main inherits IO {
    main() : Object {
        let x: Int <- 5 in {
            out_int(x);
            x <- 6;
            out_int(x);
        }
    };
};
