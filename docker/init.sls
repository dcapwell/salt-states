docker:
  pkgrepo.managed:
    - humanname: Docker Inc. PPA
    - name: deb http://get.docker.io/ubuntu docker main
    - comments:
      - "# Docker Inc. Repo"
    - key_url: https://get.docker.io/gpg
    - require_in:
      # must be the id, not the package name
      - pkg: docker
  pkg.installed:
    - pkgs:
      - linux-image-extra-{{ grains.get('kernelrelease') }}
      - lxc-docker
