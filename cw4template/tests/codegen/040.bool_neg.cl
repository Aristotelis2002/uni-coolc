class Main inherits IO {
    main() : Object {
        if not not not false then 
            self@IO.out_string("ok\n")
        else
            self@IO.out_string("not ok\n")
        fi
    };
};
