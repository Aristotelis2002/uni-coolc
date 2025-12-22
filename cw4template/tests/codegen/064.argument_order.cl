class Main inherits IO {
    main() : Object {
        foo(2, 3, 4)
    };

    foo(x: Int, y: Int, z: Int): Object {
        out_int(x).out_int(y).out_int(z)
    };
};