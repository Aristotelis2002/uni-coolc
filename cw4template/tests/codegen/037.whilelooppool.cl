class Main inherits IO {
    x: Int <- 9;
    main() : Object {{
        while if x = 0 then false else true fi loop {
            self@IO.out_int(x);
            x <- x - 1;
        } pool;
        self@IO.out_string("\n");
    }};
};
