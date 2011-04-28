" Vim syntax file
" file type: log files
" Quit when a (custom) syntax file was already loaded
syn clear
if exists("b:current_syntax")
  finish
endif

syn case match

syn match fatal         /.* FATAL .*/
syn match fatal /^FATAL: .*/
syn match error ".* ERROR .*"
syn match error "^ERROR: .*"
syn match warn /.* WARN .*/
syn region braces start="\[" matchgroup="Thread" end="\]" skip="\]"
syn match timestamp /^\[.*\]/


"hi link fatal String
hi link warn Function

hi link warn Label
"hi link timestamp Number

let b:current_syntax = "log"
