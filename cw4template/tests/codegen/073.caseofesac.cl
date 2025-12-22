class Main inherits IO {
    x: Object <- new Qux;

    main() : Object {
        case x of
            s: String => out_string(s);
            i: Int => out_int(i);
            f: Foo => out_string("foo");
            b: Baz => out_string("baz");
        esac
    };
};

class Foo { };

class Bar inherits Foo { };

class Baz { };

class Qux inherits Baz { };

class Zap inherits Qux { };