// -------Score------------------

// TODO apagar los sporks .. se estan sumando.
// requiere inicializar el tempo en looper
BPM tempo;
tempo.pulse => dur beat;

0 => int count;


Machine.add( me.dir() + "/drums.ck" ) => int drumID;
Machine.add( me.dir() + "/bass.ck" ) => int  bassID;
Machine.add( me.dir() + "/mel.ck" ) => int  melID;

7.99999 * beat => now; // terrible manera de hacer que no se sumen los sporks TODO
Machine.remove(drumID);
Machine.remove(bassID);
Machine.remove(melID);

<<< "NOW:", now/second >>>;