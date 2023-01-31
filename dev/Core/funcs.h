// declarations needed
void Player1Update(unsigned char time);
void Player1UpdatePosition(void);
void Player1UpdateDraw(unsigned char time);

void InterruptHandler(void)
{
	// numinterrupts++;
}

void InitConsole(void)
{
    // La consola
	SMS_init();
	
	// We need this
	SMS_getKeysStatus();
	
	// Advanced frameskipping
	SMS_setLineInterruptHandler(&InterruptHandler);
	SMS_setLineCounter (192);
	SMS_enableLineInterrupt();
	
	// Kagesan asked for this ;)
	SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
}

void checkgamepause()
{
	if(SMS_queryPauseRequested())
	{
		SMS_resetPauseRequest();
		gamepause=1-gamepause;
		if(gamepause==1)
			PSGPlayNoRepeat(pause_psg);
		else
			PSGPlay(music_psg);
	}
}