-- Code from https://github.com/tkostadinov004/compilers-course/blob/main/additional-tasks/graph-dfs/

class Main {
    io: IO <- new IO;

    reinterpret_cast_int(val: Object): Int {
        let dummy: Int in {
            case val of 
                s: Int => s;
                other: Object => {
                    abort();
                    dummy;
                };
            esac;
        }
    };

    print_ints(list: LinkedList): Object {{
        let oldHead: Node <- list.getHead() in {
            while not (isvoid oldHead) loop {
                io.out_int(reinterpret_cast_int(oldHead.getData()))
                    .out_string(" ");
                oldHead <- oldHead.getNext();
            } pool;
        };
    }};

    read_graph(): Graph {{
        io.out_string("Number of vertices: ");
        let vertices: Int <- io.in_int(), 
            i: Int <- 0, 
            graph: Graph <- (new Graph).init(vertices) in {
            while i < vertices loop {
                io.out_string("Num of neighbours of vertex ").out_int(i).out_string(": ");
                let adjCount: Int <- io.in_int(), j: Int <- 0 in {
                    io.out_string("Neighbours of ").out_int(i).out_string(":\n");
                    while j < adjCount loop {
                        let curr: Int <- io.in_int() in {
                            graph.add(i, curr);
                        };
                        j <- j + 1;
                    } pool;
                };
                i <- i + 1;
            } pool;
            graph;
        };
    }};

    main() : Object {{
        let graph: Graph <- read_graph() in {
            io.out_string("Here is the graph:\n");
            graph.print();

            io.out_string("Start of DFS: ");
            let dfsStart: Int <- io.in_int() in {
                io.out_string("Visit order: ");
                print_ints(graph.dfs(dfsStart));
                io.out_string("\n");
            };
        };
    }};
};

class Graph {
    adjList: LinkedList;
    io: IO <- new IO;

    reinterpret_cast_linkedList(val: Object): LinkedList {{
        let dummy: LinkedList in {
            case val of 
                s: LinkedList => s;
                other: Object => {
                    abort();
                    dummy;
                };
            esac;
        };
    }};

    reinterpret_cast_int(val: Object): Int {
        let dummy: Int in {
            case val of 
                s: Int => s;
                other: Object => {
                    abort();
                    dummy;
                };
            esac;
        }
    };

    reinterpret_cast_bool(val: Object): Bool {
        let dummy: Bool in {
            case val of 
                s: Bool => s;
                other: Object => {
                    abort();
                    dummy;
                };
            esac;
        }
    };

    print_ints(list: LinkedList): Object {{
        let oldHead: Node <- list.getHead() in {
            while not (isvoid oldHead) loop {
                io.out_int(reinterpret_cast_int(oldHead.getData()))
                    .out_string(" ");
                oldHead <- oldHead.getNext();
            } pool;
        };
    }};

    init(vertices: Int) : Graph {{
        adjList <- new LinkedList;
        while not (vertices = 0) loop {
            let vertAdj: LinkedList <- new LinkedList in {
                adjList.add(vertAdj);
            };
            vertices <- vertices - 1;
        } pool;
        self;
    }};

    (*
        Adds an edge to the graph.
        Returns: the current instance of the Graph
    *)
    add(begin: Int, end: Int): Graph {{ -- assuming the graph is directed
        reinterpret_cast_linkedList(adjList.at(begin)).add(end);
        self;
    }};

    (*
        Returns: a Depth-first search ordering of the vertices of the graph, starting from a given vertex
    *)
    dfs(startVertex: Int): LinkedList {{
        let result: LinkedList <- new LinkedList, 
            visited: LinkedList <- new LinkedList,
            stack: LinkedList <- new LinkedList in {
                stack.add(startVertex);
                while not (stack.isEmpty()) loop {
                    let curr: Int <- reinterpret_cast_int(stack.pop_back()) in {
                        if not (isvoid curr) then {
                            if visited.contains(curr) then {curr;} else {
                                result.add(curr);
                                visited.add(curr);
                                let currAdjList: LinkedList <- reinterpret_cast_linkedList(adjList.at(curr)),
                                    index: Int <- 0 in {
                                    if not (isvoid currAdjList) then {
                                        while index < currAdjList.getSize() loop {
                                            stack.add(currAdjList.at(index));
                                            index <- index + 1;
                                        } pool;
                                    } else {abort(); result;} fi;
                                };
                            } fi;
                        } else {abort(); result;} fi;
                    };
                } pool;
                result;
        };
    }};

    (*
        Prints the adjacency list representation of the graph
    *)
    print() : Object {{
        let i: Int <- 0 in {
            while i < adjList.getSize() loop {
                let currAdj: LinkedList <- reinterpret_cast_linkedList(adjList.at(i)) in {
                    io.out_int(i).out_string(": ");
                    print_ints(currAdj);
                    io.out_string("\n");
                };
                i <- i + 1;
            } pool;
        };
    }};
};

