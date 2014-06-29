// importa clase
BPM tempo;
tempo.pulse => dur beat;

// cadena de sonido
SinOsc mel => Envelope e => NRev r => dac;

// inicializo variables
0.1 => mel.gain;
0.1 => r.mix;
40 => int root; // debería ser global

function void note( int note, float duration )
{
	Std.mtof( note ) => mel.freq;
	e.keyOn(); 
	duration * beat => now;
	e.keyOff();
}

function void silence( float duration )
{
	duration * beat => now;
}
// opciones de intervalos para escoger 
[-5, 0, 0, 0, 0, 0, 3, 3, 7, 7, 7, 7, 7, 12 ] @=> int optMel[];
// opciones de duraciones para escoger
[2.0, 1.0, 0.5, 0.5, 0.5, 0.5, 0.25] @=> float optRhy[];

// pattern
fun void part()
{
	while(true)
	{
		// seleccion aleatoria de la nota de la melodía
		optMel[ Math.random2( 0, optMel.cap()-1 ) ]  => int selMel;
		// selección aleatoria del ritmo de la melodía
		optRhy[ Math.random2( 0, optRhy.cap()-1 ) ]  => float selRhy;
		note( ( root + 24 ) + selMel, selRhy );
	}
 }

// spork
spork ~ part();

// main
while(true)
{
	1::second => now;
}