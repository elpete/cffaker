component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.faker = new models.Generator();
        prepareMock( faker );

        addMatchers( {
            "toContain" = function( expectation, args = {} ) {
                expectation.message = arrayLen( structKeyArray( args ) ) > 1 ? args[ 2 ] : "Could not find the given object in the array";
                if ( expectation.isNot ) {
                    return NOT arrayContains( expectation.actual, args[ 1 ] );
                } else {
                    return arrayContains( expectation.actual, args[ 1 ] );
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

        describe( "formatting tokens", function() {
            it( "searches it's providers to format a token", function() {
                var provider = getMockBox().createStub();
                provider.$( "firstName", "John" );
                faker.addProvider( provider );
                faker.format( "firstName" );

                expect( provider.$times( 1, "firstName" ) )
                    .toBeTrue( "`firstName()` should have been called once" );
            } );
        } );

        describe( "parsing templates", function() {
            it( "can parse a template in to the needed tokens", function() {
                faker.$( "format" ).$args( "firstName" ).$results( "John" );
                faker.$( "format" ).$args( "lastName" ).$results( "Doe" );
                faker.parse( "{{firstName}} {{lastName}}" );
                expect( faker.$times( 2, "format" ) )
                    .toBeTrue( "`format()` should have been called twice" );
            } );
        } );
    }
}