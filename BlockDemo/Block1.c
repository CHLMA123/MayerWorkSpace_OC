//
//  Block1.c
//  runtime
//
//  Created by MCL on 2016/11/25.

#include <stdio.h>

int main()
{
    int b = 10;
    
    int *a = &b;
    
    void (^blockFunc)() = ^(){
        
        int *c = a;
        
    };
    
    blockFunc();
    
    return 1;
}

