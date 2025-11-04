parser grammar CoolParser;

options { tokenVocab=CoolLexer; }

program: (class ';')+ ;

class  : CLASS TYPEID '{' '}' ;
