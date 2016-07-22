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
                var method = variables[ methodName ];
                char = method();
            }
            arrayAppend( newWordArray, char );
        }
        return arrayToList( newWordArray, "" );
    }

    private numeric function randRangeInt( required numeric min, required numeric max ) {
        return createObject( "java", "java.util.concurrent.ThreadLocalRandom" )
            .current().nextInt( min, max );
    }

    private any function randomDigit() {
        return randRangeInt( 0, 9 );
    }

    private any function randomLetter() {
        return randomElement( letters );
    }

    private any function randomElement( required array collection ) {
        var len = arrayLen( collection );
        if ( len == 1 ) {
            return collection[ len ];
        }
        return collection[ randRangeInt( 1, arrayLen( collection ) ) ];
    }
}