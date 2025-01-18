#!/usr/bin/env zsh

title=$(hyprctl -j clients | jq -r '.[] | select(.focusHistoryID==1) | .title')
initial_title=$(hyprctl -j clients | jq -r '.[] | select(.focusHistoryID==1) | .initialTitle')


function makeEntry {
  echo "${(r(30)( ))1}${(r(30)( ))2}"
}

function makeRow {
  echo "\n$(makeEntry $1 $2)$(makeEntry $3 $4)"
}

function readCheatsheet {
  rows=""
  columns=4
  array=()
  first=true
  while IFS=, read -r col1 col2
  do
    if [[ $first = true ]]
    then
      while [[ ${#array} -lt $columns ]]
      do
        array+=$col1
        array+=$col2
      done
    fi
    if [[ ${#array} -lt $columns ]]
    then
      array+=$col1
      array+=$col2
    else
      rows+=$(makeRow $array)
      if [[ $first = true ]]
      then
        first=false
        rows+="\n${(r(120)(-))$("")}"
        rows+="\n"
      fi
      array=()
    fi
  done < $HOME/cheatsheets/$1.csv
  if [[ ${#array} -gt 0 ]]
  then
    rows+=$(makeRow $array)
  fi
  echo "$rows"
}

# output=$(cowsay "Cheatsheet for "$initial_title)
output=$(echo "Cheatsheet for "$initial_title)
output+="\n\n"
case "$initial_title" in
  Mozilla\ Firefox)
    var="wiki"
    output+="\n\n"
    output+=${(r(15)( ))var}
    output+="wikipedia search"
    ;;
  kitty)
    output+=$(readCheatsheet "kitty")
    ;;
  *)
    output+="\nno elp for $title"
    ;;
esac

echo "$output" | nvim +Man!

