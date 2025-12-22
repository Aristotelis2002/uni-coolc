-- Code from https://github.com/tkostadinov004/compilers-course/blob/main/additional-tasks/dijkstra-kruskal/

class Main {
    io: IO <- new IO;

    main() : Object {{
       io.out_string("Number of vertices: ");
       let vertices: Int <- io.in_int(), 
            i: Int <- 0,
            graph: Graph <- (new Graph).init(vertices),
            edges: LinkedList <- new LinkedList in {
            while i < vertices loop {
                io.out_string("No. of neighbors for vertex ").out_int(i).out_string(": ");
                let adjCount: Int <- io.in_int(), j: Int <- 0 in {
                    while j < adjCount loop {
                        io.out_string("Neighbor no. ").out_int(j).out_string(": (index and weight, on separate lines)\n");
                        let curr: Int <- io.in_int(), weight: Int <- io.in_int() in {
                            graph.add(i, curr, weight);
                            edges.add((new MSTEdge).init(i, curr, weight));
                        };
                        j <- j + 1;
                    } pool;
                };
                i <- i + 1;
            } pool;
            io.out_string("Confirming that the graph is:\n");
            graph.print();

            io.out_string("Source and destination (on separate lines):\n");
            let src: Int <- io.in_int(), dest: Int <- io.in_int() in {
                io.out_string("Shortest path from ")
                    .out_int(src).out_string(" to ")
                    .out_int(dest)
                    .out_string(" has a weight of ")
                    .out_int(graph.dijkstra(src, dest))
                    .out_string("\n");
            };

            io.out_string("Minimum spanning tree has cost: ");
            let mst: MST <- (new MST).init(edges, vertices) in {
                io.out_int(mst.totalCost()).out_string("\n");
            };
        };
    }};
};

(*
    a representation of an outgoing edge in a weighted graph
*)
class Edge {
    dest: Int;
    weight: Int;

    init(idest: Int, iweight: Int): Edge {{
        dest <- idest;
        weight <- iweight;
        self;
    }};

    getDest(): Int {dest};
    getWeight(): Int {weight};
};

class Graph {
    adjList: LinkedList;
    io: IO <- new IO;
    intMax: Int <- 2147483647; -- the maximum possible value of Int in Cool (2^31 - 1)

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

    reinterpret_cast_edge(val: Object): Edge {
        let dummy: Edge in {
            case val of 
                s: Edge => s;
                other: Object => {
                    abort();
                    dummy;
                };
            esac;
        }
    };

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

