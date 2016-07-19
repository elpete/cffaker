component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        var factory = new models.Factory();
        prepareMock( factory );
        factory.$property( propertyName = "moduleMapping", mock = "/" );
        variables.faker = factory.create();
    }

    function run() {
        describe( "generating fake emails", function() {
            it( "generates fake usernames", function() {
                ensureUniqueness( "username" );
            } );

            it( "generates fake email addresses", function() {
                ensureUniqueness( "email" );
            } );
        } );
    }

    private void function ensureUniqueness( required string method, numeric limit = 3 ) {
        var attempts = {};
        for ( var i = 1; i <= limit; i++ ) {
            var itemOne = invoke( faker, method );
            var itemTwo = invoke( faker, method );
            if ( itemOne != itemTwo ) {
                break;
            }
            attempts[ "Attempt #i#" ] = [ itemOne, itemTwo ];
            if ( i == limit ) {
                debug( attempts );
                fail( "Did not generate two unique records in a row after #limit# attempts" );
            }
        }
    }
}