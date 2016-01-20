#include <time.h>
#include <stdio.h>

int main()
{
    unsigned long long start = rdtsc();
    for(int i=0; i<10; i++)
    {
        printf("TEST\n");
    }
    unsigned long long stop = rdtsc();
    printf("measured time: %lld [clock]\n", stop - start);
    
    return 0;
}