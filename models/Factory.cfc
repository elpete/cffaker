component {

    property name="moduleMapping" inject="moduleMapping@cffaker";

    // The default locale with which to scope the providers
    variables.defaultLocale = "en_US";

    // The default providers to load into the Generator
    variables.defaultProviders = [ "Person" ];

    /**
    * Initializes the Factory with the given locale
    *
    * @locale The locale with which to scope the providers
    *
    * @return CFFaker.models.Factory
    */
    public Factory function init( string locale = defaultLocale ) {
        variables.locale = arguments.locale;
        return this;
    }

    /**
    * Creates a new Generator with the default providers loaded
    *
    * @locale The locale with which to scope the providers
    * 
    * @return CFFaker.models.Generator
    */
    public Generator function create( string locale = variables.locale ) {
        var generator = new Generator();

        for ( var provider in defaultProviders ) {
            var providerPath = getProviderClassPath( provider, arguments.locale );
            generator.addProvider( new "#providerPath#"( generator ) );
        }

        return generator;
    }

    /**
    * Returns the class path to instantiate.
    *
    * @provider The name of the provider
    * @locale The locale with which to scope the provider
    *
    * @throws ProviderNotFound
    * @return string
    */
    private string function getProviderClassPath(
        required string provider,
        required string locale
    ) {
        if ( providerClassPathExists( provider, arguments.locale ) ) {
            return generateClassPath( provider, arguments.locale, "." );
        }

        // fallback to default locale
        if ( providerClassPathExists( provider, defaultLocale ) ) {
            return generateClassPath( provider, defaultLocale, "." );   
        }

        // fallback to no locale
        if ( providerClassPathExists( provider ) ) {
            return generateClassPath( provider, "." );   
        }

        throw(
            type = "ProviderNotFound",
            message = "Unable to find provider [#provider#] with locale [#arguments.locale#]."
        );
    }

    /**
    * Checks for the existance of a provider in a specific locale
    *
    * @provider The name of the provider
    * @locale The locale with which to scope the provider
    *
    * @return boolean
    */
    private boolean function providerClassPathExists(
        required string provider,
        string locale = ""
    ) {
        return FileExists(
            ExpandPath( "/#generateClassPath( provider, arguments.locale, "/" )#.cfc" )
        );
    }

    /**
    * Generates a delimited class path to the provider and locale convention location
    *
    * @provider The name of the provider
    * @locale The locale with which to scope the provider
    * @delimiter The delimiter used to join the path components
    *
    * @return string
    */
    private string function generateClassPath(
        required string provider,
        required string locale,
        required string delimiter
    ) {
        var pathArray = listToArray( moduleMapping, "/" );
        pathArray.addAll( [ "models", "Providers", arguments.locale, provider ] );
        pathArray = arrayFilter( pathArray, function( pathComponent ) {
            return pathComponent != "";
        } );
        return arrayToList( pathArray, delimiter );
    }

}