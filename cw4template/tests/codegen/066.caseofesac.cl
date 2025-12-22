class Main inherits IO {
    x: Object <- new Foo;

    main() : Object {
        case x of
            s: String => out_string(s);
            i: Int => out_int(i);
            f: Foo => out_string("foo");
        esac
    };
};

class Foo { };

class Bar inherits Foo { };