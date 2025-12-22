class Main inherits IO {
    x: Int <- 9;
    main() : Object {{
        while 0 < x loop {
            self@IO.out_int(x);
            x <- x - 1;
        } pool;
        self@IO.out_string("\n");
    }};
};
