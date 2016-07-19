component {

    property name="providers" type="array" default="[]";

    public Generator function init() {
        variables.providers = [];
        return this;
    }

    public Generator function addProvider( required any provider ) {
        arrayPrepend( providers, provider );
        return this;
    }

    public array function getProviders() {
        return providers;
    }

    public any function onMissingMethod(
        required string missingMethodName,
        required struct missingMethodArguments
    ) {
        for ( var provider in providers ) {
            if ( methodExists( missingMethodName, provider ) ) {
                return invoke( provider, missingMethodName, missingMethodArguments );
            }
        }
        throw( "component [#getMetadata( this ).name#] has no function named [#missingMethodName#]" );
    }

    private function methodExists( methodName, component ) {
        var md = getMetadata( component );
        var funcs = getComponentFunctions( md );

        for ( var func in funcs ) {
            if ( func.name == methodName ) {
                return true;
            }
        }
        return false;
    }

    private function getComponentFunctions( required struct md ) {
        var funcs = [];

        if ( structKeyExists( md, "functions" ) ) {
            funcs.addAll( md.functions );
        }

        if ( structKeyExists( md, "extends" ) ) {
            funcs.addAll( getComponentFunctions( md.extends ) );
        }

        return funcs;
    }

}