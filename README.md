# helium.nix

![Build Status](https://github.com/J0schu/helium.nix/actions/workflows/update.yml/badge.svg)
![Helium Version](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/J0schu/helium.nix/master/version.json)
[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/J0schu/helium.nix/badge)](https://flakehub.com/flake/J0schu/helium.nix)

A Nix flake for the [Helium](https://github.com/imputnet/helium) browser.

## Features

- automatic updates (GPG-verified)
- uses the official AppImage
- desktop entry and icon installation

## Usage

### Update your `flake.nix`

```nix
{
  inputs = {
    helium = {
      url = "github:J0schu/helium.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```
#### Systemwide
```nix
environment.systemPackages = [
  inputs.helium.packages.${stdenv.hostPlatform.system}.default
];
```
#### Homemanager
```nix
home.packages = [
  inputs.helium.packages.${stdenv.hostPlatform.system}.default
];
```