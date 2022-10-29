
/**
 * \mainpage Tang: A Replicated Language
 *
 * \section A Quick Description
 *
 * **Rang** is a C++ Replicated Language of Tang Template Language. It takes the form of a library wich may be included in other projects. It is under active development in this repo: 
 * [Github repository](https://www.github.com/JabSYsEmb/Rang)
 *
 * \section Feature
 *
 * The following features are planned:
 * - Native support for Unicode/Utf-8 strings.
 * - Change from template to script mode using escape tags like PHP.
 * - Loosely typed, with Python-like indexing and slicing of containers
 *
 * - Syntax similar to C/C++/PHP
 * - Code compiles to a custom Bytecode and is executed by the Tang VM.
 * - Fast and thread-safe
 *
 *
 *  \section License
 *
 *  \verbinclude LICENSE
 *
 */
namespace Rang {
	/**
	 * The base class for the Rang programming language.
	 *
	 * Rang program. It may be considered in three parts:
	 *
	 * 1. It acts as an extendable interface through which additional "library"
	 *
	 * 		functions can be added to the language.
	 *
	 * 		It is intentionally designed that each instance of \ref RangBase will have
	 *
	 * 		its own library functions.
	 *
	 * 2. It provides methods to compile scripts and templates, resulting 
	 *
	 *    \ref program object.
	 *
	 * 3. The \ref Program object may then be executed, providing 
	 *   
	 *    instance-specific context information (*i.e*, state).
	 *
	 */
	class RangBase {
		/**
		 * The constructor.
		 *
		 *
		 */
		public:
			RangBase();
	};
}
