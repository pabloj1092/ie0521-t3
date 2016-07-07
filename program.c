
#include<stdio.h>

// funcion que crea que comportamiento necesario
int numbers(int p1, int p2, int p3, int p4, int p5, int p6, int p7){
  if (p7>4){
    return p1 + p2 + p3 + p4 - p5 - p6;
  }
  else{
    return p1 + p2 + p3 + p4 + p5 - p6;
  }
}


//main
int main () {

printf("%d\n", numbers(1,1,1,1,1,1,3));

}