    print_pairs(list: LinkedList): Object {{
        let oldHead: Node <- list.getHead() in {
            while not (isvoid oldHead) loop {
                let curr: Edge <- reinterpret_cast_edge(oldHead.getData()) in {
                    io.out_int(curr.getDest())
                        .out_string(" ")
                        .out_int(curr.getWeight())
                        .out_string(", ");
                };
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
    add(begin: Int, end: Int, weight: Int): Graph {{ -- assuming the graph is directed
        reinterpret_cast_linkedList(adjList.at(begin)).add((new Edge).init(end, weight));
        self;
    }};

    fillDistances(distances: LinkedList, start: Int): LinkedList {{
        let index: Int <- 0 in {
            while index < adjList.getSize() loop {
                distances.add({if index = start then 0 else intMax fi;});
                index <- index + 1;
            } pool;
            distances;
        };
    }};

    (*
        Returns: the shortest distance between vertex 'start' and vertex 'end'
    *)
    dijkstra(start: Int, end: Int): Int {{
        let distances: LinkedList <- new LinkedList,
            pq: PriorityQueue <- (new PriorityQueue).init() in {
                fillDistances(distances, start);
                pq.push((new Edge).init(start, 0));
                while not (pq.isEmpty()) loop {
                    let curr: Edge <- pq.pop() in {
                        let currAdjList: LinkedList <- reinterpret_cast_linkedList(adjList.at(curr.getDest())),
                            distanceToCurr: Int <- reinterpret_cast_int(distances.at(curr.getDest())),
                            index: Int <- 0 in {
                            if not (isvoid currAdjList) then {
                                if not (isvoid distanceToCurr) then {
                                    while index < currAdjList.getSize() loop {
                                    let currAdj: Edge <- reinterpret_cast_edge(currAdjList.at(index)),
                                        distanceToAdj: Int <- reinterpret_cast_int(distances.at(currAdj.getDest())),
                                        distanceFromCurrToAdj: Int <- distanceToCurr + currAdj.getWeight() in {
                                            if distanceFromCurrToAdj < distanceToAdj then {
                                                distances.iat(currAdj.getDest()).setData(distanceFromCurrToAdj);
                                                pq.push((new Edge).init(currAdj.getDest(), distanceFromCurrToAdj));
                                            } else {index;} fi;
                                            index <- index + 1;
                                        };
                                    } pool;
                                } else {abort(); 0;} fi;
                            } else {abort(); 0;} fi;
                        };
                    };
                } pool;
                reinterpret_cast_int(distances.at(end));
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
                    print_pairs(currAdj);
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
class LinkedList {
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
            if node.getData() = el then node else iFind(el, node.getNext()) fi;
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
        let removalNode: Node <- find(el) in {
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

class MSTEdge {
    source: Int;
    dest: Int;
    weight: Int;

    init(isource: Int, idest: Int, iweight: Int): MSTEdge {{
        source <- isource;
        dest <- idest;
        weight <- iweight;
        self;
    }};

    getSource(): Int {source};
    getDest(): Int {dest};
    getWeight(): Int {weight};
};

class MST {
    edges: LinkedList;
    verticesCount: Int; -- the target amount of vertices in the MST

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

    reinterpret_cast_edge(val: Object): MSTEdge {
        let dummy: MSTEdge in {
            case val of 
                s: MSTEdge => s;
                other: Object => {
                    abort();
                    dummy;
                };
            esac;
        }
    };

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

    init(iedges: LinkedList, iverticesCount: Int): MST {{
        edges <- iedges; --copying only the pointer value (won't create an issue when using, unless original list is changed; would be a better approach to copy all data again)
        verticesCount <- iverticesCount; -- count of MST vertices = |V|, count of MST edges = |V| - 1, where |V| is the number of vertices in the input graph
        self;
    }};

    (*
        Returns: the list of edges of the graph sorted in ascending order by their weight
    *)
    sortEdges(): LinkedList {{
        let i: Int <- 0 in {
            while i < edges.getSize() loop {
                let minIndex: Int <- i, j: Int <- i + 1 in {
                    while j < edges.getSize() loop {
                        if reinterpret_cast_edge(edges.at(j)).getWeight() < reinterpret_cast_edge(edges.at(minIndex)).getWeight()
                            then {
                                minIndex <- j;
                            } else {minIndex;} fi;
                        j <- j + 1;
                    } pool;
                    if not (minIndex = i) then {edges.swap(minIndex, i);} else {edges;} fi;
                };
                i <- i + 1;
            } pool;
        };
        edges;
    }};

    (*
        Builds a minimum spanning tree/forest using Kruskal's algorithm, based on a list of weighted graph edges
        Returns: A list of edges of the resulting minimum spanning tree/forest
    *)
    kruskal(): LinkedList {{
        sortEdges();

        let result: LinkedList <- new LinkedList, i: Int <- 0, uf: UnionFind <- (new UnionFind).init(verticesCount) in {
            while i < edges.getSize() loop {
                if not (edges.getSize() <= verticesCount - 1) then {
                        let curr: MSTEdge <- reinterpret_cast_edge(edges.at(i)) in {
                        if uf.union(curr.getSource(), curr.getDest()) then {
                            result.add(curr);
                        } else {result;} fi;
                    };
                } else {verticesCount;} fi;
                i <- i + 1;
            } pool;
            result;
        };
    }};

    (*
        Calculates the total cost of the minimum spanning tree/forest.
    *)
    totalCost(): Int {{
        let mst: LinkedList <- kruskal(), sum: Int <- 0, i: Int <- 0 in {
            while i < mst.getSize() loop {
                sum <- sum + (reinterpret_cast_edge(mst.at(i)).getWeight());
                i <- i + 1;
            } pool;
            sum;
        };
    }};
};

class PriorityQueue {
    data: LinkedList;
    
    reinterpret_cast_edge(val: Object): Edge {
        let dummy: Edge in {
            case val of 
                s: Edge => s;
                other: Object => {
                    abort();
                    dummy;
                };
            esac;
        }
    };

    init(): PriorityQueue {{
        data <- new LinkedList;
        self;
    }};

    getParentIndex(index: Int): Int {
        (index - 1) / 2
    };

    push(el: Edge): PriorityQueue {{
        data.add(el);
        let index: Int <- data.getSize() - 1, parent: Int <- getParentIndex(index) in {
            while 0 < index loop {
                let currEdge: Edge <- reinterpret_cast_edge(data.at(index)),
                    parentEdge: Edge <- reinterpret_cast_edge(data.at(parent)) in {
                    if currEdge.getWeight() < parentEdge.getWeight() then {
                        data.swap(index, parent);
                    } else {data;} fi;
                    index <- parent;
                    parent <- getParentIndex(parent);
                };
            } pool;
        };
        self;
    }};

    heapify(index: Int): PriorityQueue {{
        let leftChildIndex: Int <- 2 * index + 1, 
            rightChildIndex: Int <- 2 * index + 2, 
            minIndex: Int <- index in {
            if leftChildIndex < data.getSize() then {
                if reinterpret_cast_edge(data.at(leftChildIndex)).getWeight() < reinterpret_cast_edge(data.at(minIndex)).getWeight()
                 then {minIndex <- leftChildIndex;}
                 else {leftChildIndex;} fi;
            } else {leftChildIndex;} fi;
            if rightChildIndex < data.getSize() then {
                if reinterpret_cast_edge(data.at(rightChildIndex)).getWeight() < reinterpret_cast_edge(data.at(minIndex)).getWeight()
                 then {minIndex <- rightChildIndex;}
                 else {rightChildIndex;} fi;
            } else {rightChildIndex;} fi;

            if not (minIndex = index) then {
                data.swap(minIndex, index);
                heapify(minIndex);
            } else {self;} fi;
        };
    }};

    pop(): Edge {{
        data.swap(0, data.getSize() - 1);

        let poppedEdge: Edge <- reinterpret_cast_edge(data.pop_back()) in {
            heapify(0);
            poppedEdge;
        };
    }};
    
    isEmpty(): Bool {data.isEmpty()};
};

(*
    An implementation of the disjoint set data structure that's used in Kruskal's algorithm 
    for finding a minimum spanning tree (if the graph is connected) or a minimum spanning forest (if the graph is not connected)

    The disjoint sets are ranked by height. Path compression is also implemented.

    The significance of the union find data structure for Kruskal's algorithm specifically is that each disjoint set
    represents a connected component in the graph
*)
class UnionFind {
    parents: LinkedList;
    heights: LinkedList;

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

    init(size: Int): UnionFind {{
        parents <- new LinkedList;
        heights <- new LinkedList;

        let i: Int <- 0 in {
            while i < size loop {
                parents.add(i);
                heights.add(0);
                i <- i + 1;
            } pool;
        };
        self;
    }};

    findParent(x: Int): Int {{
        if x = reinterpret_cast_int(parents.at(x)) then x else {
            reinterpret_cast_int(parents.iat(x).setData(findParent(reinterpret_cast_int(parents.at(x)))));
        } fi;
    }};

    (*
        Puts the two elements in a single set.
        Returns: true if the elements are added into a single set, false if the elements were already in a single set
    *)
    union(first: Int, second: Int): Bool {{
        let p1: Int <- findParent(first), p2: Int <- findParent(second),
            h1: Int <- reinterpret_cast_int(heights.at(p1)), h2: Int <- reinterpret_cast_int(heights.at(p2)) in {
            if p1 = p2 then false else {
                if h1 < h2 then {
                    parents.iat(p1).setData(p2);
                } else {
                    if h2 < h1 then {
                        parents.iat(p2).setData(p1);
                    } else {
                        parents.iat(p1).setData(p2);
                        heights.iat(p2).setData(h2 + 1);
                    } fi;
                } fi;
                true;
            } fi;
        };
    }};
};