# Project detection — ordered by specificity (first match wins)
# Format: filename|icon|color
# Colors: official brand color where possible, Dracula fallback
typeset -ga _project_rules=(
  # ── Frameworks (most specific) ─────────────────
  'svelte.config.js|'$'\ue8b7''|#ff3e00'       # Svelte orange
  'svelte.config.ts|'$'\ue8b7''|#ff3e00'
  'next.config.js|'$'\ue83e''|white'            # Next.js
  'next.config.ts|'$'\ue83e''|white'
  'next.config.mjs|'$'\ue83e''|white'
  'nuxt.config.ts|'$'\ue84b''|#00dc82'          # Nuxt green
  'nuxt.config.js|'$'\ue84b''|#00dc82'
  'astro.config.mjs|'$'\ue735''|#ff5d01'        # Astro orange
  'astro.config.ts|'$'\ue735''|#ff5d01'
  'angular.json|'$'\ue753''|#dd0031'            # Angular red
  'vue.config.js|'$'\ue8dc''|#4fc08d'           # Vue green
  'vite.config.ts|'$'\ue8d7''|#646cff'          # Vite purple
  'vite.config.js|'$'\ue8d7''|#646cff'
  'tauri.conf.json|'$'\ue8bb''|#ffc131'         # Tauri yellow
  'tauri.conf.json5|'$'\ue8bb''|#ffc131'
  'gatsby-config.js|'$'\ue7e3''|#663399'        # Gatsby purple
  'gatsby-config.ts|'$'\ue7e3''|#663399'
  'remix.config.js|'$'\ue71e''|white'           # Remix
  'remix.config.ts|'$'\ue71e''|white'
  'ember-cli-build.js|'$'\ue71b''|#e04e39'      # Ember red
  'solidjs.config.ts|'$'\ue8a7''|#2c4f7c'       # Solid blue
  # ── Backend frameworks ─────────────────────────
  'nest-cli.json|'$'\ue83b''|#e0234e'           # NestJS red
  'artisan|'$'\ue73f''|#ff2d20'                 # Laravel red
  'rails|'$'\ue73b''|#cc0000'                   # Rails red
  'manage.py|'$'\ue71d''|#092e20'               # Django green
  # ── Mobile ─────────────────────────────────────
  'Podfile|'$'\ue711''|white'                   # CocoaPods
  'Package.swift|'$'\ue755''|#f05138'            # Swift orange
  'build.gradle|'$'\ue7f2''|#02303a'            # Gradle
  'build.gradle.kts|'$'\ue81b''|#7f52ff'        # Kotlin purple
  'pubspec.yaml|'$'\ue7dd''|#02569b'            # Flutter blue
  # ── Languages ──────────────────────────────────
  'Cargo.toml|'$'\ue7a8''|#dea584'              # Rust orange
  'go.mod|'$'\ue724''|#00add8'                  # Go cyan
  'pyproject.toml|'$'\ue73c''|#3776ab'          # Python blue
  'setup.py|'$'\ue73c''|#3776ab'
  'requirements.txt|'$'\ue73c''|#3776ab'
  'Gemfile|'$'\ue739''|#cc342d'                 # Ruby red
  'mix.exs|'$'\ue7cd''|#6e4a7e'                # Elixir purple
  'stack.yaml|'$'\ue777''|#5d4f85'             # Haskell purple
  'gleam.toml|'$'\ue71e''|#ffaff3'              # Gleam pink
  'build.zig|'$'\ue71e''|#f7a41d'               # Zig orange
  'CMakeLists.txt|'$'\ue794''|#064f8c'          # CMake blue
  'deno.json|'$'\ue7c0''|white'                 # Deno
  'deno.jsonc|'$'\ue7c0''|white'
  'bun.lockb|'$'\ue76f''|#fbf0df'              # Bun cream
  'composer.json|'$'\ue783''|#777bb4'            # PHP purple
  '.luarc.json|'$'\ue826''|#000080'             # Lua blue
  '.luacheckrc|'$'\ue826''|#000080'
  'tsconfig.json|'$'\ue8ca''|#3178c6'           # TypeScript blue
  'package.json|'$'\ue71e''|#339933'            # Node/npm green
  # ── .NET ───────────────────────────────────────
  '*.sln|'$'\ue77f''|#512bd4'                   # .NET purple
  '*.csproj|'$'\ue7b2''|#512bd4'
  # ── Infra / tools ─────────────────────────────
  'flake.nix|'$'\ue843''|#5277c3'              # Nix blue
  'default.nix|'$'\ue843''|#5277c3'
  '.terraform.lock.hcl|'$'\ue8bd''|#7b42bc'     # Terraform purple
  'ansible.cfg|'$'\ue723''|#ee0000'             # Ansible red
  'playbook.yml|'$'\ue723''|#ee0000'
  'Dockerfile|'$'\ue7b0''|#2496ed'              # Docker blue
  'docker-compose.yml|'$'\ue7b0''|#2496ed'
  'compose.yml|'$'\ue7b0''|#2496ed'
  'Makefile|'$'\ue779''|white'
  'Justfile|'$'\ue779''|white'
  'Vagrantfile|'$'\ue8d0''|#1868f2'             # Vagrant blue
  'Pulumi.yaml|'$'\ue873''|#8a3391'             # Pulumi purple
  'helmfile.yaml|'$'\ue7fb''|#0f1689'           # Helm blue
  'skaffold.yaml|'$'\ue7b0''|#2496ed'
)