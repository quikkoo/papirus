Papirus
=======

[![License-Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](http://apache.org/licenses/LICENSE-2.0)

The Papirus project is a collection of scripts for the installation of
development tools in Linux machines.

In most cases, you have to work with a Linux distribution that doesn't provide
a package for some tool (language, compiler etc), or it provides a different
version rather than the one you need.

It aims to be most simple as possible, written in POSIX compliant shell
script [Almquist Shell](https://en.wikipedia.org/wiki/Almquist_shell), it
provides a simple way to provision host and guest machines with
[docker](https://www.docker.com/) or [vagarant](https://www.vagrantup.com/).

As it was stated before, the scripts are simple to use as simple to customize,
in fact, they are expected to be modified (before you run them) to suit the many varied needs of each environment.


### Example

You can run the script directly from github

```sh
# running the main script as root
curl -sSL https://github.com/quikkoo/papirus/papirus.sh | sh -s go 1.7.1

# running the main script as normal user
curl -sSL https://github.com/quikkoo/papirus/papirus.sh | sudo sh -s go 1.7.1

# running the specific script as root
curl -sSL https://github.com/quikkoo/papirus/scala.sh | sh -s 2.12.0

# running the specific script as normal user
curl -sSL https://github.com/quikkoo/papirus/scala.sh | sudo sh -s 2.12.0
```

Sometimes you'll need to rewrite the installation script, in that case, you must
tell to the main script to look up the underlying recipe locally, if you use the
specific recipe, nothing needs to be done.

```sh
# running the main script
export TARGET=file:///<path/to/scripts/directory>
./papirus.sh | sh -s rust 1.14.0

# running the specific script
./node 7.4.0
```


### Supported tools

  - go
  - gradle
  - groovy & grape
  - leiningen & clojure
  - maven
  - node & npm
  - rust & cargo
  - sbt
  - scala


### Run tests

You must have installed:

  - [make](https://www.gnu.org/software/make/)
  - [bats](https://github.com/sstephenson/bats/)
  - [docker engine](https://docs.docker.com/engine/)

So, just type:

```sh
make test
```


### Credits

  - [Tharcísio Angelo](https://github.com/quikkoo/)

Feel free to use, fork or make suggestions