class Node {
-- the type of values in each node is Object. The main advantage of keeping data this way is that we reduce code duplication, 
-- as Cool doesn't have generic types and there are usages of the Node class for storing integers,
-- strings, other linked lists, and graph edges. Without this approach we would instead have to create separate classes (such as IntNode, StringNode, LinkedListNode, MSTEdgeNode, EdgeNode etc.).
-- The main downside of this approach is that we would have to convert values from Object back to their original types every time when we want to use them.
    data: Object;
    prev: Node;
    next: Node;

    initVal(idata: Object): Node {{
        data <- idata;
        self;
    }};
    initNext(idata: Object, inext: Node): Node {{
        data <- idata;
        next <- inext;
        self;
    }};
    initPrev(idata: Object, iprev: Node): Node {{
        data <- idata;
        prev <- iprev;
        self;
    }};
    getData(): Object {data};
    getPrev(): Node {prev};
    getNext(): Node {next};

    setData(idata: Object): Object {data <- idata};
    setPrev(iprev: Node): Node {prev <- iprev};
    setNext(inext: Node): Node {next <- inext};
};

(*
    An implementation of a doubly-linked list with a head and a tail.
*)
class LinkedList inherits IO {
    head: Node;
    tail: Node;
    size: Int <- 0;

    (*
        Adds an element to the back of the linked list. The method is synonymous with 'push_back' in C++
        Returns: the current instance of LinkedList
    *)
    add(el: Object): LinkedList {{
        if isvoid head then {
            head <- new Node;
            head.initVal(el);  
            tail <- head;      
        } else {
            let oldTail: Node <- tail in {
                tail <- new Node;
                tail.initPrev(el, oldTail);
                oldTail.setNext(tail);
            };
        } fi;
        size <- size + 1;
        self;
    }};

    iFind(el: Object, node: Node): Node {{
        if isvoid node then node else {
            if node.getData() = el then node else iFind(el, node.getNext()) fi; -- Int, Bool and String are compared based on their values, other types are compared based on their pointers
        } fi;
    }};

    (*
        Returns: the concrete Node containing a given element or void if such an element is not present in the list
    *)
    find(el: Object): Node {
        iFind(el, head)
    };

    iat(index: Int): Node {{
        if 0 <= index then {
            if index < size then {
                let temp: Node <- head in {
                    while not (index = 0) loop {
                        temp <- temp.getNext();
                        index <- index - 1;
                    } pool;
                    temp;
                };
            } else {abort(); new Node;} fi;
        } else {abort(); new Node;} fi;
    }};

    (*
        Returns: the element at a given index or void if the index is invalid
    *)
    at(index: Int): Object {{
        let result: Node <- iat(index), dummy: Object in {
            if isvoid result then dummy else result.getData() fi;
        };
    }};

    (*
        Returns: true, if the given element is present in the linked list, false otherwise
    *)
    contains(el: Object): Bool {
        not (isvoid (find(el)))
    };

    (*
        Removes a given element from the linked list.
        Returns: true, if such an element was found and removed, false otherwise
    *)
    remove(el: Object): Bool {{
        let removalNode: Node <- find(el), dummy: Node in {
            if isvoid removalNode then false else {
                if isvoid removalNode.getPrev() then { -- at head
                    pop_front();
                } else {
                    if isvoid removalNode.getNext() then { -- at tail
                       pop_back();
                    } else { -- in the middle of the list
                        removalNode.getPrev().setNext(removalNode.getNext());
                        removalNode.getNext().setPrev(removalNode.getPrev());
                        size <- size - 1;
                    } fi;
                } fi;
                true;
            } fi;
        };
    }};

    (*
        Removes an element from the front of the linked list.
        Aborts: when the list is empty
    *)
    pop_front(): Object {{
        if isvoid head then {abort(); new Object;} else {
            let removedValue: Object <- head.getData(), dummy: Node in {
                if isvoid head.getNext() then { -- head and tail are the same (list contains only 1 item)
                    head <- tail <- dummy;
                } else { -- head and tail are NOT the same (list contains more than 1 item)
                    head <- head.getNext();
                    head.setPrev(dummy);
                } fi;
                size <- size - 1;
                removedValue;
            };
        } fi;
    }};

    (*
        Removes an element from the back of the linked list.
        Aborts: when the list is empty
    *)
    pop_back(): Object {{
        if isvoid tail then {abort(); new Object;} else {
            let removedValue: Object <- tail.getData(), dummy: Node in {
                if isvoid tail.getPrev() then { -- head and tail are the same (list contains only 1 item)
                    head <- tail <- dummy;
                } else { -- head and tail are NOT the same (list contains more than 1 item)
                    tail <- tail.getPrev();
                    tail.setNext(dummy);
                } fi;
                size <- size - 1;
                removedValue;
            };
        } fi;
    }};

    (*
        Swaps the elements at two indices in the linked list.
    *)
    swap(firstIndex: Int, secondIndex: Int): LinkedList {{
        let first: Node <- iat(firstIndex), second: Node <- iat(secondIndex), temp: Object <- first.getData() in {
            first.setData(second.getData());
            second.setData(temp);
        };
        self;
    }};

    isEmpty(): Bool {size = 0};

    getSize(): Int {size};
    getHead(): Node {head};
    getTail(): Node {tail};

};