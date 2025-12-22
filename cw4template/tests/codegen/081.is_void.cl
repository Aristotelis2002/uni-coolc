class Main {
    io: IO <- new IO;
    x: Foo <- new Foo;

    main() : Object {
        if isvoid x then io.out_string("nay\n") else io.out_string("yay\n") fi 
    };
};

class Foo {};