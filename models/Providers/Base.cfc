component {
    private numeric function randRangeInt( required numeric min, required numeric max ) {
        return createObject( "java", "java.util.concurrent.ThreadLocalRandom" )
            .current().nextInt( min, max );
    }

    private any function getElement( required array collection ) {
        return collection[ randRangeInt( 1, arrayLen( collection ) ) ];
    }
}