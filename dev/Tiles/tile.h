#include <stdbool.h>
#include <stdlib.h>

/**
 * @param unsigned char id;
 * @param bool collidable;
 * @param bool flipX;
 * @param bool flipY;
 * @param bool useSpritePalette;
 * @param bool priority;
 * @param unsigned int computedId;
*/
typedef struct Tile
{
    unsigned char id;
    bool collidable;
    bool flipX;
    bool flipY;
    bool useSpritePalette;
    bool priority;
    unsigned int computedId;
} Tile;

void Tile_Update(Tile* tile)
{
    tile->computedId = tile->id;

    if(tile->flipX)
        tile->computedId += TILE_FLIPPED_X;

    if(tile->flipY)
        tile->computedId += TILE_FLIPPED_Y;

    if(tile->useSpritePalette)
        tile->computedId += TILE_USE_SPRITE_PALETTE;
    
    if(tile->priority)
        tile->computedId += TILE_PRIORITY;
}

Tile* CreateTile
(
    unsigned char id,
    bool collidable,
    bool flipX,
    bool flipY,
    bool useSpritePalette,
    bool priority
) {
    struct Tile *tile = malloc(sizeof (struct Tile));
    tile->id = id;
    tile->collidable = collidable;
    tile->flipX = flipX;
    tile->flipY = flipY;
    tile->useSpritePalette = useSpritePalette;
    tile->priority = priority;

    Tile_Update(tile);
    
    if (tile == NULL)
        return NULL;

    return tile;
}

void DeleteTile(Tile *tile)
{
    if(tile != NULL)
        free(tile);
}
