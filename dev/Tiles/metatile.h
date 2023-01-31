#include <stdbool.h>
#include <stdlib.h>
#include "../../lib/SMSlib.h"
#include "tile.h"

typedef struct MetaTile
{
    struct Tile tiles[16];
    unsigned char numTiles;
    unsigned char numTilesX;
    unsigned char numTilesY;
} MetaTile;

MetaTile* MetaTile_Create
(
    Tile tiles[16],
    unsigned char numTiles,
    unsigned char numTilesX,
    unsigned char numTilesY
) {
    unsigned char tileXY = numTilesX * numTilesY;

    if(tileXY > 16)
    {
        // We have an error here
    }
    unsigned char numMetatiles = numTiles / tileXY;
    
    MetaTile* metatile = malloc(sizeof (struct MetaTile));
    metatile->numTilesX = numTilesX;
    metatile->numTilesY = numTilesY;
    metatile->numTiles = numTiles;

    unsigned char i;
    for(i = 0; i < metatile->numTiles; ++i)
    {
        metatile->tiles[i] = tiles[i];
    }

    return metatile;
}

void MetaTile_Draw
(
    MetaTile* metatile,
    unsigned char x,
    unsigned char y
) {
    unsigned int tileIds[16];
    unsigned char tilesXY = metatile->numTilesX;

    unsigned char i;
    for(i = 0; i < tilesXY; ++i)
    {
        tileIds[i] = metatile->tiles[0].computedId; // TODO: Not working correctly
        tileIds[i] = 0x1011;
    }

    SMS_loadTileMapArea(x, y, tileIds, 2, 2);
}
