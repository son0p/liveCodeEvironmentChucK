// importa clase
BPM tempo;
tempo.pulse => dur beat;

//thanks to Joel Matthys for this solution
// ------- Sampler ---------------
SndBuf buf[0]; // declare empty array
new SndBuf @=> buf["ss"]; 
new SndBuf @=> buf["kk"]; // creates new SndBuf associated with array index "kk"
new SndBuf @=> buf["sn"]; // creates new SndBuf associated with array index "sn"
new SndBuf @=> buf["hh"]; 
buf["ss"] => dac; 
buf["kk"] => dac; 
buf["sn"] => dac;
buf["hh"] => Gain hh => dac;
0.1 => hh.gain;
me.dir() + "/audio/ss_01.wav" => buf["ss"].read;
me.dir() + "/audio/kick_01.wav" => buf["kk"].read;
me.dir() + "/audio/snare_01.wav" => buf["sn"].read;
me.dir() + "/audio/hihat_01.wav" => buf["hh"].read;
buf["ss"].samples() => buf["ss"].pos;
buf["kk"].samples() => buf["kk"].pos;
buf["sn"].samples() => buf["sn"].pos;
buf["hh"].samples() => buf["hh"].pos;

// ------ Synths ----------
SqrOsc moog => NRev r => dac;
0.2 => moog.gain;
0.1 => r.mix;



// ========================
// edit this arrays to play
// =========================
["kk"] @=> string p1[]; 
["ss", "sn"] @=> string p2[];
["ss", "hh"] @=> string p3[];
//[0, 24, 0, 24, 0, 26, 0, 28] @=> int p6[];
[0, 24, 0, 24] @=> int p6[];



//-----------------------------------------
//         functions
//-----------------------------------------
fun void pat1()
{
	while( true )
	{
		for( 0 => int i; i < p1.cap(); i++ )
		{
			0 => buf[ p1[i] ].pos;
			beat/p1.cap() => now;
		}
	}
}

fun void pat2()
{
	while ( true )
	{
		for( 0 => int i; i < p2.cap(); i++ )
		{
			0 => buf[ p2[i] ].pos;
			beat*2/p2.cap() => now;
		}
	}
}

fun void pat3()
{
	while( true )
	{
		for( 0 => int i; i < p3.cap(); i++ )
		{
			0 => buf[ p3[i] ].pos;
			beat/p3.cap() => now;
		}
	}
}

fun void pat6()
{
	while( true )
	{
		for( 0 => int i; i < p6.cap(); i++ )
		{
			Std.mtof( p6[i] ) => moog.freq;
			beat/p3.cap() => now;
		}
	}
}	



spork ~ pat1();
spork ~ pat2();
spork ~ pat3();
spork ~ pat6();

// loop infinito para mantener papas de los shreds vivos
while( true ) 1::second => now;
