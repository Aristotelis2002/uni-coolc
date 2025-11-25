
// Generated from /code/tools/../src/CoolParser.g4 by ANTLR 4.13.2

#pragma once

#include "CoolParserVisitor.h"
#include "antlr4-runtime.h"

/**
 * This class provides an empty implementation of CoolParserVisitor, which can
 * be extended to create a visitor which only needs to handle a subset of the
 * available methods.
 */
class CoolParserBaseVisitor : public CoolParserVisitor {
  public:
    virtual std::any visitProgram(CoolParser::ProgramContext *ctx) override {
        return visitChildren(ctx);
    }

    virtual std::any visitClass(CoolParser::ClassContext *ctx) override {
        return visitChildren(ctx);
    }

    virtual std::any visitMethod(CoolParser::MethodContext *ctx) override {
        return visitChildren(ctx);
    }

    virtual std::any visitAttr(CoolParser::AttrContext *ctx) override {
        return visitChildren(ctx);
    }

    virtual std::any visitFormal(CoolParser::FormalContext *ctx) override {
        return visitChildren(ctx);
    }

    virtual std::any visitExpr(CoolParser::ExprContext *ctx) override {
        return visitChildren(ctx);
    }

    virtual std::any visitVardecl(CoolParser::VardeclContext *ctx) override {
        return visitChildren(ctx);
    }
};
