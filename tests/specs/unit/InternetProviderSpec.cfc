component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.faker = new models.Generator();
        faker.addProvider( new models.Providers.en_US.Person( faker ) );
        faker.addProvider( new models.Providers.Internet( faker ) );
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