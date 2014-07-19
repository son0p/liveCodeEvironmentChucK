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
me.dir() + "/audio/ss_02.wav" => buf["ss"].read;
me.dir() + "/audio/kick_04.wav" => buf["kk"].read;
me.dir() + "/audio/snare_02.wav" => buf["sn"].read;
me.dir() + "/audio/hihat_02.wav" => buf["hh"].read;
buf["ss"].samples() => buf["ss"].pos;
buf["kk"].samples() => buf["kk"].pos;
buf["sn"].samples() => buf["sn"].pos;
buf["hh"].samples() => buf["hh"].pos;

// ------ Synths ----------
SawOsc bass => NRev rBass => dac;
SawOsc mel => NRev rMel => dac; 




// ------- Mixer -----------
0.05 => mel.gain;
0.2 => bass.gain;

0.0 => rBass.mix;
0.1 => rMel.mix;

// ===========================================
// edite estos arrays para jugar con la música
// ===========================================
["kk"] @=> string p1[]; 
["ss", "sn" ] @=> string p2[];
["ss", "hh" ] @=> string p3[];
//[0, 40, 0, 40, 0, 40, 0, 40] @=> int p6[];
[0, 40] @=> int p6[];
[ 0, 52, 0, 71 ] @=> int p7[];
4.0 => float p7div;
[ 1] @=> int p10[];


//-----------------------------------------
//         funciones
//-----------------------------------------
fun void pat1()
{
	0 => int count;
	while( true )
	{
		count % 8 => int cicle;
		for( 0 => int i; i < p1.cap(); i++ )
		{
			0 => buf[ p1[i] ].pos;
			if (cicle < 7)
			{
				beat/p1.cap() => now;
			}
			if (cicle >= 7)
			{
				[1, 2, 2, 2, 4, 4] @=> int seed[];
				beat/seed[(Math.random2(0, seed.cap())-1)] => now;
				<<< "fill" >>>;
			}
		}
		count ++;
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

//---------------------- bass
fun void pat6()
{
	while( true )
	{
		for( 0 => int i; i < p6.cap(); i++ )
		{
		
			Std.mtof( p6[i] ) => bass.freq;
			beat/p6.cap() => now;
		}
	}
}	

fun float pat7(float p7div)
{
	while( true )
	{
		
		for( 0 => int i; i < p7.cap(); i++ )
		{
			Std.mtof( p7[i] ) => mel.freq;
			p7div*beat/p7.cap() => now;
			
		}
		
	}
	
}

fun void pat10()
{
	while( true )
	{
		for( 0 => int i; i < p10.cap(); i++ )
		{
			1*p10[i]  =>  float freq;
			freq => mel.freq;
			beat/p10.cap() => now;
			
		}
	}
	
}



spork ~ pat1();
spork ~ pat2();
spork ~ pat3();
spork ~ pat6();
spork ~ pat7(p7div);
// spork ~ pat10();

// loop infinito para mantener papas de los shreds vivos
while( true ) 1::second => now;
