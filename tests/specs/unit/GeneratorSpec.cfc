component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.faker = new models.Generator();
        prepareMock( faker );

        addMatchers( {
            "toContain" = function( expectation, args = {} ) {
                expectation.message = arrayLen( structKeyArray( args ) ) > 1 ? args[2] : "Could not find the given object in the array";
                if ( expectation.isNot ) {
                    return NOT arrayContains( expectation.actual, args[1] );
                } else {
                    return arrayContains( expectation.actual, args[1] );
                }
            }
        } );
    }

    function run() {
        describe( "providers", function() {
            it( "can return the current list of providers", function() {
                expect( faker.getProviders() )
                    .toBeEmpty( "The generator should have no providers when first created." );
            } );

            it( "can add a new provider", function() {
                var provider = getMockBox().createStub();
                faker.addProvider( provider );
                expect( faker.$getProperty( "providers" ) )
                    .toContain( provider, "New provider did not get added to the providers." );
            } );
        } );
    }
}