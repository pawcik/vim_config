"to auto discover clearcase confiog spec fiel
au! BufRead,BufNewFile /var/tmp/tmp[0-9]* if $CLEARCASE_CMDLINE =~ "^edcs" | set filetype=cccs | endif
