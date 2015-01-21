class cs162::bochs($home_directory, $owner, $group) {

    $install_script = "$home_directory/.bochs.install.sh"
    $install_directory = "$home_directory/bochs/"

    Package<| |>
    ->
    file { $install_script:
        ensure  => present,
        owner   => $owner,
        group   => $group,
        mode    => 0755,
        content => template("cs162/bochs/install.sh"),
    }
    ->
    exec { "install bochs from source":
        cwd     => $home_directory,
        user    => $owner,
        command => $install_script,
        creates => "/usr/local/bin/bochs",
    }

}
