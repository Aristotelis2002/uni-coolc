class Main inherits IO {
    x : String <- "hello";
    main() : Object {
        if x = "hello"
        then out_string("ok\n")
        else out_string("not ok\n")
        fi
    };
};
