return {
  -- LSPSAGA
  -- general
  TitleString = { link = "Title" },
  TitleIcon = { link = "Repeat" },
  SagaBorder = { link = "FloatBorder" },
  SagaNormal = { bg = "bg" },
  SagaExpand = { fg = "light_grey" },
  SagaCollapse = { fg = "light_grey" },
  SagaCount = { link = "Comment" },
  SagaBeacon = { bg = "red" },
  -- code action
  ActionFix = { link = "Keyword" },
  ActionPreviewNormal = { link = "SagaNormal" },
  ActionPreviewBorder = { fg = "red" },
  ActionPreviewTitle = { fg = "red" },
  CodeActionNormal = { link = "SagaNormal" },
  CodeActionBorder = { fg = "red" },
  CodeActionText = { link = "@variable" },
  CodeActionNumber = { link = "DiffAdd" },
  -- finder
  FinderSelection = { link = "String" },
  FinderFName = {},
  FinderCode = { link = "Comment" },
  FinderCount = { link = "Constant" },
  FinderIcon = { link = "Type" },
  FinderType = { link = "@property" },
  FinderStart = { link = "Function" },
  --finder spinner
  FinderSpinnerTitle = { fg = "purple" },
  FinderSpinner = { link = "Statement" },
  FinderPreview = { link = "Search" },
  FinderLines = { link = "Operator" },
  FinderNormal = { link = "SagaNormal" },
  FinderBorder = { fg = "purple" },
  FinderPreviewBorder = { link = "SagaBorder" },
  -- definition
  DefinitionBorder = { fg = "vibrant_green" },
  DefinitionNormal = { link = "SagaNormal" },
  DefinitionSearch = { link = "Search" },
  -- hover
  HoverNormal = { link = "SagaNormal" },
  HoverBorder = { link = "SagaBorder" },
  -- rename
  RenameBorder = { fg = "dark_purple" },
  RenameNormal = { link = "Statement" },
  RenameMatch = { link = "Search" },
  -- diagnostic
  DiagnosticBorder = { fg = "orange" },
  DiagnosticSource = { link = "Comment" },
  DiagnosticNormal = { link = "SagaNormal" },
  DiagnosticText = {},
  DiagnosticBufnr = { link = "@variable" },
  DiagnosticFname = { link = "KeyWord" },
  DiagnosticShowNormal = { link = "SagaNormal" },
  DiagnosticShowBorder = { link = "@property" },
  -- Call Hierachry
  CallHierarchyNormal = { link = "SagaNormal" },
  CallHierarchyBorder = { fg = "yellow" },
  CallHierarchyIcon = { link = "TitleIcon" },
  CallHierarchyTitle = { fg = "yellow" },
  -- lightbulb
  SagaLightBulb = { link = "DiagnosticSignHint" },
  -- shadow
  SagaShadow = { link = "FloatShadow" },
  -- Outline
  OutlineIndent = { fg = "fg" },
  OutlinePreviewBorder = { link = "SagaNormal" },
  OutlinePreviewNormal = { link = "SagaBorder" },
  OutlineWinSeparator = { link = "WinSeparator" },
  -- Float term
  TerminalBorder = { fg = "cyan" },
  TerminalNormal = { link = "SagaNormal" },
}
