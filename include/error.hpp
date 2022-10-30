
#include <string>
#include "location.hh"

namespace Rang {
	class Error {
	public:
		Error();
		Error(std::string message, Rang::location location) : message(message), location(location) {};
		std::string message;
		Rang::location location;
	};
}
