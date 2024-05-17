# Tạo file env nếu chưa có
ifeq ($(wildcard .env),)
	cp .env.example .env
endif

# Tải cấu hình env
ifneq ($(wildcard .env),)
	include .env
endif

COMPOSER_OPTIONS_INSTALL?=

ifneq ($(APP_ENV), local)
	COMPOSER_OPTIONS_INSTALL=--no-dev
endif

# Cấu hình project nhanh
.PHONY: setup
setup:
	# install dependencies with $(APP_ENV)
	composer install $(COMPOSER_OPTIONS_INSTALL)

ifeq ($(FILESYSTEM_DISK), local)
	php artisan storage:link --force
endif

ifeq ($(APP_KEY),)
	php artisan key:generate
endif

	php artisan migrate --force

# Kiểm tra các file xem đã đúng format chưa
.PHONNY: check
check:
	./vendor/bin/pint --test -v

# Format code
.PHONNY: fix
fix:
	./vendor/bin/pint -v

# Chạy nhanh test
.PHONY: test
test:
	php artisan test

.PHONY: migrate
migrate:
	php artisan migrate --force

.PHONY: seed
seed:
	php artisan db:seed --force

.PHONY: phpstan
phpstan:
	./vendor/bin/phpstan analyse

.PHONY: s3
s3:
	# https://laravel.com/docs/11.x/filesystem#driver-prerequisites
	composer require league/flysystem-aws-s3-v3 league/flysystem-path-prefixing
