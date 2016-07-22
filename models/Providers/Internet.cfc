component extends="cffaker.models.Providers.Base" {

    variables.userNameFormats = [
        "{{firstName}}.{{lastName}}",
        "{{lastName}}.{{firstName}}",
        "{{firstName}}##",
        "?{{firstName}}"
    ];
    variables.emailFormats = [ "{{userName}}@{{safeEmailDomain}}" ];

    variables.safeEmailDomains = [ "example.com", "example.org", "example.net" ];

    public string function username() {
        var format = randomElement( userNameFormats );
        return lexify( numerify( generator.parse( format ) ) );
    }

    public string function email() {
        var format = randomElement( emailFormats );
        return generator.parse( format );
    }

    public string function safeEmailDomain() {
        return randomElement( safeEmailDomains );
    }

}