component {

    property name="providers" type="array" default="[]";

    variables.pattern = createObject( "java", "java.util.regex.Pattern" ).compile( "\{\{\s?(\w+)\s?\}\}" );

    public Generator function init() {
        variables.providers = [];
        return this;
    }

    public any function parse( required string template ) {
        var matcher = pattern.matcher( template );
        if ( ! matcher.find() ) {
            return template;
        }
        var method = mid( matcher.group(), 3, len( matcher.group() ) - 4 );
        return parse( matcher.replaceFirst( format( method ) ) );
    }

    public any function format( required string token ) {
        for ( var provider in providers ) {
            if ( methodExists( token, provider ) ) {
                return invoke( provider, token );
            }
        }
        throw( "component [#getMetadata( this ).name#] has no function named [#token#]" );
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

        // Also return true if we've mocked the method
        if ( structKeyExists( component, "_mockResults" ) ) {
            var mockedFuncNames = structKeyArray( component[ "_mockResults" ] );
            for ( var mockedFuncName in mockedFuncNames ) {
                if ( mockedFuncName == methodName ) {
                    return true;
                }
            }
        }

        return false;
    }

    private function getComponentFunctions( required struct md ) {
        var funcs = [];

        if ( structKeyExists( md, "functions" ) ) {
            for ( var func in md.functions ) {
                arrayAppend( funcs, func );
            }
        }

        if ( structKeyExists( md, "extends" ) ) {
            for ( var func in getComponentFunctions( md.extends ) ) {
                arrayAppend( funcs, func );
            }
        }

        return funcs;
    }

}