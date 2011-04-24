%{
  open Expr
%}

%token LB RB POLY EOF
%token<string> IDENT
%token<int> INT

%type<string list> value_list
%type<expr> enum
%type<Expr.expr list> enum_list enums
%start enums

%%

enums : enum_list EOF {List.rev $1}

enum_list :
| enum { [$1] }
| enum_list enum { $2 :: $1}

enum :
| IDENT IDENT LB value_list RB {
  {name = $1; poly = false; prefix = 0; c_name = $2; values = List.rev $4} }
| POLY IDENT IDENT LB value_list RB {
  {name = $2; poly = true; prefix = 0; c_name = $3; values = List.rev $5}}
| POLY IDENT IDENT INT LB value_list RB {
  {name = $2; poly = true; prefix = $4; c_name = $3; values = List.rev $6}}

value_list :
| IDENT { [$1] }
| value_list IDENT { $2 :: $1 }
