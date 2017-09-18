#include <stdio.h>


void main(void)
{
	unsigned char i,v[100],dim=100;
	printf("Digite um numero:");
	scanf("%d",&i);
	if(i<0||i>=dim)
		printf("Fora dos Limites\n");
	else
		printf("Dentro dos Limites\n");

}