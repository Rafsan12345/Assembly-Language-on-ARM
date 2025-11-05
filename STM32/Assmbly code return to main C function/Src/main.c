#include <stdint.h>

extern uint32_t simple_op(void);
extern uint32_t simple_result;
uint32_t ret;

int main(void)
{


    ret = simple_op();   // call assembly function

    while(1)
    {
        // ret = 15
        // simple_result = 15
    }
}
