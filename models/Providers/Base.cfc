component {

    property name="generator";

    public function init( required generator ) {
        variables.generator = arguments.generator;
    }

    private numeric function randRangeInt( required numeric min, required numeric max ) {
        return createObject( "java", "java.util.concurrent.ThreadLocalRandom" )
            .current().nextInt( min, max );
    }

    private any function randomElement( required array collection ) {
        var len = arrayLen( collection );
        if ( len == 1 ) {
            return collection[ len ];
        }
        return collection[ randRangeInt( 1, arrayLen( collection ) ) ];
    }
}