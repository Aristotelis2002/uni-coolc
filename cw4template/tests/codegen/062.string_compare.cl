class Main inherits IO {
    x : String <- "a longer string to compare, should be fine, right";
    y : String <- "a longer string to compare, should be fine, right?";
    main() : Object {
        if x = y 
        then out_string("not ok\n")
        else out_string("ok\n")
        fi
    };
};
