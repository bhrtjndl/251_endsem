#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>

#define SEED 0x7457

#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct thread_param{
                       pthread_t tid;
                       int *array;
                       int size;
                       int skip;
                       int thread_ctr;
                       int max;  
                       int max_index;
};

int function(int element)
{
    int flag=1;
    for(int i=2;i<=sqrt(element);i++){
      if(element%i==0){
        flag=0;
        break;
      }
    }
    return flag;
}

void* find_max(void *arg)
{
     struct thread_param *param = (struct thread_param *) arg;
      int ctr = param->thread_ctr;
     
     int z =  function(param->array[ctr]);
    
    if(z==0){
      param->max=-1;
      param->max_index=-1;
    }
    else{
      param->max = (param->array[ctr]);
      param->max_index = ctr;
    }
   
     ctr += param->skip;
     while(ctr < param->size){
           int x = param->array[ctr];
           int z=  function(param->array[ctr]);
           if(x > param->max && z==1){
                param->max = x; 
                param->max_index = ctr;
           }
           
          ctr += param->skip;
     }    
     return NULL;
     
}





int main(int argc, char **argv)
{
  struct thread_param *params;
  struct timeval start, end;
  int *a, num_elements, ctr, num_threads;
  long long int max;
  int max_index;

  if(argc !=3)
           USAGE_EXIT("not enough parameters");

  num_elements = atoi(argv[1]);
  if(num_elements <=0)
          USAGE_EXIT("invalid num elements");
  
  num_threads = atoi(argv[2]);
  if(num_threads <=0 || num_threads > MAX_THREADS){
          USAGE_EXIT("invalid num of threads");
  }


  a = malloc(num_elements * sizeof(int));
  if(!a){
          USAGE_EXIT("invalid num elements, not enough memory");
  }

  srand(SEED);  
  for(ctr=0; ctr<num_elements; ++ctr){
        a[ctr] = random();
        }
 
  params = malloc(num_threads * sizeof(struct thread_param));
  bzero(params, num_threads * sizeof(struct thread_param));

  gettimeofday(&start, NULL);

 
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        param->size = num_elements;
        param->skip = num_threads;
         param->array = a;
          param->thread_ctr = ctr;
        
        if(pthread_create(&param->tid, NULL, find_max, param) != 0){
              perror("pthread_create");
              exit(-1);
        }
 
  }
  
  /*Wait for threads to finish their execution*/      
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        pthread_join(param->tid, NULL);
        if(ctr == 0 || (ctr > 0 && param->max > max)){
             max = param->max;    
             max_index = param->max_index;
        }
  }
  
  if(max==-1 && max_index==-1){
     printf("No Prime Number\n");
  }
  else{
    printf("Max Prime Number = %lld at index = %d\n", max, max_index);
  }
  gettimeofday(&end, NULL);
  printf("Time taken = %ld microsecs\n", TDIFF(start, end));
  free(a);
  free(params);
}
