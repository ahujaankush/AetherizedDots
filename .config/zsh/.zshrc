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
keys_vi
prompt
EOF

for fun in ${(ok)functions[(I)[_][_][_][_][_]*]}; do 
  eval "alias ${${fun:5}//_/-}=\"${fun}\""
done

# cfetch
default_greeter
source $HOME/.profile
# vim:ft=zsh:nowrap
