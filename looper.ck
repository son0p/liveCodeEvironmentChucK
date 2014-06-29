// instancio la  clase
BPM myBPM;
// le mando el tempo a la clase
myBPM.tempo( 96.0 );
// traigo el pulso de la clase y lo asigno a algo mas corto de escribir
myBPM.pulse => dur beat;

0 => int count;

while( true )
{
	count % 8 => int patt;
	if( patt == 0 )
	{
		Machine.add(me.dir()+"/score.ck") => int scoreID;;
		8 * beat => now;
		Machine.remove(scoreID);
	}
	// ToDo: esto no funciona, la idea es reportar el beat en que va
	count++;
}




