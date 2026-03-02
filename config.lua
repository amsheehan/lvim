-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
lvim.keys.normal_mode["<leader>bd"] = ":Bdelete!<CR>"
lvim.keys.normal_mode["<leader>mr"] = ":RenderMarkdown toggle<CR>"

vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":bprev<CR>", { silent = true })
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.mouse = "a"

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })

lvim.builtin.telescope.defaults.vimgrep_arguments = {
  "/opt/homebrew/bin/rg",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",
  "--no-ignore",
  "--glob=!.git/",
  "--glob=!node_modules/",
  "--glob=!.next/",
  "--glob=!dist/",
  "--glob=!pnpm-lock.yaml",
}

lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "famiu/bufdelete.nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = {
      "markdown"
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  }
}

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "prettier",
    filetypes = {
      "typescript",
      "javascript",
      "css",
      "html",
      "json",
    }
  },
  {
    command = "black",
    filetypes = { " python" }
  }
}

local linters = require "lvim.lsp.null-ls.linters"

linters.setup {
  {
    command = "eslint",
    filetypes = {
      "javascript",
      "typescript",
      "css",
      "html",
      "json"
    }
  }
}

-- Dashboard ASCII art
lvim.builtin.alpha.dashboard.section.header.val = {
  "",
  [[                               _                                         ]],
  [[                            ==(W{==========-      /===-                  ]],
  [[                              ||  (.--.)         /===-_---~~~~~~~~~------____]],
  [[                              | \_,|**|,__      |===-~___                _,-' `]],
  [[                 -==\\        `\ ' `--'   ),    `//~\\   ~~~~`---.___.-~~]],
  [[             ______-==|        /`\_. .__/\ \    | |  \\           _-~`   ]],
  [[       __--~~~  ,-/-==\\      (   | .  |~~~~|   | |   `\        ,'       ]],
  [[    _-~       /'    |  \\     )__/==0==-\<>/   / /      \      /         ]],
  [[  .'        /       |   \\      /~\___/~~\/  /' /        \   /'          ]],
  [[ /  ____  /         |    \`\.__/-~~   \  |_/'  /          \/'            ]],
  [[/-'~    ~~~~~---__  |     ~-/~         ( )   /'        _--~`             ]],
  [[                  \_|      /        _) | ;  ),   __--~~                  ]],
  [[                    '~~--_/      _-~/- |/ \   '-~ \                      ]],
  [[                   {\__--_/}    / \\_>-|)<__\      \                     ]],
  [[                   /'   (_/  _-~  | |__>--<__|      |                    ]],
  [[                  |   _/) )-~     | |__>--<__|      |                    ]],
  [[                  / /~ ,_/       / /__>---<__/      |                    ]],
  [[                 o-o _//        /-~_>---<__-~      /                     ]],
  [[                 (^(~          /~_>---<__-      _-~                      ]],
  [[                ,/|           /__>--<__/     _-~                         ]],
  [[             ,//('(          |__>--<__|     /                  .----_    ]],
  [[            ( ( '))          |__>--<__|    |                 /' _---_~\  ]],
  [[         `-)) )) (           |__>--<__|    |               /'  /     ~\`\]],
  [[        ,/,'//( (             \__>--<__\    \            /'  //        ||]],
  [[      ,( ( ((, ))              ~-__>--<_~-_  ~--____---~' _/'/        /']],
  [[    `~/  )` ) ,/|                 ~-_~>--<_/-__       __-~ _/         ]],
  [[  ._-~//( )/ )) `                    ~~-'_/_/ /~~~~~~~__--~           ]],
  [[   ;'( ')/ ,)(                              ~~~~~~~~~~                ]],
  [[  ' ') '( (/                                                         ]],
  [[    '   '  `                                                         ]],
  "",
}
