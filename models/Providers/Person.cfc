component extends="cffaker.models.Providers.Base" {

    variables.maleFirstNames = [ "John" ];
    variables.femaleFirstNames = [ "Jane" ];
    variables.lastNames = [ "Doe" ];
    variables.maleTitles = [ "Mr.", "Dr.", "Prof." ];
    variables.femaleTitles = [ "Mrs.", "Ms.", "Miss", "Dr.", "Prof." ];

    public string function name() {
        return "#firstName()# #lastName()#";
    }

    public string function maleName() {
        return "#maleFirstName()# #lastName()#";   
    }

    public string function femaleName() {
        return "#femaleFirstName()# #lastName()#";   
    }

    public string function firstName() {
        var firstNames = [];
        firstNames.addAll( maleFirstNames );
        firstNames.addAll( femaleFirstNames );
        return getElement( firstNames );
    }

    public string function maleFirstName() {
        return getElement( maleFirstNames );
    }

    public string function femaleFirstName() {
        return getElement( femaleFirstNames );
    }

    public string function lastName() {
        return getElement( lastNames );
    }

    public string function title() {
        var titles = [];
        titles.addAll( maleTitles );
        titles.addAll( femaleTitles );
        return getElement( titles );
    }

    public string function maleTitle() {
        return getElement( maleTitles );
    }

    public string function femaleTitle() {
        return getElement( femaleTitles );
    }

}