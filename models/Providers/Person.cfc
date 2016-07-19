component extends="cffaker.models.Providers.Base" {

    variables.titleFormats = [ "{{maleTitle}}", "{{femaleTitle}}" ];
    variables.firstNameFormats = [ "{{maleFirstName}}", "{{femaleFirstName}}" ];
    variables.maleNameFormats = [ "{{maleFirstName}} {{lastName}}" ];
    variables.femaleNameFormats = [ "{{femaleFirstName}} {{lastName}}" ];

    variables.maleFirstNames = [ "John" ];
    variables.femaleFirstNames = [ "Jane" ];
    variables.lastNames = [ "Doe" ];
    variables.maleTitles = [ "Mr.", "Dr.", "Prof." ];
    variables.femaleTitles = [ "Mrs.", "Ms.", "Miss", "Dr.", "Prof." ];

    public string function name() {
        var nameFormats = [];
        nameFormats.addAll( maleNameFormats );
        nameFormats.addAll( femaleNameFormats );
        var format = randomElement( nameFormats );
        return generator.parse( format );
    }

    public string function maleName() {
        var format = randomElement( maleNameFormats );
        return generator.parse( format );
    }

    public string function femaleName() {
        var format = randomElement( femaleNameFormats );
        return generator.parse( format );
    }

    public string function firstName() {
        var format = randomElement( firstNameFormats );
        return generator.parse( format );
    }

    public string function maleFirstName() {
        return randomElement( maleFirstNames );
    }

    public string function femaleFirstName() {
        return randomElement( femaleFirstNames );
    }

    public string function lastName() {
        return randomElement( lastNames );
    }

    public string function title() {
        var format = randomElement( titleFormats );
        return generator.parse( format );
    }

    public string function maleTitle() {
        return randomElement( maleTitles );
    }

    public string function femaleTitle() {
        return randomElement( femaleTitles );
    }

}