{
  delib,
  lib,
  ...
}:
delib.extension {
  name = "binds";
  description = "Bind provider helpers for the binds module";

  libExtension = _: _: _: {
    mkBindProvider = name: data: {
      providers.${name} = data;
      provider = name;
    };

    mkDefaultBindProvider = name: data: {
      providers.${name} = data;
      provider = lib.mkDefault name;
    };
  };
}
