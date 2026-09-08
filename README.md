# Imersão Estrutura 5A · Grupo 2!H

Landing page da Imersão Estrutura 5A (Grupo 2!H).

## Estrutura do repositório

- **`index.html`** — a landing page, pronta para produção. É o arquivo que qualquer host estático vai servir na raiz do domínio.
- **`wireframes.html`** — versão de wireframes das páginas completas, mantida como referência.
- **`support.js`** / **`image-slot.js`** — runtime que a página usa em tempo de execução (carrega React/ReactDOM via CDN automaticamente, sem build).
- **`assets/`** — logos, ícones e imagens usados pela página.
- **`design/`** — material de apoio do processo de design (handoff original, transcrição de chat, uploads brutos). Não é necessário para hospedar o site.

## Hospedagem

Este site é 100% estático — não tem passo de build. Basta servir os arquivos da raiz deste repositório (`index.html`, `support.js`, `image-slot.js`, `assets/`) em qualquer host estático:

- **GitHub Pages**: Settings → Pages → Deploy from branch (`main`, pasta `/`).
- **Netlify / Vercel / Cloudflare Pages**: conectar o repositório, sem comando de build, diretório de publicação = raiz.
- **Qualquer servidor estático**: copiar os arquivos acima para o document root.

Depois é só apontar o domínio desejado para o host escolhido.

## Editar a página

O arquivo `index.html` é um `.dc.html` (formato do Claude Design). Pode ser editado como HTML puro — os blocos `<x-dc>` / `data-dc-script` são interpretados em tempo de execução pelo `support.js`.
