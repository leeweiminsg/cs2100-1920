#include <stdio.h>

int add(int num1[], int num2[], int res[]);

int main(void)
{
    int i = 0;
    // int num1[16] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0};
    // int num2[16] = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0};
    // int num1[16] = {1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    // int num2[16] = {1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    // int num1[16] = {0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    // int num2[16] = {1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    int num1[16] = {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    int num2[16] = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    int res[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    printf("Overflow: %d", add(num1, num2, res));

    return 0;
}

int add(int num1[], int num2[], int res[])
{
    int i, isOverflow, carry = 0, total = 0;

    for (i = 15; i >= 0; i--)
    {
        total = num1[i] + num2[i] + carry;
        res[i] = total % 2;
        carry = total / 2;
    }

    if (num1[0] != num2[0])
    {
        isOverflow = 0;
    }
    else if (num1[0] == res[15])
    {
        isOverflow = 0;
    }
    else
    {
        isOverflow = 1;
    }

    printf("final carry: %d\n", carry);

    if (carry == 1)
    {

        for (i = 9; i >= 0; i--)
        {
            total = res[i] + carry;
            res[i] = total % 2;
            carry = total / 2;
        }
    }

    for (i = 0; i < 16; i++)
    {
        printf("%d", res[i]);
    }

    return isOverflow;
}