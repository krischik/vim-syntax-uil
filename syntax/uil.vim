" Vim syntax file
" Language:	Motif UIL (User Interface Language)
" Maintainer:	Thomas Koehler <jean-luc@picard.franken.de>
" Last Change:	2022 Sep 25
" URL:		http://jeanluc-picard.de/vim/syntax/uil.vim

" Quit when a syntax file was already loaded
if version < 600
   syntax clear
elseif exists("b:current_syntax")
  finish
endif

" A bunch of useful keywords
syn keyword uilType	arguments	callbacks	color       
syn keyword uilType	compound_string	controls	end
syn keyword uilType	exported	file		include
syn keyword uilType	module		object		procedure value
syn keyword uilType	user_defined	xbitmapfile     list

syn keyword uilOperator	unmanaged gadget

syn keyword uilTodo contained	TODO

" String and Character contstants
" Highlight special characters (those which have a backslash) differently
syn match   uilSpecial contained "\\\d\d\d\|\\."
syn region  uilString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=uilSpecial
syn match   uilCharacter	"'[^\\]'"
syn region  uilString		start=+'+  skip=+\\\\\|\\"+  end=+'+  contains=uilSpecial
syn match   uilSpecialCharacter	"'\\.'"
syn match   uilSpecialStatement	"Xm[^ =(){}]*"
syn match   uilSpecialFunction	"MrmNcreateCallback"
syn match   uilRessource	"XmN[^ =(){}]*"

syn match  uilNumber		"-\=\<\d*\.\=\d\+\(e\=f\=\|[uU]\=[lL]\=\)\>"
syn match  uilNumber		"0[xX][0-9a-fA-F]\+\>"

syn region uilComment		start="/\*"  end="\*/" contains=uilTodo
syn match  uilComment		"!.*" contains=uilTodo
syn match  uilCommentError	"\*/"

syn region uilPreCondit		start="^#\s*\(if\>\|ifdef\>\|ifndef\>\|elif\>\|else\>\|endif\>\)"  skip="\\$"  end="$" contains=uilComment,uilString,uilCharacter,uilNumber,uilCommentError
syn match  uilIncluded contained "<[^>]*>"
syn match  uilInclude		"^#\s*include\s\+." contains=uilString,uilIncluded
syn match  uilLineSkip		"\\$"
syn region uilDefine		start="^#\s*\(define\>\|undef\>\)" end="$" contains=uilLineSkip,uilComment,uilString,uilCharacter,uilNumber,uilCommentError

syn sync ccomment uilComment

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_uil_syn_inits")
  if version < 508
    let did_uil_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default highlighting.
  HiLink uilCharacter		uilString
  HiLink uilSpecialCharacter	uilSpecial
  HiLink uilNumber		uilString
  HiLink uilCommentError	uilError
  HiLink uilInclude		uilPreCondit
  HiLink uilDefine		uilPreCondit
  HiLink uilIncluded		uilString
  HiLink uilSpecialFunction	uilRessource
  HiLink uilRessource		Identifier
  HiLink uilSpecialStatement	Keyword
  HiLink uilError		Error
  HiLink uilPreCondit		PreCondit
  HiLink uilType		Type
  HiLink uilString		String
  HiLink uilComment		Comment
  HiLink uilSpecial		Special
  HiLink uilTodo		Todo
  HiLink uilOperator            Operator

  delcommand HiLink
endif

setlocal commentstring=!\ \ %s
setlocal comments+=:!\ \ 
setlocal formatoptions+=ron

if exists("g:uil_folding")
   setlocal foldmethod=indent
   setlocal foldignore=!
   setlocal tabstop=8
   setlocal softtabstop=4
   setlocal shiftwidth=4
endif


let b:current_syntax = "uil"

" vim: textwidth=78 nowrap tabstop=8 shiftwidth=4 softtabstop=4 expandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
