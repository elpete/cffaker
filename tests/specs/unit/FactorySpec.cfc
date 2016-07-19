component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.factory = new models.Factory();
    }

    function run() {
        describe( "providers", function() {
            it( "is instantiates a generator with default providers", function() {
                var faker = factory.create();
                expect( faker.getProviders() )
                    .notToBeEmpty( "Default providers should have been set." );    
            } );
        } );
    }
}