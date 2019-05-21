"syn keyword phpIfSingleEqual if nextgroup=phpSingleEqualCondition skipwhite containedin=phpRegion
syn keyword phpIfSingleEqual if nextgroup=phpSingleEqualCondition skipwhite contained 
syn match phpSingleEqualCondition /(\s*\$\S\+\s\+=\s\+.*)/ contained
syn cluster phpClConst add=phpIfSingleEqual
hi link phpIfSingleEqual phpConditional
hi link phpSingleEqualCondition Error
