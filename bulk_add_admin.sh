#!/bin/bash

: '
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/

Copyright 2019 J.D. Bean
'

function git_repo_addadmin(){ 
  echo $1
  curl -vL \
  	-u "$2:${GITHUB_SECRET}" \
    -H "Content-Type: application/json" \
    -H "Accept: application/vnd.github.v3+json" \
    -X PUT https://api.github.com/repos/$1/collaborators/$3 \
    -d '{"permission":"admin"}' \
    | jq .
}

repos=$( cat ./repos.txt) 
for repo in $repos; do (git_repo_addadmin "$repo" "$1" "$2"); done

