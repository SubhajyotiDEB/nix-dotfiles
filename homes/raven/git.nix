{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "SubhajyotiDEB";
    userEmail = "mrdeadlock8@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@gitlab.com:".insteadOf = "gl:";
        "git@codeberg.org:".insteadOf = "cb:";
        "git@github.com:SubhajyotiDEB/".insteadOf = "me@gh:";
      };
      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = true;
      };
    };
  };
}
