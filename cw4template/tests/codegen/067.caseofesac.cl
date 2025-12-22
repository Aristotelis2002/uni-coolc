class Main inherits IO {
    x: Object <- new Bar;

    main() : Object {
        case x of
            s: String => out_string(s);
            i: Int => out_int(i);
            f: Foo => out_string("bar");
        esac
    };
};

class Foo { };

class Bar inherits Foo { };