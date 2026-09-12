# Imersão Estrutura 5A · Grupo 2!H

Landing page da Imersão Estrutura 5A (Grupo 2!H).

## Estrutura do repositório

- **`index.html`** — a landing page, pronta para produção. HTML estático com CSS e JavaScript embutidos, sem dependências externas além das fontes (Fontshare e Google Fonts).
- **`assets/`** — logos, ícones e imagens usados pela página. Os criativos do hero são servidos em JPEG otimizado (`hero-creative-*.jpg`, `hero-creative-mobile-*.jpg`); os PNG originais ficam guardados como fonte.
- **`wireframes.html`** — versão de wireframes das páginas completas, mantida como referência. Depende de `support.js` / `image-slot.js` (runtime do Claude Design), que só existem por causa dela.
- **`design/`** — material de apoio do processo de design (handoff original, transcrição de chat, uploads brutos). Não é necessário para hospedar o site.

## Hospedagem

Este site é 100% estático — não tem passo de build. Basta servir `index.html` e `assets/` em qualquer host estático:

- **GitHub Pages**: Settings → Pages → Deploy from branch (`main`, pasta `/`).
- **Netlify / Vercel / Cloudflare Pages**: conectar o repositório, sem comando de build, diretório de publicação = raiz.
- **Qualquer servidor estático**: copiar os arquivos acima para o document root.

Depois é só apontar o domínio desejado para o host escolhido.

## Editar a página

Todo o conteúdo está em `index.html`: o CSS no `<style>` do `<head>`, o HTML das seções no `<body>` e o comportamento (funil, cards empilhados, FAQ, trilha lateral) no `<script>` no final do arquivo.
