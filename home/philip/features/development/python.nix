{
  programs.ruff = {
    enable = true;
    settings = {
      line-length = 88;
    };
  };
  programs.uv = {
    enable = true;
    settings = {
      python-downloads = "manual";
    };
  };
}
