{
  open Parser
}

rule token = parse
| ['a'-'z' 'A'-'Z' '_' '0'-'9']+ as s {VARIANT s}
| ',' {COMMA}
| ' ' | '\t' | '\n' {token lexbuf}
| eof {EOF}
