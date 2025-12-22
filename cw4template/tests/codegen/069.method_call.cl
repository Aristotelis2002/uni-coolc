class Main inherits IO {
    main() : Object {{
        f("hello");
        f(3);
        f(new Foo);
        f(new Bar);
        f(new Baz);
        f(new Qux);
        f(new Zap);
    }};
    
    f(x: Object) : Object {{
        case x of
            s: String => out_string(s);
            i: Int => out_int(i);
            f: Foo => out_string("foo");
            b: Baz => out_string("baz");
        esac;
        out_string("\n");
    }};
};

class Foo { };

class Bar inherits Foo { };

class Baz { };

class Qux inherits Baz { };

class Zap inherits Qux { };