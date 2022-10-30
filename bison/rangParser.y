%require "3.8.2"
%skeleton "lalr1.cc"
%defines

%define api.namespace { Rang }
%define api.parser.class { RangParser }
%define api.value.type variant
%define api.token.constructor
%define parse.assert
%define parse.trace
%define parse.error verbose
%locations
%lex-param { Rang::RangScanner & scanner }
%parse-param { Rang::RangScanner & scanner }
%parse-param { Rang::AstNode * & ast }
%parse-param { Rang::Error * & parseError }
%define api.token.prefix {RANG_PARSER_}

%token EOF 0 "end of code"
%token < int64_t > INTEGER "integer"

%type < Rang::AstNode * > program
%type < Rang::AstNode * > expression

%code requires {
#include <stdint.H>
#include "ast.hpp"
#include "error.hpp"
namespace Rang {
	class RangScanner;
	}
}

%code top {
#include "rangScanner.hpp"
#include "rangParser.hpp"
#include "location.hh"
static Rang::RangParser::symbol_type yylex(Rang::RangScanner & scanner) { 
	return scanner.get_next_token();
}
}

%start program

%%

program
 : expression
   {
	  ast = $1;
	 }
 | EOF
 	 {}
 ;

expression
 : INTEGER
   {
	   $$ = new Rang::AstNodeInteger($1, @1);
	 }
 ;


%%

void Rang::RangParser::error(const location & location, const std::string & message)
{
  parseError = new Error{message, location};
}


