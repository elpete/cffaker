component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.factory = new models.Factory();
        prepareMock( factory );
        factory.$property( propertyName = "moduleMapping", mock = "/" );
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