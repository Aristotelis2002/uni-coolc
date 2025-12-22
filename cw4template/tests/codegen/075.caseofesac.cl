class Main inherits IO {
    x: Object <- new Bar;

    main() : Object {
        case x of
            s: String => out_string(s);
            i: Int => out_int(i);
            f: Foo => out_string("foo");
            b: Bar => out_string("bar");
        esac
    };
};

class Foo { };

class Bar inherits Foo { };

class Baz { };

class Qux inherits Baz { };

class Zap inherits Qux { };