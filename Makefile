#-----------------------------------------------------------------------------#
#
# Greetings!
#
# This Makefile was generated by the Python package package package. If
# you don't know what that means, that's OK. This Makefile is mostly for
# the author of this package. If you are not the author you can ignore
# this file, or you can use it to call the setup.py commands that you
# are used to:
#
# * make build
# * make test
# * sudo make install
#
# If you are the module author, you can run `make help` to see all the
# commands that are available to you.
#
# This Makefile currently assumes that if you are the package author, that you
# are on some kind of Unix based system (or else you are kinda nuts, and
# probably shouldn't be using this thing in the first place! :)
#
# For more information on the package package package package, visit the
# Python Package Index here:
#
#     http://pypi.python.org/pypi/package/
#
# Cheers!
#
#-----------------------------------------------------------------------------#

.PHONY: \
    default \
    help \
    setup \
    package-info \
    build \
    test \
    devtest \
    install \
    register \
    sdist \
    clean \
    upload \
    run \
 

# This variable is hardcoded into the Makefile by initial setup.
# If you move package-py, you need to change this.
PACKAGE_BASE = $(MAKEFILE_LIST:%/Makefile=%)

PYTHON = python

PACKAGE_FILES = \
	package/__init__.py \
	package/errors.py \

SETUP_TARGETS = \
	Makefile \
	setup.py \
	$(PACKAGE_FILES) \
	package/info.yaml \

UPGRADE_TARGETS = \
	Makefile \
	setup.py \
	$(PACKAGE_FILES) \

ALL_TESTS = $(shell echo tests/*.py)
ALL_DEV_TESTS = $(shell echo dev-tests/*.py)

#-----------------------------------------------------------------------------#
# package-py targets
#-----------------------------------------------------------------------------#
default:
	@echo "This is the Python package package package Makefile."
	@echo
	@echo "Run 'make help' for more information."

help::
	@cat $(PACKAGE_BASE)/HelpMake.txt

package-info::
	$(PYTHON) $(PACKAGE_BASE)/bin/make_package_info.py

# This rule is disabled after initial setup.
setup: package $(SETUP_TARGETS) _fixup _next

unsetup:
	rm -f $(UPGRADE_TARGETS)

upgrade: unsetup $(UPGRADE_TARGETS) _fixup package-info

_fixup::
	$(PYTHON) $(PACKAGE_BASE)/bin/fix_makefile.py "$(PACKAGE_BASE)"

_next::
	@cat $(PACKAGE_BASE)/NextSteps.txt

Makefile $(PACKAGE_FILES) package/info.yaml::
	cp $(PACKAGE_BASE)/$@ $@

setup.py::
	cp $(PACKAGE_BASE)/bin/$@ $@

package::
	mkdir $@


#-----------------------------------------------------------------------------#
# setup.py targets
#-----------------------------------------------------------------------------#
register:: package-info

build test devtest install register sdist clean::
	$(PYTHON) setup.py $@

upload:: clean register
	$(PYTHON) setup.py sdist $@

tests:: $(ALL_TESTS)

$(ALL_TESTS) $(ALL_DEV_TESTS): run
	@$(PYTHON) -c 'print " Running test: $@ ".center(70, "-") + "\n"'
	@PYTHONPATH=. $(PYTHON) $@

clean::
	find . -name '*.pyc' | xargs rm
	rm -fr build dist MANIFEST *.egg-info
