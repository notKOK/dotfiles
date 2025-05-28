{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mprocs
    just
    wiki-tui
    delta
    bat
    xh # sending requests over web
    zellij # tmux analog
    du-dust # disk usage in useful output
    dua # disk usage like in du
    rusty-man
    scooter # find and replace in files via tui

    tokei # count all tokens
  ];

  programs.fish = {
    enable = true;
  };
  users.users.danila.shell = pkgs.fish;
  programs.direnv.enable = true;
}
