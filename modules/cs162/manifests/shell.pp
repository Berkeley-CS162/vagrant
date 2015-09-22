class cs162::shell($home_directory, $owner, $group) {

    File {
        owner => $owner,
        group => $group,
    }

    file {
        "$home_directory/.bashrc":
            ensure => present,
            content => template("cs162/shell/bashrc");
        "$home_directory/.cs162.bashrc":
            ensure => present,
            content => template("cs162/shell/cs162.bashrc");
        "$home_directory/.bin":
            ensure             => directory,
            source             => "puppet:///modules/cs162/shell/bin",
            source_permissions => use,
            recurse            => true;
    }

}
