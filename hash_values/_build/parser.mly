%token COMMA EOF
%token<string> VARIANT

%type<(string * string) list> variants variant_list
%type<string * string> variant

%start variants

%%

variants :
| variant_list EOF {List.rev $1}
| variant_list COMMA EOF {List.rev $1 }
| EOF { [] }

variant_list :
| variant { [$1] }
| variant_list COMMA variant { $3 :: $1 }

variant : VARIANT VARIANT {($1, $2)}
