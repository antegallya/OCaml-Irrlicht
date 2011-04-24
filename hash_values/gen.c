#include<stdio.h>
#include<caml/mlvalues.h>
int main() {
printf("#define Val_A (%d)\n", caml_hash_variant("A"));
return 0;
}
