class cs162::fzf_install($home_directory, $owner, $group) {

    Package<| |>
    ->
    exec { "install fzf":
        cwd     => $home_directory,
        user    => $owner,
        environment => [ "HOME=$home_directory" ],
        command => "$home_directory/.fzf/install --no-update-rc --no-completion --key-bindings",
    }

}
