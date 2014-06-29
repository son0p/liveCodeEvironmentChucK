// importa clase
BPM tempo;
tempo.pulse => dur beat;

// cadena de sonido
SndBuf kk => dac;
SndBuf sn => dac;
SndBuf hh => dac;

me.dir() + "/audio/kick_01.wav" => kk.read; 
me.dir() + "/audio/hihat_01.wav" => hh.read;
me.dir() + "/audio/snare_01.wav" => sn.read;

0.1 => hh.gain;

// ultimo sample para evitar sonido
kk.samples() => kk.pos;
sn.samples() => sn.pos;
hh.samples() => hh.pos;

0 => int count;
0 => int count8;
int count16;


fun void kick(int count16)
{
	while(true)
	{
		1.5 * beat => now;
		0 => kk.pos;
		2 * beat => now;
		0 => kk.pos;
		0.5 * beat => now;
	}
 }
 
fun void snare(int count16)
{

	while(true)
	{
		<<< count16>>>;	
		if (count16 < 2)
		{
			0.5 * beat => now;
			0 => sn.pos;
			2 * beat => now;
			0 => sn.pos;
			1.5 * beat => now;
		}
		if (count16 > 2)
		{
			[0.25, 0.25, 0.125, 0.125, 0.125] @=> float optFill[];
			optFill[Math.random2( 0,  optFill.cap() -1 )] * beat => now;
		}
	
	}
}

fun void hihat()
{
	while(true)
	{
		0.5 * beat => now;	0 => hh.pos;
		0.25 * beat => now;	0 => hh.pos;
		0.25 * beat => now; 0 => hh.pos;
	}
}
// ToDo: reportar un conteo para saber donde voy y hacer fills quizá en looper
<<< "in", count >>>;
spork ~ kick(count16);
spork ~ snare(count16);
spork ~ hihat();

while(true)
{
	count % 16 => int count16;	
	beat/2 => now;
	count++;
}