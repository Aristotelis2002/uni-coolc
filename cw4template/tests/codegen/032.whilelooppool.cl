class Main inherits IO {
    x: Int <- 10;
    main() : Object {{
        while if x = 0 then false else true fi loop {
            self@IO.out_int(x);
            x <- 0;
        } pool;
        self@IO.out_string("\n");
    }};
};
