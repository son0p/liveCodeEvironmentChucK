// importa clase
BPM tempo;
 tempo.pulse => dur beat;

//thanks to Joel Matthys for this solution
SndBuf buf[0]; // declare empty array
new SndBuf @=> buf["kk"]; // creates new SndBuf associated with array index "kk"
new SndBuf @=> buf["sn"]; // creates new SndBuf associated with array index "sn"
buf["kk"] => dac;
buf["sn"] => dac;
me.dir() + "/audio/kick_01.wav" => buf["kk"].read;
me.dir() + "/audio/snare_01.wav" => buf["sn"].read;
buf["kk"].samples() => buf["kk"].pos;
buf["sn"].samples() => buf["sn"].pos;


["kk", "sn"] @=> string p1[]; // edit this array to play

while( true )

{
    for( 0 => int i; i < p1.cap(); i++)
    {
        0 => buf[ p1[i] ].pos;
        beat/p1.cap() => now;
    }
}
