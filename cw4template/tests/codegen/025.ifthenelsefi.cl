class Main inherits IO {
    x: Int <- 1;
    main() : Object {
        self@IO.out_string(
            if x = 0 then "not ok 0" else
            if x = 1 then "ok" else
            if x = 2 then "not ok 2" else
            if x = 3 then "not ok 3" else
            if x = 4 then "not ok 4" else
            if x = 5 then "not ok 5" else
            "not ok 6" fi fi fi fi fi fi)
    };
};
