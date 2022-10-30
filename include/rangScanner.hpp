#ifndef RANGSCANNER_HPP
#define RANGSCANNER_HPP

#ifndef FLEXINT_H
#undef yyFlexLexer
#define yyFlexLexer RangRangFlexLexer
#include <FlexLexer.h>
#endif //FLEXINT_H

#undef YY_DECL
#define YY_DECL Rang::RangParser::symbol_type Rang::RangScanner::get_next_token()

#include <iostream>
#include "rangParser.hpp"

namespace Rang {
	class RangScanner : public yyFlexLexer {
		public:
			RangScanner ( std::istream& arg_yyin, std::ostream& arg_yyout ) : yyFlexLexer(arg_yyin, arg_yyout) {};
			virtual Rang::RangParser::symbol_type get_next_token();
		private:
			Rang::location location;
	};
}

#endif // RANGSCANNER_HPP
