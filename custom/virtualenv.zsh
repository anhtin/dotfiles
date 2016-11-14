# export PIP_REQUIRE_VIRTUALENV=true        # PIP only in python virtual environment
export WORKON_HOME=${HOME}/.virtualenvs     # Virtualenvwrapper

source /usr/local/bin/virtualenvwrapper.sh

# pyenv shims and autocompletion
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Functions
# Run pip globally
# gpip() {
#     PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
# }
