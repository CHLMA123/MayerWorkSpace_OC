# MayerWorkSpace_OC
不积跬步无以至千里

#闭包是一个函数（或指向函数的指针），再加上该函数执行的外部的上下文变量（有时候也称作自由变量）。

#block 实际上就是 Objective-C 语言对于闭包的实现。
#block 配合上 dispatch_queue，可以方便地实现简单的多线程编程和异步编程，关于这个，我之前写过一篇文章介绍：《使用 GCD》。

Objective-C Blocks Quiz

Example A

void exampleA() {
char a = 'A';
^{
printf("%cn", a);
}();
}

This example:
A: always works. 
B: only works with ARC.
C: Only works without ARC.
D: nerver works.

That's correct. This always works. The stack for exampleA doesn't go away until after the block has finished executing. So whether the block is allocated on the stack or the heap, it will be valid when it is executed.(A)


Example B

void exampleB_addBlockToArray(NSMutableArray *array) {
char b = 'B';
[array addObject:^{
printf("%cn", b);
}];
}

void exampleB() {
NSMutableArray *array = [NSMutableArray array];
exampleB_addBlockToArray(array);
void (^block)() = [array objectAtIndex:0];
block();
}

This example:
A: always works. 
B: only works with ARC.
C: Only works without ARC.
D: nerver works.

That's correct. Without ARC, the block is an NSStackBlock allocated on the stack of exampleB_addBlockToArray. By the time it executes in exampleB, the the block is no longer valid, because that stack has been cleared.

With ARC, the block is properly allocated on the heap as an autoreleased NSMallocBlock to begin with.(B)

Example C

void exampleC_addBlockToArray(NSMutableArray *array) {
[array addObject:^{
printf("Cn");
}];
}

void exampleC() {
NSMutableArray *array = [NSMutableArray array];
exampleC_addBlockToArray(array);
void (^block)() = [array objectAtIndex:0];
block();
}

This example:
A: always works. 
B: only works with ARC.
C: Only works without ARC.
D: nerver works.

That's correct. Since the block doesn't capture any variables in its closure, it doesn't need any state set up at runtime. it gets compiled as an NSGlobalBlock. It's neither on the stack nor the heap, but part of the code segment, like any C function. This works both with and without ARC.(A)

Example D

typedef void (^dBlock)();

dBlock exampleD_getBlock() {
char d = 'D';
return ^{
printf("%cn", d);
};
}

void exampleD() {
exampleD_getBlock()();
}

This example:
A: always works. 
B: only works with ARC.
C: Only works without ARC.
D: nerver works.

That's correct. This is similar to example B. Without ARC, the block would be created on the stack of exampleD_getBlock and then immediately become invalid when that function returns. However, in this case, the error is so obvious that the compiler will fail to compile, with the error error: returning block that lives on the local stack.

With ARC, the block is correctly placed on the heap as an autoreleased NSMallocBlock.(B)

Example E

typedef void (^eBlock)();

eBlock exampleE_getBlock() {
char e = 'E';
void (^block)() = ^{
printf("%cn", e);
};
return block;
}

void exampleE() {
eBlock block = exampleE_getBlock();
block();
}

This example:
A: always works. 
B: only works with ARC.
C: Only works without ARC.
D: nerver works.

That's correct. This is just like example D, except that the compiler doesn't recognize it as an error, so this code compiles and crashes. Even worse, this particular example happens to work fine if you disable optimizations. So watch out for this working while testing and failing in production.

With ARC, the block is correctly placed on the heap as an autoreleased NSMallocBlock.(B)


Conclusions

So, what's the point of all this? The point is always use ARC. With ARC, blocks pretty much always work correctly. If you're not using ARC, you better defensively block = [[block copy] autorelease] any time a block outlives the stack frame where it is declared. That will force it to be copied to the heap as an NSMallocBlock.

Haha! No, of course it's not that simple. According to Apple:

Blocks "just work" when you pass blocks up the stack in ARC mode, such as in a return. You don't have to call Block Copy any more. You still need to use [^{} copy] when passing "down" the stack into arrayWithObjects: and other methods that do a retain.
