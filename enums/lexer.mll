{
  open Parser
}

rule token = parse
| '{' {LB}
| '}' {RB}
| ' ' | '\t' | '\n' {token lexbuf}
| "poly" { POLY }
| ['0'-'9']+ as s {INT (int_of_string s) }
| ['a'-'z' 'A'-'Z' '0'-'9' '_']+ as s { IDENT s}
| eof {EOF}
