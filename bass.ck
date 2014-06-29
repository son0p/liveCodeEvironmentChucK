// importa clase
BPM tempo;
tempo.pulse => dur beat;

// cadena de sonido
TriOsc bass => Envelope e => NRev r => dac;

// inicializo variables
0.5 => bass.gain;
0.03 => r.mix;
40 => int root;

function void note( int note, float duration )
{
	Std.mtof( note ) => bass.freq;
	e.keyOn(); 
	duration * beat => now;
	e.keyOff();
}

function void silence( float duration )
{
	duration * beat => now;
}

// pattern
fun void bassPattern()
{
	while(true)
	{
		
		note( root, 0.5 );
		silence( 0.5 );
		note( root + 3, 0.5 );
		note( root + 7, 0.5 );

		note( root, 0.5 );
		silence( 0.5 );
		note( root + 3, 0.5 );
		note( root + 7, 0.5 );

		note( root -5, 0.5 );
		silence( 0.5 );
		note( root - 1, 0.5 );
		note( root + 2, 0.5 );

		note( root -5, 0.5 );
		silence( 0.5 );
		note( root - 1, 0.5 );
		note( root + 2, 0.5 );
		
	}
 }

// spork
spork ~ bassPattern();

// main
while(true)
{
	1::second => now;
}