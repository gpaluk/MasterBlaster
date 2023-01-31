#include "../../lib/SMSlib.h"

void InitStage()
{
    // char arr[4][7] = {
    //     {2, 11, 11, 11, 4, 2, 5},
    //     {11, 3, 11, 11, 4, 2, 5},
    //     {11, 11, 4, 11, 4, 2, 5},
    //     {11, 11, 11, 3, 4, 2, 5}
    // };

    // char arrWidth = sizeof(arr[0]) / sizeof(unsigned char);
    // char arrHeight = sizeof(arr) / arrWidth;

    int arr[] = {
        2, 2 + 0x0200, 11, 11, 4, 2, 5,
        11, 3, 11, 11, 4, 2, 5,
        11, 11, 4, 11, 4, 2, 5,
        11, 11, 11, 3, 4, 2, 5
    };

    SMS_loadTileMapArea(1, 3, arr, 7, 4);
}
