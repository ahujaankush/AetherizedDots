while read file
do 
  source "$ZDOTDIR/$file.zsh"
done <<-EOF
theme
env
alias
utils
opts
plugs
keys
prompt
EOF

for fun in ${(ok)functions[(I)[_][_][_][_][_]*]}; do 
  eval "alias ${${fun:5}//_/-}=\"${fun}\""
done

# cfetch
default_greeter

# vim:ft=zsh:nowrap
