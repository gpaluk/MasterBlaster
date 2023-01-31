#include <stdlib.h>
#include <stdbool.h>
#include "metatile.h"

typedef struct Entity {
    MetaTile* metatile[32];
    unsigned char frameRate;
    unsigned char numFrames;
    unsigned int currentFrame;
} Entity;

Entity* Entity_Create(MetaTile* metatile[], unsigned char numFrames) 
{
    Entity* entity = malloc(sizeof(struct Entity));
    // entity->metatile = malloc(sizeof(struct MetaTile) * 32);
    entity->currentFrame = 0;
    entity->frameRate = 16;
    entity->numFrames = numFrames;


    unsigned char i;
    for(i = 0; i < metatile[i]->numTiles; ++i)
    {
        entity->metatile[i] = metatile[i];
    }

    return entity;
}

void Entity_Delete(Entity* entity)
{
    if(entity != NULL)
        free(entity);
}

void Entity_Update(Entity* entity, unsigned int time)
{
    if((time % entity->frameRate) == 0)
    {
        entity->currentFrame++;
    }
    
    if(entity->currentFrame > entity->numFrames)
    {
        entity->currentFrame = 0;
    }
}

unsigned char Entity_GetCurrentFrame(Entity* entity)
{
    return entity->currentFrame;
}

unsigned char Entity_GetFrameRate(Entity* entity)
{
    return entity->frameRate;
}

void Entity_Draw
(
    Entity* entity,
    unsigned char x,
    unsigned char y
) {
    MetaTile_Draw(entity->metatile[entity->currentFrame], x, y);
}
