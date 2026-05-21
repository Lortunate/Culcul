.PHONY: analyze test test-coverage format format-check codegen i18n architecture all ci clean

analyze:
	flutter analyze --no-fatal-infos

test:
	flutter test

test-coverage:
	flutter test --coverage
	@echo "Coverage report: coverage/lcov.info"

architecture:
	bash tool/architecture/run_architecture_guards.sh

format:
	bash tool/format_dart.sh

format-check:
	bash tool/format_dart.sh --check

codegen:
	dart run build_runner build --delete-conflicting-outputs

i18n:
	dart run slang

all: analyze test

ci: format-check analyze architecture test

clean:
	flutter clean
	flutter pub get
