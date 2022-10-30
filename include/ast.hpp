
#include <string>
#include "location.hh"

namespace Rang {
	class AstNode {
		public:
			AstNode(Rang::location loc) : location(loc) {};
			virtual std::string inspect(); 
		private:
			Rang::location location;
	};

	class AstNodeInteger : public AstNode {
		public:
			AstNodeInteger(uint64_t number, Rang::location loc) : AstNode(loc), val(number) {};
			virtual std::string inspect() override;
		private:
			uint64_t val;
	};
}
