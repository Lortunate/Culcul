.PHONY: analyze test test-coverage format format-check codegen i18n all ci clean

analyze:
	flutter analyze --no-fatal-infos

test:
	flutter test

test-coverage:
	flutter test --coverage
	@echo "Coverage report: coverage/lcov.info"

format:
	dart format .

format-check:
	dart format --output=none --set-exit-if-changed .

codegen:
	dart run build_runner build --delete-conflicting-outputs

i18n:
	dart run slang

all: analyze test

ci: format-check analyze test

clean:
	flutter clean
	flutter pub get
