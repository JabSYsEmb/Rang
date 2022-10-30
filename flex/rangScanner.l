%option c++
%option yyclass="RangScanner"
%option prefix="RangRang"
%option noyywrap
%option nodefault
%option never-interactive
%option stack


%{
#include <cstdlib>

#include "rangScanner.hpp"
#include "rangParser.hpp"
#include "location.hh"


using namespace std;

#define yyterminate() return Rang::RangParser::make_EOF(Rang::location(location))

#define YY_USER_ACTION {             \
	location.step();                   \
	for (int i = 0; i < yyleng; ++i) { \
		if (yytext[i] == '\n') {         \
			location.end.column = 0;       \
			location.lines();              \
		}                                \
		else {                           \
			location.columns();            \
		}                                \
	}                                  \
}

%}

%x SCRIPT

%%

<INITIAL,SCRIPT>{
	[0-9]+ {
		int64_t number = strtoll(yytext, 0, 10);
		return Rang::RangParser::make_INTEGER(number, Rang::location(location));
	}
	. {}
	\n {}
	<<EOF>> {yyterminate();}
}

%%
