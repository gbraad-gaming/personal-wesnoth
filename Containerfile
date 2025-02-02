ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

USER root

RUN dnf install -y \
        flatpak \
    && dnf clean all \
    && rm -rf /var/cache/yum \
    && flatpak remote-add --if-not-exists \
        flathub https://dl.flathub.org/repo/flathub.flatpakrepo \
    && flatpak install --assumeyes \
        flathub org.wesnoth.Wesnoth \
    && git config -f /etc/rdesktop/rdesktop.ini \
	rdesktop.title "Personal Battle for Wesnoth" \
    && git config -f /etc/rdesktop/rdesktop.ini \
	rdesktop.exec "flatpak run org.wesnoth.Wesnoth"

# ensure to become root for systemd
#ENTRYPOINT ["/sbin/init"]
