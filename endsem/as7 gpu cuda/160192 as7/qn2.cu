#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define NUM 10000000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))


__device__ void function(int *a,int j)
{
    //double square = a ->num1 * a->num1 +  a->num2 * a->num2  + 2 * a->num1 * a->num2;
    //a->result = log(square)/sin(square);
    *(a) = (*a)^(*(a + j/2));
    
    return;
}
__global__ void calculate(int *mem, int num,int j)
{
      int i = blockDim.x * blockIdx.x + threadIdx.x;
      if((i + j/2) >= num)
           return;
      if(i%j == 0){
      	int *a = (int *)(mem + i);
      	function(a,j);
      }
      else
      	return;
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int i;
    int *ptr;
    int *gpu_mem;   
    unsigned long num = NUM;   /*Default value of num from MACRO*/
    int blocks;
    int seed;

    if(argc == 3){
         num = atoi(argv[1]);   /*Update after checking*/
         if(num <= 0)
               num = NUM;
         seed = atoi(argv[2]);
    }
    else{
    	printf("not correct input");
    	return -1;
    }

    /* Allocate host (CPU) memory and initialize*/

    ptr = (int *)malloc(num * sizeof(int));
    
    srand(seed);
    for(i=0; i<num; ++i){
       ptr[i] = random();
    }
    
    
    gettimeofday(&t_start, NULL);
    
    /* Allocate GPU memory and copy from CPU --> GPU*/

    cudaMalloc(&gpu_mem, num * sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, num * sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    
    gettimeofday(&start, NULL);
    
    blocks = num /1024;
    
    if(num % 1024)
           ++blocks;
	int j;
	for(j=2 ; j<2*num ; j*=2){
    	calculate<<<blocks, 1024>>>(gpu_mem, num,j);
    	CUDA_ERROR_EXIT("kernel invocation");
    }
    gettimeofday(&end, NULL);
    
    /* Copy back result*/

    cudaMemcpy(ptr, gpu_mem, num * sizeof(int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);
    
    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);
   
    /*Print the last element for sanity check*/ 
    //pa = (struct num_array *) (sptr + (num -1)*3*sizeof(double));
    printf("result = %d\n",*(ptr));

    
    free(ptr);
}
