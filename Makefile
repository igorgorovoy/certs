.PHONY: build

build:
	@cd frontend && npm run build:prod
	@echo "[✔️] Frontend build complete!"

certbot-test:
	@chmod +x ./register_ssl.sh
	@sudo ./register_ssl.sh \
								--domains "$(DOMAINS)" \
								--email $(EMAIL) \
								--data-path ./webserver/certbot \
								--staging 1

certbot-prod:
	@chmod +x ./register_ssl.sh
	@sudo ./register_ssl.sh \
								--domains "$(DOMAINS)" \
								--email $(EMAIL) \
								--data-path ./webserver/certbot \
								--staging 0

deploy-test:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					up --build --force-recreate

deploy-prod:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					up -d --build --force-recreate
