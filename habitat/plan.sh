pkg_name=matchbox
pkg_origin=ncerny
pkg_version="0.7.0"
pkg_maintainer="Nathan Cerny <ncerny@gmail.com>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/coreos/matchbox/releases/download/v${pkg_version}/${pkg_name}-v${pkg_version}-linux-amd64.tar.gz"
pkg_shasum="aaf96b45f4f4886defce9eeefcfaec6ad31878ac0a9061b72390368d55fdba16"
pkg_dirname=${pkg_name}-v${pkg_version}-linux-amd64
pkg_deps=(core/glibc core/curl core/grep core/bash)
# pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port]=port
  [grpc-port]=grpc.port
)
pkg_exposes=(port grpc-port)
# pkg_binds=(
#   [database]="port host"
# )
# pkg_binds_optional=(
#   [storage]="port host"
# )
# pkg_interpreters=(bin/bash)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
pkg_description="Network boot and provision Container Linux clusters."
pkg_upstream_url="https://coreos.com/matchbox/"

do_build() {
    return 0
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  install -v -D "$HAB_CACHE_SRC_PATH/$pkg_dirname/matchbox" "$pkg_prefix/bin/matchbox"

  for dir in contrib docs examples scripts; do
    cp -r $HAB_CACHE_SRC_PATH/$pkg_dirname/$dir $pkg_prefix/
  done

  mkdir -p $pkg_prefix/var
  for dir in cloud generic groups ignition profiles; do
    cp -r $PLAN_CONTEXT/../$dir $pkg_prefix/var/
  done
}

do_strip() {
    return 0
}
