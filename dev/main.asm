;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___SMS__SDSC_signature
	.globl ___SMS__SDSC_descr
	.globl ___SMS__SDSC_name
	.globl ___SMS__SDSC_author
	.globl ___SMS__SEGA_signature
	.globl _main
	.globl _loadGraphics2vram
	.globl _Entity_Draw
	.globl _Entity_GetFrameRate
	.globl _Entity_GetCurrentFrame
	.globl _Entity_Update
	.globl _Entity_Delete
	.globl _Entity_Create
	.globl _MetaTile_Draw
	.globl _MetaTile_Create
	.globl _DeleteTile
	.globl _CreateTile
	.globl _Tile_Update
	.globl _SMS_VRAMmemsetW
	.globl _SMS_VRAMmemcpy
	.globl _SMS_loadSpritePalette
	.globl _SMS_loadBGPalette
	.globl _SMS_copySpritestoSAT
	.globl _SMS_finalizeSprites
	.globl _SMS_initSprites
	.globl _SMS_loadTileMapArea
	.globl _SMS_loadPSGaidencompressedTilesatAddr
	.globl _SMS_waitForVBlank
	.globl _SMS_VDPturnOnFeature
	.globl _free
	.globl _malloc
	.globl _Player1Init
	.globl _checkgamepause
	.globl _InitConsole
	.globl _InterruptHandler
	.globl _PSGSFXFrame
	.globl _PSGFrame
	.globl _PSGSFXGetStatus
	.globl _PSGPlayNoRepeat
	.globl _PSGPlay
	.globl _entity
	.globl _volume_atenuation
	.globl _frame_counter
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
	.globl _ROM_bank_to_be_mapped_on_slot2
	.globl _player_direction_offset
	.globl _player_direction
	.globl _player_current_frame
	.globl _player_y
	.globl _player_x
	.globl _sprite_size
	.globl _gamepause
	.globl _numinterrupts
	.globl _Player1Update
	.globl _Player1UpdatePosition
	.globl _Player1UpdateDraw
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_numinterrupts::
	.ds 1
_gamepause::
	.ds 1
_sprite_size::
	.ds 2
_player_x::
	.ds 1
_player_y::
	.ds 1
_player_current_frame::
	.ds 1
_player_direction::
	.ds 1
_player_direction_offset::
	.ds 1
_ROM_bank_to_be_mapped_on_slot2	=	0xffff
_ROM_bank_to_be_mapped_on_slot1	=	0xfffe
_ROM_bank_to_be_mapped_on_slot0	=	0xfffd
_SRAM_bank_to_be_mapped_on_slot2	=	0xfffc
_SMS_SRAM	=	0x8000
_frame_counter::
	.ds 1
_volume_atenuation::
	.ds 1
_entity::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;Core\funcs.h:6: void InterruptHandler(void)
;	---------------------------------
; Function InterruptHandler
; ---------------------------------
_InterruptHandler::
;Core\funcs.h:9: }
	ret
;Core\funcs.h:11: void InitConsole(void)
;	---------------------------------
; Function InitConsole
; ---------------------------------
_InitConsole::
;Core\funcs.h:14: SMS_init();
	call	_SMS_init
;Core\funcs.h:17: SMS_getKeysStatus();
	call	_SMS_getKeysStatus
;Core\funcs.h:20: SMS_setLineInterruptHandler(&InterruptHandler);
	ld	hl, #_InterruptHandler
	call	_SMS_setLineInterruptHandler
;Core\funcs.h:21: SMS_setLineCounter (192);
	ld	l, #0xc0
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setLineCounter
;Core\funcs.h:22: SMS_enableLineInterrupt();
	ld	hl, #0x0010
	call	_SMS_VDPturnOnFeature
;Core\funcs.h:25: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
;Core\funcs.h:26: }
	jp	_SMS_VDPturnOnFeature
;Core\funcs.h:28: void checkgamepause()
;	---------------------------------
; Function checkgamepause
; ---------------------------------
_checkgamepause::
;Core\funcs.h:30: if(SMS_queryPauseRequested())
	call	_SMS_queryPauseRequested
	bit	0,a
	ret	Z
;Core\funcs.h:32: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;Core\funcs.h:33: gamepause=1-gamepause;
	ld	a, (_gamepause+0)
	ld	c, a
	ld	hl, #_gamepause
	ld	a, #0x01
	sub	a, c
	ld	(hl), a
;Core\funcs.h:34: if(gamepause==1)
	ld	a, (_gamepause+0)
	dec	a
	jr	NZ, 00102$
