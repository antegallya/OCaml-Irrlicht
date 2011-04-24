type token =
  | LB
  | RB
  | POLY
  | EOF
  | IDENT of (string)
  | INT of (int)

val enums :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Expr.expr list
