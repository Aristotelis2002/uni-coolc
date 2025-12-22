class Main inherits IO {
    main() : Object {
        if 5 <= 5 then
            self@IO.out_string("ok\n")
        else
            self@IO.out_string("not ok\n")
        fi
    };
};
