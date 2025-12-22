class Main inherits IO {
    x: Int <- 100;
    main() : Object {
        self@IO.out_string(
            if x = 0 then "not ok" else
            if x = 1 then "not ok" else
            if x = 2 then "not ok" else
            if x = 3 then "not ok" else
            if x = 4 then "not ok" else
            if x = 5 then "not ok" else
            "ok" fi fi fi fi fi fi)
    };
};
