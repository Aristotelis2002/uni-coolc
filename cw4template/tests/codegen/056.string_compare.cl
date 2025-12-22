class Main inherits IO {
    x : String <- "a longer string to compare, should be fine, rig";
    y : String <- "a longer string to compare, should be fine, rig";
    main() : Object {
        if x = y 
        then out_string("ok\n")
        else out_string("not ok\n")
        fi
    };
};
