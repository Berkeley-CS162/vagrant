class cs162::i386_gcc($home_directory, $owner, $group) {

    $install_script = "$home_directory/.i386-gcc.install.sh"

    Package<| |>
    ->
    file { $install_script:
        ensure  => present,
        owner   => $owner,
        group   => $group,
        mode    => "0755",
        content => template("cs162/i386-gcc/install.sh"),
    }
    ->
    exec { "install i386 GCC from source":
        cwd     => $home_directory,
        user    => $owner,
        command => $install_script,
        creates => "/usr/local/i386elfgcc",
        timeout => 0,
    }

}
