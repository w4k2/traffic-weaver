.PHONY: all install clean

clean:
	rm -rf docs/build
	rm -rf dist
	rm -f .coverage

prepare:
	pip install pip-tools
	pip-compile -o requirements.txt pyproject.toml
	pip-compile --extra dev -o dev-requirements.txt pyproject.toml

install: clean
	pip-sync requirements.txt dev-requirements.txt

tag-release:
	commit-and-tag-version

tag-prerelease:
	commit-and-tag-version --prerelease alpha

upload: clean
	python -m build
	twine upload dist/*

docs: clean
	cd docs && make html

test:
	pytest

test-coverage:
	pytest --cov=traffic_weaver