;Core\funcs.h:35: PSGPlayNoRepeat(pause_psg);
	ld	hl, #_pause_psg
	jp	_PSGPlayNoRepeat
00102$:
;Core\funcs.h:37: PSGPlay(music_psg);
	ld	hl, #_music_psg
;Core\funcs.h:39: }
	jp	_PSGPlay
;Players/players.h:26: void Player1Init()
;	---------------------------------
; Function Player1Init
; ---------------------------------
_Player1Init::
;Players/players.h:28: sprite_size = 32*6*12;
	ld	hl, #0x0900
	ld	(_sprite_size), hl
;Players/players.h:29: player_x = 128-8;
	ld	hl, #_player_x
	ld	(hl), #0x78
;Players/players.h:30: player_y = 96-12;
	ld	hl, #_player_y
	ld	(hl), #0x54
;Players/players.h:31: player_direction = DOWN;
	ld	hl, #_player_direction
	ld	(hl), #0x01
;Players/players.h:32: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:33: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
;Players/players.h:34: }
	ret
;Players/players.h:36: void Player1Update(unsigned char time)
;	---------------------------------
; Function Player1Update
; ---------------------------------
_Player1Update::
	ld	c, a
;Players/players.h:38: Player1UpdatePosition();
	push	bc
	call	_Player1UpdatePosition
	pop	bc
;Players/players.h:39: Player1UpdateDraw(time);
	ld	a, c
;Players/players.h:40: }
	jp	_Player1UpdateDraw
;Players/players.h:42: void Player1UpdatePosition()
;	---------------------------------
; Function Player1UpdatePosition
; ---------------------------------
_Player1UpdatePosition::
;Players/players.h:44: if(SMS_getKeysStatus() & PORT_A_KEY_UP)
	call	_SMS_getKeysStatus
	bit	0, e
	jr	Z, 00122$
;Players/players.h:46: if(player_direction != UP)
	ld	a, (_player_direction+0)
	or	a, a
	jr	Z, 00102$
;Players/players.h:48: SMS_loadTiles(spritetiles_up_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_up_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
;Players/players.h:49: player_direction = UP;
	ld	hl, #_player_direction
	ld	(hl), #0x00
;Players/players.h:50: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:51: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
00102$:
;Players/players.h:53: player_y--;
	ld	hl, #_player_y
	dec	(hl)
	ret
00122$:
;Players/players.h:55: else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
	call	_SMS_getKeysStatus
	bit	1, e
	jr	Z, 00119$
;Players/players.h:57: if(player_direction != DOWN)
	ld	a, (_player_direction+0)
	dec	a
	jr	Z, 00104$
;Players/players.h:59: SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_down_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
;Players/players.h:60: player_direction = DOWN;
	ld	hl, #_player_direction
	ld	(hl), #0x01
;Players/players.h:61: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:62: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
00104$:
;Players/players.h:64: player_y++;
	ld	hl, #_player_y
	inc	(hl)
	ret
00119$:
;Players/players.h:66: else if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
	call	_SMS_getKeysStatus
	bit	2, e
	jr	Z, 00116$
;Players/players.h:68: if(player_direction != LEFT)
;Players/players.h:70: if(player_direction != RIGHT)
	ld	a,(_player_direction+0)
	cp	a,#0x02
	jr	Z, 00108$
	sub	a, #0x03
	jr	Z, 00106$
;Players/players.h:72: SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_lr_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
00106$:
;Players/players.h:74: player_direction = LEFT;
	ld	hl, #_player_direction
	ld	(hl), #0x02
;Players/players.h:75: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:76: player_direction_offset = PLAYER_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x0c
00108$:
;Players/players.h:78: player_x--;
	ld	hl, #_player_x
	dec	(hl)
	ret
00116$:
;Players/players.h:80: else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
	call	_SMS_getKeysStatus
	bit	3, e
	ret	Z
;Players/players.h:82: if(player_direction != RIGHT)
;Players/players.h:84: if(player_direction != LEFT)
	ld	a,(_player_direction+0)
	cp	a,#0x03
	jr	Z, 00112$
	sub	a, #0x02
	jr	Z, 00110$
;Players/players.h:86: SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_lr_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
00110$:
;Players/players.h:88: player_direction = RIGHT;
	ld	hl, #_player_direction
	ld	(hl), #0x03
;Players/players.h:89: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:90: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
00112$:
;Players/players.h:92: player_x++;
	ld	hl, #_player_x
	inc	(hl)
;Players/players.h:94: }
	ret
