class Main inherits IO {
    x: Int <- 5;
    main() : Object {
        self@IO.out_string(
            if x = 0 then "not ok 0" else
            if x = 1 then "not ok 1" else
            if x = 2 then "not ok 2" else
            if x = 3 then "not ok 3" else
            if x = 4 then "not ok 4" else
            if x = 5 then "ok" else
            "not ok 6" fi fi fi fi fi fi)
    };
};
