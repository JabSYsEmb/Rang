#include <iostream>
#include "ast.hpp"

using namespace std;
using namespace Rang;

string Rang::AstNode::inspect() 
{
	return "inspect";
}

string Rang::AstNodeInteger::inspect() 
{
	return to_string(this->val);
}