;Players/players.h:96: void Player1UpdateDraw(unsigned char time)
;	---------------------------------
; Function Player1UpdateDraw
; ---------------------------------
_Player1UpdateDraw::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;Players/players.h:100: if((time%8) == 0) {
	and	a, #0x07
	jr	NZ, 00121$
;Players/players.h:101: player_current_frame++;
	ld	iy, #_player_current_frame
	inc	0 (iy)
;Players/players.h:103: if(player_direction == UP)
	ld	a, (_player_direction+0)
	or	a, a
	jr	NZ, 00118$
;Players/players.h:105: if(player_current_frame == PLAYER_UD_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:106: player_current_frame = 0;
	ld	0 (iy), #0x00
	jp	00121$
00118$:
;Players/players.h:109: else if(player_direction == DOWN)
	ld	a, (_player_direction+0)
	dec	a
	jr	NZ, 00115$
;Players/players.h:111: if(player_current_frame == PLAYER_UD_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:112: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
	jp	00121$
00115$:
;Players/players.h:115: else if(player_direction == LEFT)
	ld	a, (_player_direction+0)
	sub	a, #0x02
	jr	NZ, 00112$
;Players/players.h:117: if(player_current_frame == PLAYER_LR_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:118: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
	jp	00121$
00112$:
;Players/players.h:121: else if(player_direction == RIGHT)
	ld	a, (_player_direction+0)
	sub	a, #0x03
	jr	NZ, 00121$
;Players/players.h:123: if(player_current_frame == PLAYER_LR_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:124: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
00121$:
;Players/players.h:129: if(player_direction == UP || player_direction == DOWN)
	ld	a, (_player_direction+0)
	or	a, a
	jr	Z, 00155$
	ld	a, (_player_direction+0)
	dec	a
	jp	NZ,00130$
;Players/players.h:131: for(j=0; j<3; j++)
00155$:
	ld	-2 (ix), #0x00
;Players/players.h:133: for(i=0; i<2; i++) {
00153$:
	ld	-1 (ix), #0x00
00133$:
;Players/players.h:134: SMS_addSprite(player_x+(i<<3), player_y+(j<<3), PLAYER1_SPRITE_POSITION + player_direction_offset + player_current_frame * PLAYER_UD_NUMBER_TILES_BY_FRAME + PLAYER_UD_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a, (_player_x+0)
	ld	e, a
	ld	d, #0x00
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
;	spillPairReg hl
;	spillPairReg hl
	ld	-3 (ix), l
	ld	-4 (ix), #0x00
	ld	a, (_player_direction_offset+0)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	e, a
	xor	a, a
	inc	a
	ld	d, a
	ld	a, (_player_current_frame+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, de
	push	hl
	pop	iy
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	pop	de
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	push	iy
	pop	hl
	add	hl, bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -4 (ix)
	or	a, l
	ld	c, a
	ld	a, -3 (ix)
	or	a, h
	ld	b, a
	ld	a, (_player_y+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	hl, de
	ld	e, c
	ld	d, b
	call	_SMS_addSprite_f
;Players/players.h:133: for(i=0; i<2; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jr	C, 00133$
;Players/players.h:131: for(j=0; j<3; j++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x03
	jr	C, 00153$
	jp	00141$
00130$:
;Players/players.h:138: else if(player_direction == LEFT || player_direction == RIGHT)
	ld	a,(_player_direction+0)
	cp	a,#0x02
	jr	Z, 00160$
	sub	a, #0x03
	jp	NZ,00141$
;Players/players.h:140: for(j=0; j<3; j++)
00160$:
	ld	-2 (ix), #0x00
;Players/players.h:142: for(i=0; i<2; i++) {
00158$:
	ld	-1 (ix), #0x00
00137$:
;Players/players.h:143: SMS_addSprite(player_x+(i<<3), player_y+(j<<3), PLAYER1_SPRITE_POSITION + player_direction_offset + player_current_frame * PLAYER_LR_NUMBER_TILES_BY_FRAME + PLAYER_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a, (_player_x+0)
	ld	c, a
	ld	b, #0x00
	ld	a, -1 (ix)
	ld	-6 (ix), a
	ld	-5 (ix), #0x00
	pop	hl
	push	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	ld	b, l
	ld	c, #0x00
	ld	a, (_player_direction_offset+0)
	ld	d, #0x00
	ld	e, a
	inc	d
	ld	a, (_player_current_frame+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, de
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	pop	de
	ld	a, l
	add	a, -4 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -3 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	add	a, -6 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, c
	or	a, l
	ld	c, a
	ld	a, b
	or	a, h
	ld	b, a
	ld	a, (_player_y+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	hl, de
	ld	e, c
	ld	d, b
	call	_SMS_addSprite_f
;Players/players.h:142: for(i=0; i<2; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jr	C, 00137$
;Players/players.h:140: for(j=0; j<3; j++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x03
	jp	C, 00158$
00141$:
;Players/players.h:147: }
	ld	sp, ix
	pop	ix
	ret
;Tiles/tile.h:24: void Tile_Update(Tile* tile)
;	---------------------------------
; Function Tile_Update
; ---------------------------------
_Tile_Update::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
;Tiles/tile.h:26: tile->computedId = tile->id;
	ld	hl, #0x0006
	add	hl, bc
	ex	(sp), hl
	ld	a, (bc)
	ld	e, a
	ld	d, #0x00
	pop	hl
	push	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
;Tiles/tile.h:28: if(tile->flipX)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	bit	0, (hl)
	jr	Z, 00102$
;Tiles/tile.h:29: tile->computedId += TILE_FLIPPED_X;
	pop	hl
	push	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0200
	add	hl, de
	ex	de, hl
	pop	hl
	push	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
00102$:
;Tiles/tile.h:31: if(tile->flipY)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	bit	0, (hl)
	jr	Z, 00104$
;Tiles/tile.h:32: tile->computedId += TILE_FLIPPED_Y;
	pop	hl
	push	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0400
	add	hl, de
	ex	de, hl
	pop	hl
	push	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
00104$:
;Tiles/tile.h:34: if(tile->useSpritePalette)
	push	bc
	pop	iy
	ld	e, 4 (iy)
	bit	0, e
	jr	Z, 00106$
;Tiles/tile.h:35: tile->computedId += TILE_USE_SPRITE_PALETTE;
	pop	hl
	push	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0800
	add	hl, de
	ex	de, hl
	pop	hl
	push	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
00106$:
;Tiles/tile.h:37: if(tile->priority)
	ld	hl, #5
	add	hl, bc
	bit	0, (hl)
	jr	Z, 00109$
;Tiles/tile.h:38: tile->computedId += TILE_PRIORITY;
	pop	hl
	push	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x1000
	add	hl, bc
	ex	de, hl
	pop	hl
	push	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
00109$:
;Tiles/tile.h:39: }
	ld	sp, ix
	pop	ix
	ret
;Tiles/tile.h:41: Tile* CreateTile
;	---------------------------------
; Function CreateTile
; ---------------------------------
_CreateTile::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	b, a
	ld	c, l
;Tiles/tile.h:50: struct Tile *tile = malloc(sizeof (struct Tile));
	push	bc
	ld	hl, #0x0008
	call	_malloc
	pop	bc
;Tiles/tile.h:51: tile->id = id;
	ld	a, b
	ld	(de), a
;Tiles/tile.h:52: tile->collidable = collidable;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	(hl), c
;Tiles/tile.h:53: tile->flipX = flipX;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	a, 4 (ix)
	ld	(bc), a
;Tiles/tile.h:54: tile->flipY = flipY;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	inc	bc
	ld	a, 5 (ix)
	ld	(bc), a
;Tiles/tile.h:55: tile->useSpritePalette = useSpritePalette;
	ld	hl, #0x0004
	add	hl, de
	ld	a, 6 (ix)
	ld	(hl), a
;Tiles/tile.h:56: tile->priority = priority;
	ld	hl, #0x0005
	add	hl, de
	ld	a, 7 (ix)
	ld	(hl), a
;Tiles/tile.h:58: Tile_Update(tile);
;	spillPairReg hl
;	spillPairReg hl
	ex	de, hl
	push	hl
;	spillPairReg hl
;	spillPairReg hl
	call	_Tile_Update
	pop	de
;Tiles/tile.h:60: if (tile == NULL)
	ld	a, d
	or	a, e
	jr	NZ, 00102$
;Tiles/tile.h:61: return NULL;
	ld	de, #0x0000
;Tiles/tile.h:63: return tile;
00102$:
;Tiles/tile.h:64: }
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;Tiles/tile.h:66: void DeleteTile(Tile *tile)
;	---------------------------------
; Function DeleteTile
; ---------------------------------
_DeleteTile::
;Tiles/tile.h:68: if(tile != NULL)
	ld	a, h
	or	a, l
;Tiles/tile.h:69: free(tile);
	jp	NZ,_free
;Tiles/tile.h:70: }
	ret
;Tiles/metatile.h:14: MetaTile* MetaTile_Create
;	---------------------------------
; Function MetaTile_Create
; ---------------------------------
_MetaTile_Create::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
	ld	-3 (ix), l
	ld	-2 (ix), h
;Tiles/metatile.h:29: MetaTile* metatile = malloc(sizeof (struct MetaTile));
	ld	hl, #0x0083
	call	_malloc
;Tiles/metatile.h:30: metatile->numTilesX = numTilesX;
	ld	hl, #0x0081
	add	hl, de
	ld	a, 5 (ix)
	ld	(hl), a
;Tiles/metatile.h:31: metatile->numTilesY = numTilesY;
	ld	hl, #0x0082
	add	hl, de
	ld	a, 6 (ix)
	ld	(hl), a
;Tiles/metatile.h:32: metatile->numTiles = numTiles;
	ld	hl, #0x0080
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, 4 (ix)
	ld	(bc), a
;Tiles/metatile.h:35: for(i = 0; i < metatile->numTiles; ++i)
	ld	-1 (ix), #0x00
00103$:
	ld	a, (bc)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	sub	a, l
	jr	NC, 00101$
;Tiles/metatile.h:37: metatile->tiles[i] = tiles[i];
	ld	a, -1 (ix)
	add	a, a
	add	a, a
	add	a, a
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ex	(sp), hl
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, -3 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -2 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	de
	push	bc
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	ld	bc, #0x0008
	ldir
	pop	bc
	pop	de
;Tiles/metatile.h:35: for(i = 0; i < metatile->numTiles; ++i)
	inc	-1 (ix)
	jp	00103$
00101$:
;Tiles/metatile.h:40: return metatile;
;Tiles/metatile.h:41: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	inc	sp
	jp	(hl)
;Tiles/metatile.h:43: void MetaTile_Draw
;	---------------------------------
; Function MetaTile_Draw
; ---------------------------------
_MetaTile_Draw::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-34
	add	iy, sp
	ld	sp, iy
	ex	de, hl
;Tiles/metatile.h:50: unsigned char tilesXY = metatile->numTilesX;
	ld	c, e
	ld	b, d
	ld	hl, #129
	add	hl, bc
	ld	c, (hl)
;Tiles/metatile.h:53: for(i = 0; i < tilesXY; ++i)
	push	de
	pop	iy
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, c
	jr	NC, 00101$
;Tiles/metatile.h:55: tileIds[i] = metatile->tiles[0].computedId; // TODO: Not working correctly
	ld	e, b
	ld	d, #0x00
	ex	de, hl
	add	hl, hl
	ex	de, hl
	push	de
	ld	hl, #2
	add	hl, sp
	add	hl, de
	pop	de
	ex	de, hl
	ld	a, 6 (iy)
	ld	-2 (ix), a
	ld	a, 7 (iy)
	ld	-1 (ix), a
	ld	l, e
	ld	h, d
	ld	a, -2 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -1 (ix)
	ld	(hl), a
;Tiles/metatile.h:56: tileIds[i] = 0x1011;
	ld	a, #0x11
	ld	(de), a
	inc	de
	ld	a, #0x10
	ld	(de), a
;Tiles/metatile.h:53: for(i = 0; i < tilesXY; ++i)
	inc	b
	jp	00103$
00101$:
;Tiles/metatile.h:59: SMS_loadTileMapArea(x, y, tileIds, 2, 2);
	ld	hl, #0x202
	push	hl
	ld	hl, #2
	add	hl, sp
	push	hl
	ld	l, 5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, 4 (ix)
	call	_SMS_loadTileMapArea
;Tiles/metatile.h:60: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;Tiles/entity.h:12: Entity* Entity_Create(MetaTile* metatile[], unsigned char numFrames) 
;	---------------------------------
; Function Entity_Create
; ---------------------------------
_Entity_Create::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
	ex	(sp), hl
;Tiles/entity.h:14: Entity* entity = malloc(sizeof(struct Entity));
	ld	hl, #0x0044
	call	_malloc
;Tiles/entity.h:16: entity->currentFrame = 0;
	ld	hl, #0x0042
	add	hl, de
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;Tiles/entity.h:17: entity->frameRate = 30;
	ld	hl, #0x0040
	add	hl, de
	ld	(hl), #0x1e
;Tiles/entity.h:18: entity->numFrames = numFrames;
	ld	hl, #0x0041
	add	hl, de
	ld	a, 4 (ix)
	ld	(hl), a
;Tiles/entity.h:22: for(i = 0; i < metatile[i]->numTiles; ++i)
	ld	-1 (ix), #0x00
00103$:
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	pop	bc
	push	bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	ld	bc, #0x0080
	add	hl, bc
	pop	bc
;	spillPairReg hl
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00101$
;Tiles/entity.h:24: entity->metatile[i] = metatile[i];
	ld	a, -1 (ix)
	add	a, a
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
	inc	hl
	ld	(hl), b
;Tiles/entity.h:22: for(i = 0; i < metatile[i]->numTiles; ++i)
	inc	-1 (ix)
	jp	00103$
00101$:
;Tiles/entity.h:27: return entity;
;Tiles/entity.h:28: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;Tiles/entity.h:30: void Entity_Delete(Entity* entity)
;	---------------------------------
; Function Entity_Delete
; ---------------------------------
_Entity_Delete::
;Tiles/entity.h:32: if(entity != NULL)
	ld	a, h
	or	a, l
;Tiles/entity.h:33: free(entity);
	jp	NZ,_free
;Tiles/entity.h:34: }
	ret
;Tiles/entity.h:36: void Entity_Update(Entity* entity, unsigned int time)
;	---------------------------------
; Function Entity_Update
; ---------------------------------
_Entity_Update::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ex	(sp), hl
	ld	c, e
	ld	b, d
;Tiles/entity.h:38: if((time % entity->frameRate) == 0)
	pop	de
	push	de
	ld	hl, #64
	add	hl, de
	ld	e, (hl)
	ld	d, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
;Tiles/entity.h:40: entity->currentFrame++;
	call	__moduint
	ld	a, -2 (ix)
	add	a, #0x42
	ld	c, a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	b, a
;Tiles/entity.h:38: if((time % entity->frameRate) == 0)
	ld	a, d
	or	a, e
	jr	NZ, 00102$
;Tiles/entity.h:40: entity->currentFrame++;
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	de
	ld	l, c
	ld	h, b
	ld	(hl), e
	inc	hl
	ld	(hl), d
00102$:
;Tiles/entity.h:43: if(entity->currentFrame > entity->numFrames)
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	pop	hl
	push	hl
	push	bc
	ld	bc, #0x0041
	add	hl, bc
	pop	bc
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h, a
	sbc	hl, de
	jr	NC, 00105$
;Tiles/entity.h:45: entity->currentFrame = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
00105$:
;Tiles/entity.h:47: }
	ld	sp, ix
	pop	ix
	ret
;Tiles/entity.h:49: unsigned char Entity_GetCurrentFrame(Entity* entity)
;	---------------------------------
; Function Entity_GetCurrentFrame
; ---------------------------------
_Entity_GetCurrentFrame::
;Tiles/entity.h:51: return entity->currentFrame;
	ld	de, #0x0042
	add	hl, de
	ld	a, (hl)
;Tiles/entity.h:52: }
	ret
;Tiles/entity.h:54: unsigned char Entity_GetFrameRate(Entity* entity)
;	---------------------------------
; Function Entity_GetFrameRate
; ---------------------------------
_Entity_GetFrameRate::
;Tiles/entity.h:56: return entity->frameRate;
	ld	de, #0x0040
	add	hl, de
	ld	a, (hl)
;Tiles/entity.h:57: }
	ret
;Tiles/entity.h:59: void Entity_Draw
;	---------------------------------
; Function Entity_Draw
; ---------------------------------
_Entity_Draw::
	push	ix
	ld	ix,#0
	add	ix,sp
	ex	de, hl
;Tiles/entity.h:65: MetaTile_Draw(entity->metatile[entity->currentFrame], x, y);
	push	de
	pop	iy
	ld	l, 66 (iy)
;	spillPairReg hl
	ld	h, 67 (iy)
;	spillPairReg hl
	add	hl, hl
	add	hl, de
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	d, 5 (ix)
	ld	e, 4 (ix)
	push	de
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	call	_MetaTile_Draw
;Tiles/entity.h:66: }
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;main.c:11: void loadGraphics2vram(void)
;	---------------------------------
; Function loadGraphics2vram
; ---------------------------------
_loadGraphics2vram::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-68
	add	hl, sp
	ld	sp, hl
;main.c:14: SMS_VRAMmemsetW(0, 0x0000, 0x4000);
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:17: SMS_loadBGPalette(background_palette_bin);
	ld	hl, #_background_palette_bin
	call	_SMS_loadBGPalette
;main.c:19: SMS_loadPSGaidencompressedTiles(backgroundtiles_psgcompr, 0);
	ld	de, #0x4000
	ld	hl, #_backgroundtiles_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;main.c:20: SMS_loadTileMap(0,0, backgroundtilemap_bin, backgroundtilemap_bin_size);
	ld	hl, #0x0600
	push	hl
	ld	de, #_backgroundtilemap_bin
	ld	h, #0x78
	call	_SMS_VRAMmemcpy
;main.c:24: SMS_loadPSGaidencompressedTiles(items_tiles_psgcompr, 18);
	ld	de, #0x4240
	ld	hl, #_items_tiles_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;main.c:31: SMS_loadSpritePalette(spritepalette_bin);
	ld	hl, #_spritepalette_bin
	call	_SMS_loadSpritePalette
;main.c:32: SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, 32*6*6);
	ld	hl, #0x0480
	push	hl
	ld	de, #_spritetiles_down_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
;main.c:36: Tile tilelist1[] = 
	ld	-68 (ix), #0x0b
	ld	-67 (ix), #0x00
	ld	-66 (ix), #0x00
	ld	-65 (ix), #0x00
	ld	-64 (ix), #0x00
	ld	-63 (ix), #0x01
	xor	a, a
	ld	-62 (ix), a
	ld	-61 (ix), a
	ld	-60 (ix), #0x0a
	ld	-59 (ix), #0x00
	ld	-58 (ix), #0x00
	ld	-57 (ix), #0x00
	ld	-56 (ix), #0x00
	ld	-55 (ix), #0x01
	xor	a, a
	ld	-54 (ix), a
	ld	-53 (ix), a
	ld	-52 (ix), #0x0b
	ld	-51 (ix), #0x00
	ld	-50 (ix), #0x00
	ld	-49 (ix), #0x00
	ld	-48 (ix), #0x00
	ld	-47 (ix), #0x01
	xor	a, a
	ld	-46 (ix), a
	ld	-45 (ix), a
	ld	-44 (ix), #0x0a
	ld	-43 (ix), #0x00
	ld	-42 (ix), #0x00
	ld	-41 (ix), #0x00
	ld	-40 (ix), #0x00
	ld	-39 (ix), #0x01
	xor	a, a
	ld	-38 (ix), a
	ld	-37 (ix), a
;main.c:45: Tile tilelist2[] = 
	ld	-36 (ix), #0x14
	ld	-35 (ix), #0x00
	ld	-34 (ix), #0x00
	ld	-33 (ix), #0x00
	ld	-32 (ix), #0x00
	ld	-31 (ix), #0x01
	xor	a, a
	ld	-30 (ix), a
	ld	-29 (ix), a
	ld	-28 (ix), #0x15
	ld	-27 (ix), #0x00
	ld	-26 (ix), #0x00
	ld	-25 (ix), #0x00
	ld	-24 (ix), #0x00
	ld	-23 (ix), #0x01
	xor	a, a
	ld	-22 (ix), a
	ld	-21 (ix), a
	ld	-20 (ix), #0x14
	ld	-19 (ix), #0x00
	ld	-18 (ix), #0x00
	ld	-17 (ix), #0x00
	ld	-16 (ix), #0x00
	ld	-15 (ix), #0x01
	xor	a, a
	ld	-14 (ix), a
	ld	-13 (ix), a
	ld	-12 (ix), #0x15
	ld	-11 (ix), #0x00
	ld	-10 (ix), #0x00
	ld	-9 (ix), #0x00
	ld	-8 (ix), #0x00
	ld	-7 (ix), #0x01
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
;main.c:54: MetaTile* metatile1 = MetaTile_Create(tilelist1, 4, 2, 2);
	ld	hl, #0x202
	push	hl
	ld	a, #0x04
	push	af
	inc	sp
	ld	hl, #3
	add	hl, sp
	call	_MetaTile_Create
;main.c:55: MetaTile* metatile2 = MetaTile_Create(tilelist2, 4, 2, 2);
	push	de
	ld	hl, #0x202
	push	hl
	ld	a, #0x04
	push	af
	inc	sp
	ld	hl, #37
	add	hl, sp
	call	_MetaTile_Create
	ld	c, e
	ld	b, d
	pop	de
;main.c:57: MetaTile* metatilelist[] = 
	ld	-4 (ix), e
	ld	-3 (ix), d
	ld	-2 (ix), c
	ld	-1 (ix), b
;main.c:63: entity = Entity_Create(metatilelist, 2);
	ld	a, #0x02
	push	af
	inc	sp
	ld	hl, #65
	add	hl, sp
	call	_Entity_Create
	ld	(_entity), de
;main.c:65: Entity_Draw(entity, 6, 6);
	ld	hl, #0x606
	push	hl
	ld	hl, (_entity)
	call	_Entity_Draw
;main.c:69: }
	ld	sp, ix
	pop	ix
	ret
;main.c:71: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:73: frame_counter = 0;
	ld	hl, #_frame_counter
	ld	(hl), #0x00
;main.c:75: Player1Init();
	call	_Player1Init
;main.c:76: InitConsole();
	call	_InitConsole
;main.c:78: loadGraphics2vram();
	call	_loadGraphics2vram
;main.c:79: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:81: PSGPlay(music_psg);
	ld	hl, #_music_psg
	call	_PSGPlay
;main.c:84: while(1)
00111$:
;main.c:87: checkgamepause();
	call	_checkgamepause
;main.c:89: if(gamepause==0)
	ld	a, (_gamepause+0)
	or	a, a
	jr	NZ, 00108$
;main.c:91: frame_counter++;
	ld	hl, #_frame_counter
	inc	(hl)
;main.c:93: if((frame_counter%64) == 0)
	ld	a, (_frame_counter+0)
	and	a, #0x3f
	jr	NZ, 00104$
;main.c:95: volume_atenuation++;
	ld	iy, #_volume_atenuation
	inc	0 (iy)
;main.c:96: if(volume_atenuation > 15)
	ld	a, #0x0f
	sub	a, 0 (iy)
	jr	NC, 00104$
;main.c:98: volume_atenuation = 0;
	ld	0 (iy), #0x00
00104$:
;main.c:104: Entity_Update(entity, frame_counter);
	ld	a, (_frame_counter+0)
	ld	e, a
	ld	d, #0x00
	ld	hl, (_entity)
	call	_Entity_Update
;main.c:107: SMS_initSprites();
	call	_SMS_initSprites
;main.c:109: Player1Update(frame_counter);
	ld	a, (_frame_counter+0)
	call	_Player1Update
;main.c:116: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:117: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:119: PSGFrame();
	call	_PSGFrame
;main.c:120: PSGSFXFrame();
	call	_PSGSFXFrame
;main.c:122: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
	jp	00111$
00108$:
;main.c:129: PSGFrame();
	call	_PSGFrame
;main.c:131: if(PSGSFXGetStatus())
	call	_PSGSFXGetStatus
	or	a, a
	jr	Z, 00106$
;main.c:133: PSGSFXFrame();
	call	_PSGSFXFrame
00106$:
;main.c:137: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:140: numinterrupts=0;
	ld	hl, #_numinterrupts
	ld	(hl), #0x00
;main.c:143: }
	jp	00111$
	.area _CODE
__str_0:
	.ascii "Gary Paluk"
	.db 0x00
__str_1:
	.ascii "Master Blaster"
	.db 0x00
__str_2:
	.ascii "Grab a friend and jump into endless bombastic fun!"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)
	.org 0x7FF0
___SMS__SEGA_signature:
	.db #0x54	; 84	'T'
	.db #0x4d	; 77	'M'
	.db #0x52	; 82	'R'
	.db #0x20	; 32
	.db #0x53	; 83	'S'
	.db #0x45	; 69	'E'
	.db #0x47	; 71	'G'
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x4c	; 76	'L'
	.org 0x7FD5
___SMS__SDSC_author:
	.ascii "Gary Paluk"
	.db 0x00
	.org 0x7FC6
___SMS__SDSC_name:
	.ascii "Master Blaster"
	.db 0x00
	.org 0x7F93
___SMS__SDSC_descr:
	.ascii "Grab a friend and jump into endless bombastic fun!"
	.db 0x00
	.org 0x7FE0
___SMS__SDSC_signature:
	.db #0x53	; 83	'S'
	.db #0x44	; 68	'D'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x07	; 7
	.db #0x22	; 34
	.db #0x20	; 32
	.db #0xd5	; 213
	.db #0x7f	; 127
	.db #0xc6	; 198
	.db #0x7f	; 127
	.db #0x93	; 147
	.db #0x7f	; 127
