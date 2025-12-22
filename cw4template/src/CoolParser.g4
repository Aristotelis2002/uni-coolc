parser grammar CoolParser;

options { tokenVocab=CoolLexer; }

program: (class ';')+ ;

class  : CLASS TYPEID ( INHERITS TYPEID )? '{' ((method | attr) ';')* '}' ;

method : OBJECTID '(' (formal (',' formal)*)? ')' ':' TYPEID '{' expr '}';
attr   : OBJECTID ':' TYPEID ( ASSIGN expr )? ;

formal : OBJECTID ':' TYPEID ;

expr   : expr ('@' TYPEID)? '.' OBJECTID '(' ( expr (',' expr )*)? ')'     // member invocation
       | OBJECTID '(' ( expr (',' expr )*)? ')'                            // method invocation
       | IF expr THEN expr ELSE expr FI                                    // if-then-else-fi 
       | WHILE expr LOOP expr POOL                                         // while-loop-pool 
       | '{' (expr ';')+ '}'                                               // composite statement
       | CASE expr OF (OBJECTID ':' TYPEID DARROW expr ';' )+ ESAC         // case-of-esac
       | NEW TYPEID                                                        // object instantiation
       | '(' expr ')'
       | '~' expr
       | ISVOID expr                                                       // void check
       | expr ('*'|'/') expr
       | expr ('+'|'-') expr
       | expr ('='|'<'|LE) expr
       | NOT expr
       | OBJECTID ASSIGN expr                                              // assignment
       | LET vardecl (',' vardecl)* IN expr                                // let-in; needs to be here for precedence
       | OBJECTID
       | INT_CONST
       | STR_CONST
       | BOOL_CONST;

vardecl : OBJECTID ':' TYPEID ( ASSIGN expr )?;
