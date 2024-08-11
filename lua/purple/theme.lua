local util = require("purple.util")
local colors = require("purple.colors")

local M = {}
--
---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight

---@alias Highlights table<string,Highlight>

---@return Theme
function M.setup()
  local config = require("purple.config")
  local options = config.options
  ---@class Theme
  ---@field highlights Highlights
  local theme = {
    config = options,
    colors = colors.setup(),
  }

  local c = theme.colors

  theme.highlights = {
    Comment = { fg = "#51545c", style = options.styles.comments }, -- any comment
    ColorColumn = { bg = "#171717" }, -- used for the columns set with 'colorcolumn'
    Conceal = { fg = c.base01 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = c.lgtbase00, bg = "#1d1d1d" }, -- character under the cursor
    lCursor = { fg = c.base03, bg = c.base00 }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM = { fg = c.base03, bg = c.base00}, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = c.base02 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = "#262626", sp = c.lgtbase01 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory = { fg = "#d1d1d1" }, -- directory names (and other special names in listings)
    DiffAdd = { fg = c.gitGreen, bg = c.base02, bold = true }, -- diff mode: Added line |diff.txt|
    DiffChange = { fg = c.gitOrange, bg = c.base02, bold = true }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { fg = c.gitRed, bg = c.base02, bold = true }, -- diff mode: Deleted line |diff.txt|
    DiffText = { fg = c.base01, bg = c.base02, bold = true }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer = { fg = c.base01 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor  = { }, -- cursor in a focused terminal
    -- TermCursorNC= { }, -- cursor in an unfocused terminal
    ErrorMsg = { fg = c.red500, reverse = true }, -- error messages on the command line
    VertSplit = { fg =  "#272727" }, -- the column separating vertically split windows
    -- WinSeparator = { fg = "#272727", bold = true }, -- the column separating vertically split windows
    WinSeparator = { fg = "#272727" },
    Folded = { fg = c.base01, bg = c.base02, bold = true }, -- line used for closed folds
    FoldColumn = { fg = c.base00}, -- 'foldcolumn'
    SignColumn = { fg = c.base00}, -- column where |signs| are displayed
    SignColumnSB = { fg = c.base00}, -- column where |signs| are displayed
    Substitute = { fg = c.lgtbase01, bg = c.red500 }, -- |:substitute| replacement text highlighting
    LineNr = { fg = "#7e7e7e", bg = options.transparent and c.none or c.bg }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = { fg = "#d1d1d1" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen = { fg = c.red100, bg = c.red500, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg = { fg = c.base01 }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea = { fg = c.base01 }, -- Area for messages and cmdline
    -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg = { fg = c.base01 }, -- |more-prompt|
    NonText = { fg = c.base01, bold = true }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal = { fg = c.base01, bg = options.transparent and c.none or c.bg }, -- normal text
    -- NormalNC = { fg = c.base00, bg = options.transparent and c.none or options.dim_inactive and c.base03 or c.bg }, -- normal text in non-current windows
    NormalSB = { fg = c.base01, bg = c.bg_sidebar }, -- normal text in sidebar
    NormalFloat = { fg = c.base01, bg = c.bg_float }, -- Normal text in floating windows.
    FloatBorder = { fg = c.base01, bg = c.bg_float },
    FloatTitle = { fg = c.lgtbase01, bg = c.bg_float },
    Pmenu = { fg = c.base01, bg = "#302c2c" }, -- Popup menu: normal item.
    PmenuSel = { fg = c.base01, bg = c.lgtbase01, reverse = true }, -- Popup menu: selected item.
    PmenuSbar = { fg = c.base03, reverse = true }, -- Popup menu: scrollbar.
    PmenuThumb = { fg = c.base01, reverse = true }, -- Popup menu: Thumb of the scrollbar.
    Question = { fg = c.cyan100, bold = true }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine = { bg = c.blue100, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search = { bg = "#2f2f2f" }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch = { bg = "#4f4f4f", standout = true }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch = { link = "IncSearch" },
    SpecialKey = { fg = c.base01 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad = { sp = c.red500, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap = { sp = c.gitOrange, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal = { sp = c.cyan100, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare = { sp = c.gitOrange, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine = { fg = c.lgtbase01, bg = c.base03 }, -- status line of current window
    StatusLineNC = { fg = c.base01, bg = c.base03 }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine = { fg = c.base01, bg = c.base01, sp = c.base00}, -- tab pages line, not active tab page label
    TabLineFill = { fg = c.base01, bg = c.base02 }, -- tab pages line, where there are no labels
    TabLineSel = { fg = c.gitOrange, bg = c.bg }, -- tab pages line, active tab page label
    Title = { fg = c.blue100, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
    -- Visual = { bg = "#2f2f2f", reverse = true }, -- Visual mode selection
    Visual = { bg = "#2f2f2f"}, -- Visual mode selection
    VisualNOS = { bg = c.base03, reverse = true }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = c.warning, bold = true }, -- warning messages
    Whitespace = { fg = c.base01 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu = { fg = c.lgtbase01, bg = c.base02, reverse = true }, -- current match in 'wildmenu' completion
    WinBar = { link = "StatusLine" }, -- window bar
    WinBarNC = { link = "StatusLineNC" }, -- window bar in inactive windows

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant = { fg = c.blue100 }, -- (preferred) any constant
    String = { fg = c.red100 }, --   a string constant: "this is a string"
    Character = { link = "Constant" }, --  a character constant: 'c', '\n'
    Number        = { fg = "#5effc3" }, --   a number constant: 234, 0xff
    Boolean       = { fg = "#5effc3" }, --  a boolean constant: TRUE, false
    -- Float         = { }, --    a floating point constant: 2.3e10

    Identifier = { fg = c.blue100, style = options.styles.variables }, -- (preferred) any variable name
    Function = { fg = c.cyan100, style = options.styles.functions }, -- function name (also: methods for classes)

    Statement = { fg = "#ff5eed" }, -- (preferred) any statement
    -- Conditional   = { }, --  if, then, else, endif, switch, etc.
    -- Repeat        = { }, --   for, do, while, etc.
    -- Label         = { }, --    case, default, etc.
    Operator = { fg = "#d1d1d1" }, -- "sizeof", "+", "*", etc.
    Keyword = { fg =  c.pink, style = options.styles.keywords }, --  any other keyword
    -- Exception     = { }, --  try, catch, throw

    PreProc = { fg = c.pink }, -- (preferred) generic Preprocessor
    Include       = { fg = c.pink }, --  preprocessor #include
    -- Define        = { }, --   preprocessor #define
    -- Macro         = { }, --    same as Define
    -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

    Type = { fg = "#d1d1d1" }, -- (preferred) int, long, char, etc.
    -- StorageClass  = { }, -- static, register, volatile, etc.
    -- Structure     = { }, --  struct, union, enum, etc.
    -- Typedef       = { }, --  A typedef

    Special = { fg = "#d1d1d1" }, -- (preferred) any special symbol
    -- SpecialChar   = { }, --  special character in a constant
    -- Tag           = { }, --    you can use CTRL-] on this
    -- Delimiter     = { }, --  character that needs attention
    -- SpecialComment= { }, -- special things inside a comment
    Debug = { fg = c.blue100 }, --    debugging statements

    Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
    Bold = { bold = true },
    Italic = { italic = true },

    -- ("Ignore", below, may be invisible...)
    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error = { fg = c.red500 }, -- (preferred) any erroneous construct
    Todo = { fg = c.magenta100, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- Not sure what this actually does?
    qfLineNr = { fg = c.base00},
    qfFileName = { fg = c.lgtbase01 },

    htmlH1 = { fg = c.magenta100, bold = true },
    htmlH2 = { fg = c.base01, bold = true },

    mkdHeading = { fg = c.pink, bold = true },
    mkdCode = { bg = c.base01 },
    mkdCodeDelimiter = { fg = c.base01, bg = c.green100 },
    mkdCodeStart = { fg = c.blue100, bold = true },
    mkdCodeEnd = { fg = c.blue100, bold = true },
    mkdLink = { fg = c.blue, underline = true },

    markdownHeadingDelimiter = { fg = c.blue100, bold = true },
    markdownCode = { fg = c.gitOrange, bg = c.base01 },
    markdownCodeBlock = { fg = c.gitOrange, bg = c.base01 },
    markdownH1 = { fg = c.magenta100, bold = true },
    markdownH2 = { fg = c.blue100, bold = true },
    markdownLinkText = { fg = c.base01, underline = true },

    -- Not super sure what this is
    ["helpCommand"] = { fg = c.base01, bg = c.blue100 },

    debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint = { fg = c.blue100, bg = c.blue100 }, -- used for breakpoint colors in terminal-debug

    dosIniLabel = { link = "@property" },

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    LspReferenceText = { bg = c.magenta100 }, -- used for highlighting "text" references
    LspReferenceRead = { bg = c.magenta100 }, -- used for highlighting "read" references
    LspReferenceWrite = { bg = c.magenta100 }, -- used for highlighting "write" references

    DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticUnnecessary = { fg = c.base00 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

    DiagnosticVirtualTextError = { fg = c.error }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarn = { fg = c.warning }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInfo = { fg = c.info }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint = { fg = c.hint }, -- Used for "Hint" diagnostic virtual text

    DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics

    LspSignatureActiveParameter = { bg = c.base03, bold = true },
    LspCodeLens = { fg = c.base01 },
    LspInlayHint = { bg = c.base01, fg = c.blue100 },

    LspInfoBorder = { fg = c.base02, bg = c.bg_float },

    DapStoppedLine = { bg = c.warning }, -- Used for "Warning" diagnostic virtual text

    -- These groups are for the Neovim tree-sitter highlights.
    ["@annotation"] = { link = "PreProc" },
    ["@attribute"] = { link = "PreProc" },
    ["@boolean"] = { link = "Boolean" },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@comment"] = { link = "Comment" },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { link = "Special" },
    ["@constant.macro"] = { link = "Define" },
    ["@keyword.debug"] = { link = "Debug" },
    ["@keyword.directive.define"] = { link = "Define" },
    ["@keyword.exception"] = { link = "Exception" },
    ["@number.float"] = { link = "Float" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Special" },
    ["@function.call"] = { link = "@function" },
    ["@function.macro"] = { link = "Macro" },
    ["@keyword.import"] = { link = "Include" },
    ["@keyword.coroutine"] = { link = "@keyword" },
    ["@keyword.operator"] = { link = "@operator" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@function.method"] = { link = "Function" },
    ["@function.method.call"] = { link = "@function.method" },
    ["@namespace.builtin"] = { link = "@variable.builtin" },
    ["@none"] = {},
    ["@number"] = { link = "Number" },
    ["@keyword.directive"] = { link = "PreProc" },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@keyword.storage"] = { link = "StorageClass" },
    ["@string"] = { link = "String" },
    ["@markup.link.label"] = { link = "SpecialChar" },
    ["@markup.link.label.symbol"] = { link = "Identifier" },
    ["@tag"] = { link = "Label" },
    ["@tag.attribute"] = { link = "@property" },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@markup"] = { link = "@none" },
    ["@markup.environment"] = { link = "Macro" },
    ["@markup.environment.name"] = { link = "Type" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.math"] = { link = "Special" },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { link = "Title" },
    ["@comment.note"] = { fg = c.hint },
    ["@comment.error"] = { fg = c.error },
    ["@comment.hint"] = { fg = c.hint },
    ["@comment.info"] = { fg = c.info },
    ["@comment.warning"] = { fg = c.warning },
    ["@comment.todo"] = { fg = c.todo },
    ["@markup.link.url"] = { link = "Underlined" },
    ["@type"] = { link = "Type" },
    ["@type.definition"] = { link = "Typedef" },
    ["@type.qualifier"] = { link = "@keyword" },

    --- Misc
    -- TODO:
    -- ["@comment.documentation"] = { },
    ["@operator"] = { fg = "#d1d1d1" }, -- For any operator: `+`, but also `->` and `*` in C.

    --- Punctuation
    ["@punctuation.delimiter"] = { fg = "#d1d1d1" }, -- For delimiters ie: `.`
    ["@punctuation.bracket"] = { fg = c.blue100 }, -- For brackets and parens.
    ["@punctuation.special"] = { fg = c.blue100 }, -- For special punctutation that does not fall in the catagories before.
    ["@punctuation.special.markdown"] = { fg = c.blue100, bold = true },
    ["@markup.list"] = { fg = c.base01 }, -- For special punctutation that does not fall in the catagories before.
    ["@markup.list.markdown"] = { fg = c.blue100, bold = true },

    --- Literals
    ["@string.documentation"] = { fg = c.cyan100 },
    ["@string.regexp"] = { fg = c.cyan100 }, -- For regexes.
    ["@string.escape"] = { fg = c.blue100 }, -- For escape characters within a string.

    --- Functions
    ["@constructor"] = { fg = c.blue100 }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    ["@variable.parameter"] = { fg = c.blue100 }, -- For parameters of a function.
    ["@variable.parameter.builtin"] = { fg = c.yellow100 }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

    --- Keywords
    ["@keyword"] = { fg = "#ff5eed", style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
    ["@keyword.function"] = { fg = c.pink, style = options.styles.functions }, -- For keywords used to define a fuction.

    ["@label"] = { fg = "#ff5eed" }, -- For labels: `label:` in C and `:label:` in Lua.

    --- Types
    ["@type.builtin"] = { link = "Type" },
    ["@variable.member"] = { fg = c.blue100 }, -- For fields.
    ["@property"] = { link = "Identifier" },

    --- Identifiers
    ["@variable"] = { fg = c.blue100, style = options.styles.variables }, -- Any variable name that does not have another highlight.
    ["@variable.builtin"] = { fg = c.blue100 }, -- Variable names that are defined by the languages, like `this` or `self`.
    ["@module.builtin"] = { fg = c.blue100 }, -- Variable names that are defined by the languages, like `this` or `self`.

    --- Text
    -- ["@markup.raw.markdown"] = { fg = c.blue },
    ["@markup.raw.markdown_inline"] = { fg = c.gitOrange, bg = c.base01 },
    ["@markup.link"] = { fg = c.base01, underline = true },

    ["@markup.list.unchecked"] = { fg = c.gitOrange }, -- For brackets and parens.
    ["@markup.list.checked"] = { fg = c.pink }, -- For brackets and parens.

    ["@diff.plus"] = { link = "DiffAdd" },
    ["@diff.minus"] = { link = "DiffDelete" },
    ["@diff.delta"] = { link = "DiffChange" },

    ["@module"] = { link = "Include" },

    -- tsx
    ["@constructor.tsx"] = { fg = c.base01 },
    ["@tag.delimiter.tsx"] = { fg = c.blue100 },
    ["@tag.tsx"] = { fg = c.gitOrange },
    ["@keyword.return.tsx"] = { fg = c.pink, style = "italic" },
    ["@keyword.tsx"] = { fg = c.pink, style = "italic" },

    -- typescript
    ["@variable.typescript"] = { fg = c.gitOrange },

    -- Vue
    ["@tag.delimiter.vue"] = { fg = c.blue100 },

    -- html
    ["@tag.delimiter.html"] = { fg = c.blue100 },

    -- javascriptreact
    ["@keyword.javascript"] = { fg = c.pink, style = "italic" },
    ["@keyword.return.javascript"] = { fg = c.pink, style = "italic" },
    ["@tag.delimiter.javascript"] = { fg = c.blue100 },
    ["@tag.javascript"] = { fg = c.gitOrange },
    ["@variable.javascript"] = { fg = c.gitOrange },

    -- LSP Semantic Token Groups
    ["@lsp.type.boolean"] = { link = "@boolean" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.deriveHelper"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.formatSpecifier"] = { link = "@markup.list" },
    ["@lsp.type.generic"] = { link = "@variable" },
    ["@lsp.type.interface"] = { fg = c.base01 },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.lifetime"] = { link = "@keyword.storage" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.error },
    ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
    ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
    ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.type.defaultLibrary"] = { fg = c.base01 },
    ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = c.base01 },
    ["@lsp.typemod.variable.callable"] = { link = "@function" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },
    ["@lsp.typemod.variable.static"] = { link = "@constant" },
    -- NOTE: maybe add these with distinct highlights?
    -- ["@lsp.typemod.variable.globalScope"] (global variables)

    -- ts-rainbow
    rainbowcol1 = { fg = c.red500 },
    rainbowcol2 = { fg = c.blue100 },
    rainbowcol3 = { fg = c.gitOrange },
    rainbowcol4 = { fg = c.gitGreen },
    rainbowcol5 = { fg = c.cyan100 },
    rainbowcol6 = { fg = c.base01 },
    rainbowcol7 = { fg = c.magenta100 },

    -- ts-rainbow2 (maintained fork)
    TSRainbowRed = { fg = c.red },
    TSRainbowOrange = { fg = c.pink },
    TSRainbowYellow = { fg = c.yellow },
    TSRainbowGreen = { fg = c.green },
    TSRainbowBlue = { fg = c.blue },
    TSRainbowViolet = { fg = c.blue100 },
    TSRainbowCyan = { fg = c.cyan },

    -- rainbow-delimiters
    RainbowDelimiterRed = { fg = "#ffd700" },
    RainbowDelimiterOrange = { fg = "#da70d6" },
    RainbowDelimiterYellow = { fg = "#179fff" },
    RainbowDelimiterGreen = { fg = "#ffd700" },
    RainbowDelimiterBlue = { fg = "#da70d6" },
    RainbowDelimiterViolet = { fg = "#179fff" },
    RainbowDelimiterCyan = { fg = "#ffd700" },

    -- LspTrouble
    TroubleText = { fg = c.base00},
    TroubleCount = { fg = c.magenta100 },
    TroubleNormal = { fg = c.base00},

    -- Illuminate
    illuminatedWord = { bg = c.base01 },
    illuminatedCurWord = { bg = c.base01 },
    IlluminatedWordText = { bg = c.base01 },
    IlluminatedWordRead = { bg = c.magenta100 },
    IlluminatedWordWrite = { bg = c.magenta100 },

    -- diff
    diffAdded = { fg = c.gitGreen },
    diffRemoved = { fg = c.red500 },
    diffChanged = { fg = c.gitOrange },
    diffOldFile = { fg = c.blue100 },
    diffNewFile = { fg = c.blue100 },
    diffFile = { fg = c.base01 },
    diffLine = { fg = c.base01 },
    diffIndexLine = { fg = c.magenta100 },

    -- Neogit
    NeogitBranch = { fg = c.magenta100 },
    NeogitRemote = { fg = c.blue100 },
    NeogitHunkHeader = { fg = c.base01, bg = c.base02 },
    NeogitHunkHeaderHighlight = { fg = c.base01, bg = c.base02 },
    NeogitDiffContextHighlight = { fg = c.base00, bg = c.base02 },
    NeogitDiffDeleteHighlight = { fg = c.red500, bg = c.gitRed },
    NeogitDiffAddHighlight = { fg = c.gitGreen, bg = c.gitGreen },

    -- Neotest
    NeotestPassed = { fg = c.gitGreen },
    NeotestRunning = { fg = c.gitOrange },
    NeotestFailed = { fg = c.red500 },
    NeotestSkipped = { fg = c.base01 },
    NeotestTest = { fg = c.base00 },
    NeotestNamespace = { fg = c.cyan100 },
    NeotestFocused = { fg = c.gitOrange },
    NeotestFile = { fg = c.cyan100 },
    NeotestDir = { fg = c.base01 },
    NeotestBorder = { fg = c.base01 },
    NeotestIndent = { fg = c.base00 },
    NeotestExpandMarker = { fg = c.base00},
    NeotestAdapterName = { fg = c.blue100, bold = true },
    NeotestWinSelect = { fg = c.base01 },
    NeotestMarked = { fg = c.base01 },
    NeotestTarget = { fg = c.base01 },
    --[[ NeotestUnknown = {}, ]]

    -- GitGutter
    GitGutterAdd = { fg = c.gitGreen }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { fg = c.gitOrange }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = { fg = c.red500 }, -- diff mode: Deleted line |diff.txt|
    GitGutterAddLineNr = { fg = c.gitGreen },
    GitGutterChangeLineNr = { fg = c.gitOrange },
    GitGutterDeleteLineNr = { fg = c.red500 },

    -- GitSigns
    GitSignsAdd = { fg = c.gitGreen }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = c.gitOrange }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = c.gitRed }, -- diff mode: Deleted line |diff.txt|

    -- Telescope
    TelescopeBorder = { fg = c.base01, bg = c.bg_float },
    TelescopeNormal = { fg = c.base01, bg = c.bg_float },

    -- NvimTree
    NvimTreeNormal = { fg = c.base00, bg = c.bg_sidebar },
    NvimTreeWinSeparator = {
      fg = options.styles.sidebars == "transparent" and c.border or c.bg_sidebar,
      bg = c.bg_sidebar,
    },
    NvimTreeNormalNC = { fg = c.base00, bg = c.bg_sidebar },
    NvimTreeRootFolder = { fg = c.blue, bold = true },
    NvimTreeGitDirty = { fg = c.gitOrange },
    NvimTreeGitNew = { fg = c.gitGreen },
    NvimTreeGitDeleted = { fg = c.red500 },
    NvimTreeOpenedFile = { bg = c.bg_highlight },
    NvimTreeSpecialFile = { fg = c.blue100, underline = true },
    NvimTreeIndentMarker = { fg = c.base02 },
    NvimTreeImageFile = { fg = c.base00 },
    NvimTreeSymlink = { fg = c.blue },
    NvimTreeFolderIcon = { bg = c.none, fg = c.blue },
    -- NvimTreeFolderName= { fg = c.fg_float },

    NeoTreeNormal = { fg = c.base00, bg = c.bg_sidebar },
    NeoTreeNormalNC = { fg = c.base00, bg = c.bg_sidebar },
    NeoTreeDimText = { fg = c.base01 },

    -- Fern
    FernBranchText = { fg = c.blue },

    -- glyph palette
    GlyphPalette1 = { fg = c.red500 },
    GlyphPalette2 = { fg = c.green },
    GlyphPalette3 = { fg = c.yellow },
    GlyphPalette4 = { fg = c.blue },
    GlyphPalette6 = { fg = c.cyan },
    GlyphPalette7 = { fg = c.fg },
    GlyphPalette9 = { fg = c.red },

    -- Dashboard
    DashboardShortCut = { fg = c.cyan },
    DashboardHeader = { fg = c.blue },
    DashboardCenter = { fg = c.magenta },
    DashboardFooter = { fg = c.yellow, italic = true },
    DashboardKey = { fg = c.blue100 },
    DashboardDesc = { fg = c.cyan100 },
    DashboardIcon = { fg = c.cyan100, bold = true },

    -- Alpha
    AlphaShortcut = { fg = c.pink },
    AlphaHeader = { fg = c.blue },
    AlphaHeaderLabel = { fg = c.pink },
    AlphaFooter = { fg = c.cyan },
    AlphaButtons = { fg = c.cyan },

    -- WhichKey
    WhichKey = { fg = c.cyan },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.magenta },
    WhichKeySeperator = { fg = c.base01 },
    WhichKeySeparator = { fg = c.base01 },
    WhichKeyFloat = { bg = c.bg_sidebar },
    WhichKeyValue = { fg = c.blue100 },

    -- LspSaga
    DiagnosticWarning = { link = "DiagnosticWarn" },
    DiagnosticInformation = { link = "DiagnosticInfo" },

    LspFloatWinNormal = { bg = c.bg_float },
    LspFloatWinBorder = { fg = c.base02 },
    LspSagaBorderTitle = { fg = c.cyan },
    LspSagaHoverBorder = { fg = c.blue },
    LspSagaRenameBorder = { fg = c.green },
    LspSagaDefPreviewBorder = { fg = c.green },
    LspSagaCodeActionBorder = { fg = c.blue },
    LspSagaFinderSelection = { fg = c.base03 },
    LspSagaCodeActionTitle = { fg = c.cyan },
    LspSagaCodeActionContent = { fg = c.blue100 },
    LspSagaSignatureHelpBorder = { fg = c.red },
    ReferencesCount = { fg = c.blue100 },
    DefinitionCount = { fg = c.blue100 },
    DefinitionIcon = { fg = c.blue },
    ReferencesIcon = { fg = c.blue },
    TargetWord = { fg = c.cyan100 },

    -- NeoVim
    healthError = { fg = c.error },
    healthSuccess = { fg = c.cyan },
    healthWarning = { fg = c.warning },

    -- BufferLine
    BufferLineIndicatorSelected = { fg = c.gitOrange },

    -- Barbar
    BufferCurrent = { bg = c.bg, fg = c.fg },
    BufferCurrentERROR = { bg = c.bg, fg = c.error },
    BufferCurrentHINT = { bg = c.bg, fg = c.hint },
    -- BufferCurrentIcon = { bg = c.bg, fg = c.},
    BufferCurrentINFO = { bg = c.bg, fg = c.info },
    BufferCurrentWARN = { bg = c.bg, fg = c.warning },
    BufferCurrentIndex = { bg = c.bg, fg = c.info },
    BufferCurrentMod = { bg = c.bg, fg = c.warning },
    BufferCurrentSign = { bg = c.bg, fg = c.bg },
    BufferCurrentTarget = { bg = c.bg, fg = c.red },
    BufferAlternate = { bg = c.base01, fg = c.fg },
    BufferAlternateERROR = { bg = c.base01, fg = c.error },
    BufferAlternateHINT = { bg = c.base01, fg = c.hint },
    -- BufferAlternateIcon = { bg = c.base01, fg = c. },
    BufferAlternateIndex = { bg = c.base01, fg = c.info },
    BufferAlternateINFO = { bg = c.base01, fg = c.info },
    BufferAlternateMod = { bg = c.base01, fg = c.warning },
    BufferAlternateSign = { bg = c.base01, fg = c.info },
    BufferAlternateTarget = { bg = c.base01, fg = c.red },
    BufferAlternateWARN = { bg = c.base01, fg = c.warning },
    BufferVisible = { bg = c.bg_statusline, fg = c.fg },
    BufferVisibleERROR = { bg = c.bg_statusline, fg = c.error },
    BufferVisibleHINT = { bg = c.bg_statusline, fg = c.hint },
    -- BufferVisibleIcon = { bg = c.bg_statusline, fg = c. },
    BufferVisibleINFO = { bg = c.bg_statusline, fg = c.info },
    BufferVisibleWARN = { bg = c.bg_statusline, fg = c.warning },
    BufferVisibleIndex = { bg = c.bg_statusline, fg = c.info },
    BufferVisibleMod = { bg = c.bg_statusline, fg = c.warning },
    BufferVisibleSign = { bg = c.bg_statusline, fg = c.info },
    BufferVisibleTarget = { bg = c.bg_statusline, fg = c.red },
    BufferInactive = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.blue100, 0.8) },
    BufferInactiveERROR = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.error, 0.8) },
    BufferInactiveHINT = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.hint, 0.8) },
    -- BufferInactiveIcon = { bg = c.bg_statusline, fg = util.darken(c., 0.1) },
    BufferInactiveINFO = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.info, 0.8) },
    BufferInactiveWARN = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
    BufferInactiveIndex = { bg = util.darken(c.bg_highlight, 0.4), fg = c.blue100 },
    BufferInactiveMod = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
    BufferInactiveSign = { bg = util.darken(c.bg_highlight, 0.4), fg = c.bg },
    BufferInactiveTarget = { bg = util.darken(c.bg_highlight, 0.4), fg = c.red },
    BufferOffset = { bg = c.bg_statusline, fg = c.blue100 },
    BufferTabpageFill = { bg = util.darken(c.bg_highlight, 0.8), fg = c.blue100 },
    BufferTabpages = { bg = c.bg_statusline, fg = c.none },

    -- Sneak
    Sneak = { fg = c.bg_highlight, bg = c.magenta },
    SneakScope = { bg = c.base03 },

    -- Hop
    HopNextKey = { fg = c.magenta100, bold = true },
    HopNextKey1 = { fg = c.blue100, bold = true },
    HopNextKey2 = { fg = c.magenta100 },
    HopUnmatched = { fg = c.base01 },

    TSNodeKey = { fg = c.magenta100, bold = true },
    TSNodeUnmatched = { fg = c.base01 },

    LeapMatch = { bg = c.magenta100, fg = c.fg, bold = true },
    LeapLabelPrimary = { fg = c.magenta100, bold = true },
    LeapLabelSecondary = { fg = c.cyan, bold = true },
    LeapBackdrop = { fg = c.base01 },

    FlashBackdrop = { fg = c.base01 },
    FlashLabel = { bg = c.magenta100, bold = true, fg = c.bg },

    LightspeedGreyWash = { fg = c.base01 },
    -- LightspeedCursor = { link = "Cursor" },
    LightspeedLabel = { fg = c.magenta100, bold = true, underline = true },
    LightspeedLabelDistant = { fg = c.cyan, bold = true, underline = true },
    LightspeedLabelDistantOverlapped = { fg = c.cyan100, underline = true },
    LightspeedLabelOverlapped = { fg = c.magenta100, underline = true },
    LightspeedMaskedChar = { fg = c.pink },
    LightspeedOneCharMatch = { bg = c.magenta100, fg = c.fg, bold = true },
    LightspeedPendingOpArea = { bg = c.magenta100, fg = c.fg },
    LightspeedShortcut = { bg = c.magenta100, fg = c.fg, bold = true, underline = true },
    -- LightspeedShortcutOverlapped = { link = "LightspeedShortcut" },
    -- LightspeedUniqueChar = { link = "LightspeedUnlabeledMatch" },
    LightspeedUnlabeledMatch = { fg = c.blue100, bold = true },

    -- Cmp
    CmpDocumentation = { fg = c.fg, bg = c.bg_float },
    CmpDocumentationBorder = { fg = c.base02, bg = c.bg_float },
    CmpGhostText = { fg = c.base01 },

    CmpItemAbbr = { fg = c.fg, bg = c.none },
    CmpItemAbbrDeprecated = { fg = c.base01, bg = c.none, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.blue100, bg = c.none },
    CmpItemAbbrMatchFuzzy = { fg = c.blue100, bg = c.none },

    CmpItemMenu = { fg = c.base01, bg = c.none },

    CmpItemKindDefault = { fg = c.base01, bg = c.none },

    CmpItemKindCodeium = { fg = c.cyan100, bg = c.none },
    CmpItemKindCopilot = { fg = c.cyan100, bg = c.none },
    CmpItemKindTabNine = { fg = c.cyan100, bg = c.none },

    CmpItemKindKeyword = { fg = c.cyan, bg = c.none },
    CmpItemKindVariable = { fg = c.magenta, bg = c.none },
    CmpItemKindConstant = { fg = c.magenta, bg = c.none },
    CmpItemKindReference = { fg = c.magenta, bg = c.none },
    CmpItemKindValue = { fg = c.magenta, bg = c.none },

    CmpItemKindFunction = { fg = c.blue, bg = c.none },
    CmpItemKindMethod = { fg = c.blue, bg = c.none },
    CmpItemKindConstructor = { fg = c.blue, bg = c.none },

    CmpItemKindClass = { fg = c.pink, bg = c.none },
    CmpItemKindInterface = { fg = c.pink, bg = c.none },
    CmpItemKindStruct = { fg = c.pink, bg = c.none },
    CmpItemKindEvent = { fg = c.pink, bg = c.none },
    CmpItemKindEnum = { fg = c.pink, bg = c.none },
    CmpItemKindUnit = { fg = c.pink, bg = c.none },

    CmpItemKindModule = { fg = c.yellow, bg = c.none },

    CmpItemKindProperty = { fg = c.cyan, bg = c.none },
    CmpItemKindField = { fg = c.cyan, bg = c.none },
    CmpItemKindTypeParameter = { fg = c.cyan, bg = c.none },
    CmpItemKindEnumMember = { fg = c.cyan, bg = c.none },
    CmpItemKindOperator = { fg = c.cyan, bg = c.none },
    CmpItemKindSnippet = { fg = c.blue100, bg = c.none },

    -- navic
    NavicIconsFile = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsModule = { fg = c.yellow, bg = c.bg_statusline },
    NavicIconsNamespace = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsPackage = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsClass = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsMethod = { fg = c.blue, bg = c.bg_statusline },
    NavicIconsProperty = { fg = c.cyan, bg = c.bg_statusline },
    NavicIconsField = { fg = c.cyan, bg = c.bg_statusline },
    NavicIconsConstructor = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsEnum = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsInterface = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsFunction = { fg = c.blue, bg = c.bg_statusline },
    NavicIconsVariable = { fg = c.magenta, bg = c.bg_statusline },
    NavicIconsConstant = { fg = c.magenta, bg = c.bg_statusline },
    NavicIconsString = { fg = c.red100, bg = c.bg_statusline },
    NavicIconsNumber = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsBoolean = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsArray = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsObject = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsKey = { fg = c.blue100, bg = c.bg_statusline },
    NavicIconsKeyword = { fg = c.blue100, bg = c.bg_statusline },
    NavicIconsNull = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsEnumMember = { fg = c.cyan, bg = c.bg_statusline },
    NavicIconsStruct = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsEvent = { fg = c.pink, bg = c.bg_statusline },
    NavicIconsOperator = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsTypeParameter = { fg = c.cyan, bg = c.bg_statusline },
    NavicText = { fg = c.fg, bg = c.bg_statusline },
    NavicSeparator = { fg = c.fg, bg = c.bg_statusline },

    IblIndent = { fg = c.base01, nocombine = true },
    IndentBlanklineChar = { fg = c.base01, nocombine = true },
    IndentBlanklineContextChar = { fg = c.blue100, nocombine = true },

    -- Scrollbar
    ScrollbarHandle = { fg = c.none, bg = c.bg_highlight },

    ScrollbarSearchHandle = { fg = c.pink, bg = c.bg_highlight },
    ScrollbarSearch = { fg = c.pink, bg = c.none },

    ScrollbarErrorHandle = { fg = c.error, bg = c.bg_highlight },
    ScrollbarError = { fg = c.error, bg = c.none },

    ScrollbarWarnHandle = { fg = c.warning, bg = c.bg_highlight },
    ScrollbarWarn = { fg = c.warning, bg = c.none },

    ScrollbarInfoHandle = { fg = c.info, bg = c.bg_highlight },
    ScrollbarInfo = { fg = c.info, bg = c.none },

    ScrollbarHintHandle = { fg = c.hint, bg = c.bg_highlight },
    ScrollbarHint = { fg = c.hint, bg = c.none },

    ScrollbarMiscHandle = { fg = c.blue100, bg = c.bg_highlight },
    ScrollbarMisc = { fg = c.blue100, bg = c.none },

    -- Yanky
    YankyPut = { link = "IncSearch" },
    YankyYanked = { link = "IncSearch" },

    -- Lazy
    LazyProgressDone = { bold = true, fg = c.magenta100 },
    LazyProgressTodo = { bold = true, fg = c.base01 },

    -- Notify
    NotifyBackground = { fg = c.fg, bg = c.bg },
    --- Border
    NotifyERRORBorder = { fg = util.darken(c.error, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyWARNBorder = { fg = util.darken(c.warning, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyINFOBorder = { fg = util.darken(c.info, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBorder = { fg = util.darken(c.base01, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyTRACEBorder = { fg = util.darken(c.blue100, 0.3), bg = options.transparent and c.none or c.bg },
    --- Icons
    NotifyERRORIcon = { fg = c.error },
    NotifyWARNIcon = { fg = c.warning },
    NotifyINFOIcon = { fg = c.info },
    NotifyDEBUGIcon = { fg = c.base01 },
    NotifyTRACEIcon = { fg = c.blue100 },
    --- Title
    NotifyERRORTitle = { fg = c.error },
    NotifyWARNTitle = { fg = c.warning },
    NotifyINFOTitle = { fg = c.info },
    NotifyDEBUGTitle = { fg = c.base01 },
    NotifyTRACETitle = { fg = c.blue100 },
    --- Body
    NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

    -- Mini
    MiniAnimateCursor = { reverse = true, nocombine = true },
    MiniAnimateNormalFloat = { link = "NormalFloat" },

    MiniClueBorder = { link = "FloatBorder" },
    MiniClueDescGroup = { link = "DiagnosticFloatingWarn" },
    MiniClueDescSingle = { link = "NormalFloat" },
    MiniClueNextKey = { link = "DiagnosticFloatingHint" },
    MiniClueNextKeyWithPostkeys = { link = "DiagnosticFloatingError" },
    MiniClueSeparator = { link = "DiagnosticFloatingInfo" },
    MiniClueTitle = { link = "FloatTitle" },

    MiniCompletionActiveParameter = { link = 'LspSignatureActiveParameter' },

    MiniCursorword = { underline = true },
    MiniCursorwordCurrent = { underline = true },

    MiniDepsChangeAdded = { link = "diffAdded" },
    MiniDepsChangeRemoved = { link = "diffRemoved" },
    MiniDepsHint = { link = "DiagnosticHint" },
    MiniDepsInfo = { link = "DiagnosticInfo" },
    MiniDepsMsgBreaking = { link = "DiagnosticWarn" },
    MiniDepsPlaceholder = { link = "Comment" },
    MiniDepsTitle = { link = "Title" },
    MiniDepsTitleError = { link = "DiffDelete" },
    MiniDepsTitleSame = { link = "DiffText" },
    MiniDepsTitleUpdate = { link = "DiffAdd" },

    MiniDiffOverAdd = { link = "DiffAdd" },
    MiniDiffOverChange = { link = "DiffText" },
    MiniDiffOverContext = { link = "DiffChange" },
    MiniDiffOverDelete = { link = "DiffDelete" },
    MiniDiffSignAdd = { fg = c.gitGreen },
    MiniDiffSignChange = { fg = c.gitOrange },
    MiniDiffSignDelete = { fg = c.red500 },

    MiniFilesBorder = { link = "FloatBorder" },
    MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" },
    MiniFilesCursorLine = { link = "CursorLine" },
    MiniFilesDirectory = { link = "Directory" },
    MiniFilesFile = { fg = c.fg },
    MiniFilesNormal = { link = "NormalFloat" },
    MiniFilesTitle = { link = "FloatTitle" },
    MiniFilesTitleFocused = { fg = c.hint, bg = c.bg_float },

    MiniHipatternsFixme = { fg = c.bg, bg = c.error, bold = true },
    MiniHipatternsHack = { fg = c.bg, bg = c.warning, bold = true },
    MiniHipatternsNote = { fg = c.bg, bg = c.info, bold = true },
    MiniHipatternsTodo = { fg = c.bg, bg = c.hint, bold = true },

    MiniIconsAzure = { fg = c.blue100 },
    MiniIconsBlue = { fg = c.blue },
    MiniIconsCyan = { fg = c.cyan },
    MiniIconsGreen = { fg = c.green },
    MiniIconsGrey = { fg = c.lgtbase01 },
    MiniIconsOrange = { fg = c.pink },
    MiniIconsPurple = { fg = c.blue100 },
    MiniIconsRed = { fg = c.red },
    MiniIconsYellow = { fg = c.yellow },

    MiniIndentscopeSymbol = { fg = c.magenta100, nocombine = true },
    MiniIndentscopeSymbolOff = { fg = c.warning, nocombine = true },

    MiniJump = { bg = c.magenta100, fg = c.lgtbase01 },

    MiniJump2dDim = { fg = c.base01 },
    MiniJump2dSpot = { fg = c.magenta100, bold = true, nocombine = true },
    MiniJump2dSpotAhead = { fg = c.cyan100, bg = c.black, nocombine = true },
    MiniJump2dSpotUnique = { fg = c.gitOrange, bold = true, nocombine = true },

    MiniMapNormal = { link = "NormalFloat" },
    MiniMapSymbolCount = { link = "Special" },
    MiniMapSymbolLine = { link = "Title" },
    MiniMapSymbolView = { link = "Delimiter" },

    MiniNotifyBorder = { link = "FloatBorder" },
    MiniNotifyNormal = { link = "NormalFloat" },
    MiniNotifyTitle = { link = "FloatTitle" },

    MiniOperatorsExchangeFrom = { link = "IncSearch" },

    MiniPickBorder = { link = "FloatBorder" },
    MiniPickBorderBusy = { link = "DiagnosticFloatingWarn" },
    MiniPickBorderText = { link = "FloatTitle" },
    MiniPickHeader = { link = "DiagnosticFloatingHint" },
    MiniPickIconDirectory = { link = "Directory" },
    MiniPickIconFile = { link = "MiniPickNormal" },
    MiniPickMatchCurrent = { link = "CursorLine" },
    MiniPickMatchMarked = { link = "Visual" },
    MiniPickMatchRanges = { link = "DiagnosticFloatingHint" },
    MiniPickNormal = { link = "NormalFloat" },
    MiniPickPreviewLine = { link = "CursorLine" },
    MiniPickPreviewRegion = { link = "IncSearch" },
    MiniPickPrompt = { link = "DiagnosticFloatingInfo" },

    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { fg = c.yellow, italic = true },
    MiniStarterHeader = { fg = c.blue },
    MiniStarterInactive = { fg = c.base01, style = options.styles.comments },
    MiniStarterItem = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    MiniStarterItemBullet = { fg = c.base01 },
    MiniStarterItemPrefix = { fg = c.warning },
    MiniStarterSection = { fg = c.blue100 },
    MiniStarterQuery = { fg = c.info },

    MiniStatuslineDevinfo = { fg = c.base01, bg = c.bg_highlight },
    MiniStatuslineFileinfo = { fg = c.base01, bg = c.bg_highlight },
    MiniStatuslineFilename = { fg = c.base01, bg = c.bg_highlight },
    MiniStatuslineInactive = { fg = c.blue, bg = c.bg_statusline },
    MiniStatuslineModeCommand = { fg = c.black, bg = c.yellow, bold = true },
    MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = true },
    MiniStatuslineModeNormal = { fg = c.black, bg = c.blue, bold = true },
    MiniStatuslineModeOther = { fg = c.black, bg = c.cyan100, bold = true },
    MiniStatuslineModeReplace = { fg = c.black, bg = c.red, bold = true },
    MiniStatuslineModeVisual = { fg = c.black, bg = c.magenta, bold = true },

    MiniSurround = { bg = c.pink, fg = c.black },

    MiniTablineCurrent = { fg = c.fg, bg = c.base02, bold = true },
    MiniTablineFill = { bg = c.black },
    MiniTablineHidden = { fg = c.blue100, bg = c.bg_statusline },
    MiniTablineModifiedCurrent = { fg = c.base02, bg = c.fg, bold = true },
    MiniTablineModifiedHidden = { fg = c.bg_statusline, bg = c.blue100 },
    MiniTablineModifiedVisible = { fg = c.bg_statusline, bg = c.fg },
    MiniTablineTabpagesection = { bg = c.bg_statusline, fg = c.none },
    MiniTablineVisible = { fg = c.fg, bg = c.bg_statusline },

    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = c.red, bold = true },
    MiniTestPass = { fg = c.green, bold = true },

    MiniTrailspace = { bg = c.red },

    -- Noice

    NoiceCompletionItemKindDefault = { fg = c.base01, bg = c.none },

    TreesitterContext = { bg = c.base01 },
    Hlargs = { fg = c.yellow },
  }

  if not vim.diagnostic then
    local severity_map = {
      Error = "Error",
      Warn = "Warning",
      Info = "Information",
      Hint = "Hint",
    }
    local types = { "Default", "VirtualText", "Underline" }
    for _, type in ipairs(types) do
      for snew, sold in pairs(severity_map) do
        theme.highlights["LspDiagnostics" .. type .. sold] = {
          link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
        }
      end
    end
  end

  ---@type table<string, table>
  theme.defer = {}

  if options.hide_inactive_statusline then
    local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.border }

    -- StatusLineNC
    theme.highlights.StatusLineNC = inactive

    -- LuaLine
    for _, section in ipairs({ "a", "b", "c" }) do
      theme.defer["lualine_" .. section .. "_inactive"] = inactive
    end

    -- mini.statusline
    theme.highlights.MiniStatuslineInactive = inactive
  end

  options.on_highlights(theme.highlights, theme.colors)

  if config.is_day() then
    util.invert_colors(theme.colors)
    util.invert_highlights(theme.highlights)
  end

  return theme
end

return M
