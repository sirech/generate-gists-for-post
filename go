#!/usr/bin/env bash
set -e -o pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd -P)

goal_linter() {
  bundle exec rubocop
}

goal_test() {
  bundle exec rspec spec
}

validate-args() {
  acceptable_args="$(declare -F | sed -n "s/declare -f goal_//p" | tr '\n' ' ')"

  if [[ -z $1 ]]; then
    echo "usage: $0 <goal>"
    # shellcheck disable=SC2059
    printf "\n$(declare -F | sed -n "s/declare -f goal_/ - /p")"
    exit 1
  fi

  if [[ ! " $acceptable_args " =~ .*\ $1\ .* ]]; then
    echo "Invalid argument: $1"
    # shellcheck disable=SC2059
    printf "\n$(declare -F | sed -n "s/declare -f goal_/ - /p")"
    exit 1
  fi
}

CMD=${1:-}
shift || true
if validate-args "${CMD}"; then
  "goal_${CMD}"
  exit 0
fi