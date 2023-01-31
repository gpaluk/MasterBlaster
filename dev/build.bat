@echo off
cls

REM Bank 2

REM === SPRITES ===
REM Player walk up
..\utl\bmp2tile\BMP2Tile.exe assets\gfx\player_white_up.png ^
    -noremovedupes -nomirror -8x8 -palsms ^
    -savetiles Banks\bank2\spritetiles_up.bin ^
    -savepalette Banks\bank2\spritepalette.bin

REM Player walk down
..\utl\bmp2tile\BMP2Tile.exe assets\gfx\player_white_down.png ^
    -noremovedupes -nomirror -8x8 -palsms ^
    -savetiles Banks\bank2\spritetiles_down.bin ^
    -savepalette Banks\bank2\spritepalette.bin

REM Player walk left/right
..\utl\bmp2tile\BMP2Tile.exe assets\gfx\player_white_lr.png ^
    -noremovedupes -nomirror -8x8 -palsms ^
    -savetiles Banks\bank2\spritetiles_lr.bin ^
    -savepalette Banks\bank2\spritepalette_lr.bin

REM === BACKGROUND ===
REM background palette
..\utl\bmp2tile\BMP2Tile.exe assets\gfx\background_palette.png ^
    -mirror -removedupes -8x8 -palsms -fullpalette ^
    -savepalette Banks\bank2\background_palette.bin

REM Background tiles
..\utl\bmp2tile\BMP2Tile.exe assets\gfx\background_full.png ^
    -mirror -removedupes -8x8 -palsms ^
    -savetiles Banks\bank2\backgroundtiles.psgcompr ^
    -savetilemap Banks\bank2\backgroundtilemap.bin

REM Items tiles
..\utl\bmp2tile\BMP2Tile.exe assets\gfx\items.png ^
    -mirror -removedupes -8x8 -palsms ^
    -savetiles Banks\bank2\items_tiles.psgcompr

REM Banks conversion
cd Banks
..\..\utl\folder2c bank2 bank2 2

REM Compile banks
sdcc -c --no-std-crt0 -mz80 --Werror --opt-code-speed --constseg BANK2 bank2.c

cd ..

REM Build main
sdcc -c -mz80 --opt-code-speed --peep-file peep-rules.txt --std-c99 main.c

REM Link files
sdcc -o output.ihx --Werror --opt-code-speed -mz80 --no-std-crt0 --data-loc 0xC000 ^
 -Wl-b_BANK2=0x8000 ^
 ..\crt0\crt0_sms.rel main.rel ^
 ..\lib\SMSlib.lib ^
 ..\lib\PSGlib.rel ^
 Banks\bank2.rel

REM Binary output
..\utl\ihx2sms output.ihx output.sms

REM Copy the file to a more appropriate build folder location later
REM echo Copy output
REM copy output.sms ..\asm
REM copy output.sms ..\MasterBlaster.sms

output.sms