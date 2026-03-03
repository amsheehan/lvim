-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.format_on_save.enabled = true
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

-- Cmd+\ for floating terminal (Ghostty sends \x1b[92;9u for super+backslash)
vim.keymap.set("n", "\x1b[92;9u", ":ToggleTerm direction=float<CR>", { silent = true })
vim.keymap.set("t", "\x1b[92;9u", "<C-\\><C-n>:ToggleTerm direction=float<CR>", { silent = true })

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss", "solargraph" })

-- Solargraph for intellisense only (no formatting/diagnostics — StandardRB handles those)
local lspconfig = require("lspconfig")
lspconfig.solargraph.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    solargraph = {
      diagnostics = false,
      formatting = false,
    }
  }
})

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
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "prettier",
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "css",
      "html",
      "json",
      "markdown",
    }
  },
  {
    command = "black",
    filetypes = { "python" }
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

-- StandardRB LSP (runs as a persistent server, formats instantly)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.lsp.start({
      name = "standardrb",
      cmd = { "standardrb", "--lsp" },
      root_dir = vim.fs.dirname(vim.fs.find({ ".standard.yml", "Gemfile" }, { upward = true })[1]),
    })
  end,
})

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
