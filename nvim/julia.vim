" This file must be in .config/nvim/after/syntax
syntax cluster  juliaParScope           contains=@juliaParItems,juliaParBlockInRange
syntax cluster  juliaBlockScope         contains=@juliaBlocksItems,juliaConditionalEIBlock,juliaConditionalEBlock
syntax cluster  juliaTotalScope         contains=@juliaParScope,@juliaMacroItems,@juliaBlockScope
syntax match    juliaFunction           display "\<[a-z_][a-zA-Z0-9_]*\>!\?\.\?("me=e-1 containedin=@juliaTotalScope
hi def link     juliaFunction           Function
