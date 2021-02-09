autocmd vimenter * colorscheme gruvbox 

hi! link LspDiagnosticsError GruvboxRed 
hi! link LspDiagnosticsErrorFloating GruvboxRed 

hi! link LspDiagnosticsHint GruvboxBlue
hi! link LspDiagnosticsHintFloating GruvboxBlue

hi! link LspDiagnosticsInformation GruvboxYellow
hi! link LspDiagnosticsInformationFloating GruvboxYellow

hi! link LspDiagnosticsSignError GruvboxRedSign
hi! link LspDiagnosticsSignHint GruvboxBlueSign

hi! link LspDiagnosticsSignInformation GruvboxYellowSign
hi! link LspDiagnosticsSignWarning GruvboxOrangeSign

hi! link LspDiagnosticsWarning GruvboxOrange
hi! link LspDiagnosticsWarningFloating GruvboxOrange

hi! link LspDiagnosticsDefaultError GruvboxRed
hi! link LspDiagnosticsDefaultWarning GruvboxYellow
hi! link LspDiagnosticsDefaultInformation GruvboxBlue
hi! link LspDiagnosticsDefaultHint GruvboxBlue

hi! link LspDiagnosticsUnderlineError GruvboxRed
hi! link LspDiagnosticsUnderlineWarning GruvboxYellow
hi! link LspDiagnosticsUnderlineInformation GruvboxBlue
hi! link LspDiagnosticsUnderlineHint GruvboxBlue

sign define LspDiagnosticsSignError text=  linehl= texthl=LspDiagnosticsSignError numhl=
sign define LspDiagnosticsSignHint text=  linehl= texthl=LspDiagnosticsSignHint numhl=
sign define LspDiagnosticsSignInformation text=  linehl= texthl=LspDiagnosticsSignInformation numhl=
sign define LspDiagnosticsSignWarning text=  linehl= texthl=LspDiagnosticsSignWarning numhl=

set termguicolors
