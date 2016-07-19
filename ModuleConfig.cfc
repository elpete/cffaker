component {

    this.name = "cffaker";
    this.author = "Eric Peterson";
    this.description = "A library for generating specific types of fake data";
    this.version = "0.1.0";
    this.cfmapping = "cffaker";
    this.autoMapModels = false;

    function configure() {
        binder.map( "moduleMapping@cffaker" ).toValue( "#moduleMapping#" );
        binder.map( "factory@cffaker" )
            .toFactoryMethod( "#moduleMapping#.models.Factory", "create" );
        binder.mapDSL( "faker", "#moduleMapping#.models.dsl.CFFakerDSL" );
    }

}