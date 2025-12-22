class Main inherits IO {
    s: String;
    main() : Object {
        self@IO.out_int(if isvoid s then 17 else 37 fi)
    };
};
