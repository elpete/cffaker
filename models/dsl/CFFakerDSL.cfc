component implements="coldbox.system.ioc.dsl.IDSLBuilder" {

    public any function init( required any injector ) output="false" {
        instance = { injector = arguments.injector };
        return this;
    }

    public any function process( required definition, targetObject ) output="false" {
        return instance.injector.getInstance(
            name = "factory@cffaker",
            initArguments = {
                locale = normalizeLocaleFromDSL( arguments.definition.dsl )
            }
        );
    }

    private string function normalizeLocaleFromDSL( required string dsl ) {
        if ( listLen( dsl, ":" ) == 1 ) {
            return "en_US";
        }

        return listGetAt( dsl, 2, ":" );
    }

}