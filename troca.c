#include <stdint.h>
#include <stdio.h>

int main(int argc, char const *argv[])
{
	/*Declaração do número de cartas e de trocas.*/
	uint32_t n,t;
	/*Lê n e t*/
	scanf("%d %d",&n,&t);

	/*Declaração dos vetores e das posições inicial e final de troca.*/
	uint32_t cima[n];
	uint32_t baixo[n];
	uint32_t p,i,j;
	/*Lê cima e baixo*/
	for (i = 0; i < n; ++i)
	{
		scanf("%d",&cima[i]);
	}
	for (i = 0; i < n; ++i)
	{
		scanf("%d",&baixo[i]);
	}
	/*Executa as trocas*/
	while(t>0){
		/*Lê posição inicial de troca e a final*/
		scanf("%d %d",&p,&j);
		p--;
		uint32_t aux;
		for (i = p; i < j; ++i)
		{
			aux = cima[i];
			cima[i] = baixo[i];
			baixo[i] = aux;
		}
		t--;
	}
	/*Imprime resultado*/
	for (i = 0; i < n; ++i)
	{
		printf("%d ", cima[i]);
	}
	printf("\n");
	return 0;
}