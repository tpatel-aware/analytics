locals {
  module_path        = abspath(path.module)
  codebase_root_path = abspath("${path.root}/..")
  module_rel_path    = substr(local.module_path, length(local.codebase_root_path)+1, length(local.module_path))
}
