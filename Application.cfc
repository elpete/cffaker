component {
    this.name = "cffaker_" & hash( getCurrentTemplatePath() );
    this.mappings[ "/cffaker" ] = getDirectoryFromPath( getCurrentTemplatePath() );
}