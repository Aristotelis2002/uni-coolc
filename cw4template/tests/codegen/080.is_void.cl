class Main {
    io: IO <- new IO;
    x: Foo;

    main() : Object {
        if isvoid x then io.out_string("yay\n") else io.out_string("nay\n") fi 
    };
};

class Foo {};