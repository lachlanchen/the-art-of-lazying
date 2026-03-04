# meta.lazying.art site

Static website files for the `meta.lazying.art` subdomain.

## Files
- `index.html`
- `styles.css`
- `app.js`

## Local preview
```bash
cd website/meta-lazying-art
python3 -m http.server 8090
```
Then open `http://localhost:8090`.

## Deploy
Point your web server root for `meta.lazying.art` to this folder.

Example (Nginx):
```nginx
server {
    server_name meta.lazying.art;
    root /path/to/the-art-of-lazying/website/meta-lazying-art;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

## GitHub Pages workflow
This repo includes:
- `.github/workflows/meta-lazying-art-pages.yml`
- `website/meta-lazying-art/CNAME`

What to do once:
1. In GitHub repo settings, open `Pages`.
2. Set `Source` to `GitHub Actions`.
3. Push changes to `main` under `website/meta-lazying-art/`.

The workflow deploys this folder to Pages and applies `meta.lazying.art` as custom domain.
