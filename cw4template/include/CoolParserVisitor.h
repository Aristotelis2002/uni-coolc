
// Generated from /code/tools/../src/CoolParser.g4 by ANTLR 4.13.2

#pragma once

#include "CoolParser.h"
#include "antlr4-runtime.h"

/**
 * This class defines an abstract visitor for a parse tree
 * produced by CoolParser.
 */
class CoolParserVisitor : public antlr4::tree::AbstractParseTreeVisitor {
  public:
    /**
     * Visit parse trees produced by CoolParser.
     */
    virtual std::any visitProgram(CoolParser::ProgramContext *context) = 0;

    virtual std::any visitClass(CoolParser::ClassContext *context) = 0;

    virtual std::any visitMethod(CoolParser::MethodContext *context) = 0;

    virtual std::any visitAttr(CoolParser::AttrContext *context) = 0;

    virtual std::any visitFormal(CoolParser::FormalContext *context) = 0;

    virtual std::any visitExpr(CoolParser::ExprContext *context) = 0;

    virtual std::any visitVardecl(CoolParser::VardeclContext *context) = 0;
};
