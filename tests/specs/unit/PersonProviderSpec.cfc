component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.faker = new models.Generator();
        faker.addProvider( new models.Providers.en_US.Person( faker ) );
    }

    function run() {
        describe( "generating fake names", function() {
            it( "generates uniquely fake last names", function() {
                ensureUniqueness( "lastName" );
            } );

            it( "generates uniquely fake first names", function() {
                ensureUniqueness( "firstName" );
            } );

            it( "can specify the gender of the name", function() {
                ensureUniqueness( "maleFirstName" );
                ensureUniqueness( "femaleFirstName" );
            } );

            it( "generates uniquely fake names", function() {
                ensureUniqueness( "name" );
                ensureUniqueness( "maleName" );
                ensureUniqueness( "femaleName" );
            } );

            it( "generates full names by default", function() {
                expect( faker.name() ).toInclude( " ", "The name should have a space" );
                expect( faker.maleName() ).toInclude( " ", "The name should have a space" );
                expect( faker.femaleName() ).toInclude( " ", "The name should have a space" );
            } );

            it( "generates fake titles", function() {
                ensureUniqueness( "title", 10 );
                ensureUniqueness( "maleTitle", 10 );
                ensureUniqueness( "femaleTitle", 10 );
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