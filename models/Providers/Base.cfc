component {

    property name="generator";

    variables.letters = listToArray( "abcdefghijklmnopqrstuvwxyz", "" );

    public function init( required generator ) {
        variables.generator = arguments.generator;
    }

    private string function lexify( required string target ) {
        return replaceWildcard( target, "?", "randomLetter" );
    }

    private string function numerify( required string target ) {
        // remember that # has to be escaped in CFML
        return replaceWildcard( target, "##", "randomDigit" );
    }

    private string function replaceWildcard(
        required string target,
        required string wildcard,
        required string methodName
    ) {
        var newWordArray = [];
        for ( var char in listToArray( target, "" ) ) {
            if ( char == wildcard ) {
                char = invoke( this, methodName );;
            }
            arrayAppend( newWordArray, char );
        }
        return arrayToList( newWordArray, "" );
    }

    private numeric function numberBetween( required numeric min, required numeric max ) {
        return createObject( "java", "java.util.concurrent.ThreadLocalRandom" )
            .current().nextInt( min, max );
    }

    private any function randomDigit() {
        return numberBetween( 0, 9 );
    }

    private any function randomLetter() {
        return randomElement( letters );
    }

    private any function randomElement( required array collection ) {
        var len = arrayLen( collection );
        if ( len == 1 ) {
            return collection[ len ];
        }
        return collection[ numberBetween( 1, arrayLen( collection ) ) ];
    }
}