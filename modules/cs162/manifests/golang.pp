class cs162::golang($home_directory, $owner, $group) {

    $install_script = "$home_directory/.golang.install.sh"

    Package<| |>
    ->
    file { $install_script:
        ensure  => present,
        owner   => $owner,
        group   => $group,
        mode    => "0755",
        content => template("cs162/golang/install.sh"),
    }
    ->
    exec { "install golang":
        cwd     => $home_directory,
        user    => $owner,
        command => $install_script,
        creates => "/usr/local/go/bin/go",
    }

}
