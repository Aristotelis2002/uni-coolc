class Foo {
    bar: Int;
    set_bar(b: Int): SELF_TYPE { { bar <- b; self; } };
    get_bar(): Int { bar };
};

class Main {
    main(): Object {
        let y: Object <- new Foo.set_bar(42) in
            new IO.out_int(cast_to_foo(y).get_bar())
                  .out_string("\n")
    };

    cast_to_foo(x: Object): Foo {
        case x of 
            f: Foo => f;
            o: Object => {
                abort();
                new Foo;
            };
        esac
    };
};