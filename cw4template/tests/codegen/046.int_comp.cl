class Main inherits IO {
    main() : Object {
        if 5 <= 4 then
            self@IO.out_string("not ok\n")
        else
            self@IO.out_string("ok\n")
        fi
    };
};
