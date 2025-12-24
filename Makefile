BASE_HREF = '/'
GITHUB_REPO = 'git@github.com:TechnicalMeaw/Portfolio_Website.git'
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')
CUSTOM_DOMAIN = santanumukherjee.com

deploy-web:
	@echo "Cleaning existing repository..."
	flutter clean

	@echo "Getting packages..."
	flutter pub get


	flutter build web --base-href $(BASE_HREF) --web-renderer html --release

	@echo "Creating CNAME file..."
	echo "$(CUSTOM_DOMAIN)" > build/web/CNAME

	@echo "Deploying to git repository"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deployment v$(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u --force origin main

	cd ../..
	@echo "|,.'`` Finished Deployment"

.PHONY: deploy-web