DEPLOY_DIR=deno run --allow-read=. --allow-write=. https://deno.land/x/deploy_dir@v0.3.2/cli.ts

.PHONY: dev 
dev:
	npm start

.PHONY: dist
dist:
	npm run dist
	$(DEPLOY_DIR) docs -o deploy.js -y

.PHONY: deploy
deploy:
	$(DEPLOY_DIR) docs -o deploy.js -y
