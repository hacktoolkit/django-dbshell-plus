.PHONY: clean-pyc clean-build docs clean

## help - Display help about make targets for this Makefile
help:
	@cat Makefile | grep '^## ' --color=never | cut -c4- | sed -e "`printf 's/ - /\t- /;'`" | column -s "`printf '\t'`" -t

## clean - remove all build, test, coverage and Python artifacts
clean: clean-build clean-pyc clean-docs
	rm -fr htmlcov/

## clean-build - remove build artifacts
clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

## clean-pyc - remove Python file artifacts
clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

## clean-docs - remove generated docs
clean-docs:
	rm -f docs/django_dbshell_plus*.rst

## coverage - check code coverage quickly with the default Python
coverage:

## lint - check style with flake8
lint:
	flake8 lib/django_dbshell_plus

## docs - generate Sphinx HTML documentation, including API docs
docs:
	tox -e docs

## dist - package
dist: clean
	python setup.py sdist
	python setup.py bdist_wheel
	python setup.py bdist_egg
	ls -l dist

## release - package and upload a release
release: dist
	sh -c "twine upload dist/*.whl dist/*.tar.gz --verbose"
