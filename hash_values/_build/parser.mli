type token =
  | COMMA
  | EOF
  | VARIANT of (string)

val variants :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (string * string) list
