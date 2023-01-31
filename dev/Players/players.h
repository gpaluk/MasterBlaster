unsigned int sprite_size;
unsigned char player_x;
unsigned char player_y;
unsigned char player_current_frame;
unsigned char player_direction;
unsigned char player_direction_offset;

// Player 1
#define PLAYER1_SPRITE_POSITION 256

// Walk up / down
#define PLAYER_UD_NUMBER_FRAMES 6
#define PLAYER_UD_NUMBER_TILES_BY_FRAME 2
#define PLAYER_UD_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS 12

// Walk left / right
#define PLAYER_LR_NUMBER_FRAMES 6
#define PLAYER_LR_NUMBER_TILES_BY_FRAME 2
#define PLAYER_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS 24

#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

void Player1Init()
{
    sprite_size = 32*6*12;
    player_x = 128-8;
    player_y = 96-12;
    player_direction = DOWN;
    player_current_frame = 0;
    player_direction_offset = 0;
}

void Player1Update(unsigned char time)
{
    Player1UpdatePosition();
    Player1UpdateDraw(time);
}

void Player1UpdatePosition()
{
    if(SMS_getKeysStatus() & PORT_A_KEY_UP)
    {
        if(player_direction != UP)
        {
            SMS_loadTiles(spritetiles_up_bin, PLAYER1_SPRITE_POSITION, sprite_size);
            player_direction = UP;
            player_current_frame = 0;
            player_direction_offset = 0;
        }
        player_y--;
    }
    else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
    {
        if(player_direction != DOWN)
        {
            SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, sprite_size);
            player_direction = DOWN;
            player_current_frame = 0;
            player_direction_offset = 0;
        }
        player_y++;
    }
    else if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
    {
        if(player_direction != LEFT)
        {
            if(player_direction != RIGHT)
            {
                SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, sprite_size);
            }
            player_direction = LEFT;
            player_current_frame = 0;
            player_direction_offset = PLAYER_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
        }
        player_x--;
    }
    else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
    {
        if(player_direction != RIGHT)
        {
            if(player_direction != LEFT)
            {
                SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, sprite_size);
            }
            player_direction = RIGHT;
            player_current_frame = 0;
            player_direction_offset = 0;
        }
        player_x++;
    }
}

void Player1UpdateDraw(unsigned char time)
{
    unsigned char i, j;

    if((time%8) == 0) {
        player_current_frame++;

        if(player_direction == UP)
        {
            if(player_current_frame == PLAYER_UD_NUMBER_FRAMES) {
                player_current_frame = 0;
            }
        }
        else if(player_direction == DOWN)
        {
            if(player_current_frame == PLAYER_UD_NUMBER_FRAMES) {
                player_current_frame = 0;
            }
        }
        else if(player_direction == LEFT)
        {
            if(player_current_frame == PLAYER_LR_NUMBER_FRAMES) {
                player_current_frame = 0;
            }
        }
        else if(player_direction == RIGHT)
        {
            if(player_current_frame == PLAYER_LR_NUMBER_FRAMES) {
                player_current_frame = 0;
            }
        }
    }

    if(player_direction == UP || player_direction == DOWN)
    {
        for(j=0; j<3; j++)
        {
            for(i=0; i<2; i++) {
                SMS_addSprite(player_x+(i<<3), player_y+(j<<3), PLAYER1_SPRITE_POSITION + player_direction_offset + player_current_frame * PLAYER_UD_NUMBER_TILES_BY_FRAME + PLAYER_UD_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
            }
        }
    }
    else if(player_direction == LEFT || player_direction == RIGHT)
    {
        for(j=0; j<3; j++)
        {
            for(i=0; i<2; i++) {
                SMS_addSprite(player_x+(i<<3), player_y+(j<<3), PLAYER1_SPRITE_POSITION + player_direction_offset + player_current_frame * PLAYER_LR_NUMBER_TILES_BY_FRAME + PLAYER_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
            }
        }
    }
}