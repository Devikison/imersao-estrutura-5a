# Imersão Estrutura 5A · Grupo 2!H

Landing page de venda da **Imersão Estrutura 5A** (Grupo 2!H): imersão online e ao vivo de 4 horas, 10 de outubro, R$ 27.

- **Site no ar:** https://imersao5a.sitepreviavisual.site/ (GitHub Pages, domínio no arquivo `CNAME`)
- **Repositório:** https://github.com/Devikison/imersao-estrutura-5a (branch `main`)
- **Publicação:** todo `git push` na `main` vai ao ar em cerca de 30 a 60 segundos. Confira com Ctrl+F5 ou aba anônima.

> **Para o assistente de código (Claude Code ou similar):** leia este README inteiro e o `index.html` inteiro antes de qualquer alteração. Siga os padrões da seção "Regras aprovadas pelo cliente". Toda mudança deve ser testada no preview local, commitada e enviada com `git push origin main`.

---

## 1. Estrutura do repositório

| Caminho | O que é |
|---|---|
| `index.html` | **A landing page inteira.** HTML estático com CSS no `<style>` do `<head>` e JavaScript no `<script>` no fim do `<body>`. Sem build, sem framework e **sem nenhuma dependência externa** (fontes hospedadas em `assets/fonts`). |
| `assets/` | Logos, ícones, imagens e as fontes (`assets/fonts`: General Sans 400-700 e Inter variável, em woff2, declaradas no `<style>` da página). As capas do hero são servidas em JPEG (`hero-creative-*.jpg`); os PNG (`hero-creative.png`, `hero-creative-mobile.png`) ficam só como arquivo-fonte e **não são carregados pela página**. |
| `tools/serve.ps1` | Servidor local de preview (PowerShell puro, a máquina não tem Python nem Node). |
| `tools/make-hero-jpg.ps1` | Regenera os JPEG do hero a partir dos PNG. Rodar sempre que trocar uma capa. |
| `CNAME` | Domínio do GitHub Pages. Não apagar. |
| `wireframes.html`, `support.js`, `image-slot.js` | Wireframes originais do Claude Design e o runtime que eles precisam. **Não são usados pela `index.html`.** Mantidos só como referência. |
| `design/` | Handoff original, transcrição do chat de design e uploads brutos. Referência, não é servido. |

## 2. Fluxo de trabalho

```powershell
# 1. preview local (na raiz do projeto)
powershell -ExecutionPolicy Bypass -File tools\serve.ps1
# abre http://localhost:8787/

# 2. depois de editar index.html, testar no desktop e no mobile (rolando para baixo e para cima)

# 3. publicar
git add -A
git commit -m "descrição curta da mudança"
git push origin main
```

- A conta GitHub que tem permissão de push é **Devikison**. Se `git push` for recusado, logue com `gh auth login` ou configure as credenciais do git nessa conta.
- Commits feitos pelo assistente terminam com `Co-Authored-By: Claude <noreply@anthropic.com>` (ou o modelo em uso).
- Se trocar uma capa do hero: substitua o PNG em `assets/`, rode `tools\make-hero-jpg.ps1`, confira o preview, commit e push.

## 3. Mapa da página (ordem das seções)

1. **Hero** — criativo com foto (fundo no desktop, imagem inteira 2:3 no mobile), título, subtítulo, botão dourado "Quero garantir minha vaga" e botão vidro "O que você vai enxergar". Ícones flutuantes (Google Ads, Facebook, seta) posicionados por porcentagem, com valores diferentes para desktop e mobile.
2. **Faixa dourada** em marquee com os argumentos rápidos.
3. **A ideia central + Funil** — citação à esquerda, funil animado à direita (SVG + leads em HTML). Leads entram com ícone de canal, parte se perde no meio (fica cinza com X), parte vira moeda que cai no prato de "Receita · Margem". Contadores ao vivo abaixo. Rótulos em maiúsculas (Leads entrando, Atendimento, Comercial, Venda, Receita · Margem) aparecem no desktop e no mobile.
4. **Seis crenças** — fundo creme, cards escuros **empilhados no scroll** (sticky): cada card gruda no topo e o próximo desliza por cima, o de trás encolhe e escurece.
5. **O diagnóstico completo** — 10 etapas (Negócio a Margem), **mesmo empilhamento** dos cards das crenças. No desktop a coluna esquerda mostra "Etapa X de 10" com barra de progresso.
6. **Seis ângulos** — linha do tempo vertical que acende conforme rola. No mobile a linha passa por trás dos ícones. Abaixo, chips dos canais (Meta, Instagram, WhatsApp, Google Ads). Um **divisor de luz** (linha dourada, brilho e feixe correndo) separa esta seção da anterior.
7. **Frases que doem** — seção inteira dourada com pílulas escuras em marquee duplo. O título quebra em duas linhas no desktop ("Frases que você já deveria" / "estar se fazendo") com `<br class="hook-br">` e o cabeçalho usa `.hook-head` para caber; no mobile a quebra some e o texto flui sozinho.
8. **A oferta** — card escuro com borda animada, preço R$ 27, checklist, botão e a nota "Pagamento seguro" abaixo dele.
9. **FAQ** — acordeão em vidro escuro, cada pergunta aparece individualmente ao entrar na tela.
10. **Ficha técnica** — 4 cards brancos (data, formato, duração, investimento). No desktop lado a lado; no mobile em **duas fileiras de dois que empilham no scroll**.
11. **Inscrição** — CTA final com anéis e brilho.
12. **Rodapé** — logo, e-mail, links, redes, selos pequenos (Compra 100% segura, Dados criptografados) e "© 2026 Grupo 2!H · Imersão Estrutura 5A. Todos os direitos reservados."

Elementos fixos: **logo do Grupo 2!H** no canto superior esquerdo, **cápsula central** no topo (largura fixa, ícone em selo dourado, texto que alterna a cada 2,6 s, ponto verde pulsando), **barra inferior** com CTA que aparece após o hero (texto curto no mobile), **trilha lateral dourada** de progresso que no desktop é clicável e arrastável (a seta do cursor acompanha o arraste), **cursor dourado** personalizado no desktop.

## 4. Regras aprovadas pelo cliente (não mudar sem pedir)

- **Manter o empilhamento no scroll** nas seções Crenças, Diagnóstico e Ficha técnica (mobile). O cliente aprovou esse efeito.
- **Sem** etiquetas/eyebrows numerados acima dos títulos ("01 · A ideia central" etc.). Foram removidos por parecer "cara de IA".
- **Sem** traços em degradê sob títulos, no topo de cards ou como decoração solta. A única linha decorativa aprovada é o divisor de luz entre Diagnóstico e Seis ângulos.
- **Sem** checklist de confiança abaixo dos botões do hero e sem indicador "role".
- **Sem** nota legal sobre Facebook/Google no rodapé.
- Cápsula do topo com **largura fixa** (não estica ao trocar o texto), **sem** barra de carregamento, **com** ponto verde pulsando.
- Selos do rodapé pequenos, só com título, na mesma linha dos direitos autorais.
- Identidade: fundo obsidian `#0A0A0C` / `#0F0F12` / `#15151A`, dourado `#F5C328` (claro `#FFD34F`, escuro `#B8830A`), creme `#F3EDE2`. Fontes General Sans (títulos) e Inter (texto).
- Botões: pílula dourada com ícone em círculo preto (`.btn-v2.btn-gold`), variante escura para fundos claros (`.btn-ink`), variante vidro para secundário (`.btn-glass`).

## 5. Como o JavaScript está organizado (fim do `index.html`)

Uma classe `Component` com `mount()` chamado no fim. Métodos principais:

- `setupReveal` — entrada dos elementos `[data-reveal]` e `[data-stagger]` via IntersectionObserver; contadores `[data-count]`.
- `setupFaq` — acordeão (classe `open`, acessível por teclado).
- `setupFunnel` / `setupFunnelEvents` / `flashSpout` / `funnelHeat` — animação do funil (leads, perdas, moedas, contadores, ondulação).
- `setupStack` / `updateStacks` / `updateStackProgress` — encolhimento dos cards empilhados e progresso "Etapa X de 10". O seletor dos cards vem do atributo `data-stack` (padrão `.stack-card`; a ficha técnica usa `.num-row`).
- `setupCapsule` — textos rotativos da cápsula.
- `setupCursor` — cursor dourado (só mouse fino).
- `setupRail` — trilha lateral clicável/arrastável.
- `onScroll` — barra inferior, parallax leve do hero, preenchimento da trilha, empilhamentos.
- `initTimeline` e `initSpotlight` — linha do tempo dos Seis ângulos e holofote que segue o mouse nos cards `.spot`.

Armadilha conhecida: `.spot` define `position:relative`; os cards empilhados precisam da regra `.stack-card.spot{position:sticky}` que já existe. Não remover.

## 6. Performance

- Página estática, sem React/Babel (a versão anterior carregava 3 MB de JavaScript do unpkg antes de renderizar).
- Hero em JPEG com `preload` por faixa de largura (828, 1080, 1366 e 1920 px), qualidade 92/90.
- Fontes servidas do próprio domínio (`assets/fonts`), com preload de General Sans 600 e Inter. Nenhuma conexão com Fontshare ou Google Fonts.
- Seta neon do hero é SVG inline; logo e ícones de canal em PNG no tamanho exibido; imagens abaixo da dobra com `loading="lazy"`; grupos dos marquees duplicados por JavaScript.
- `lang="pt-BR"`, meta description, Open Graph, `width`/`height` nas imagens.
- Se voltar a rodar o PageSpeed, a API pública sem chave estoura cota; use o site pagespeed.web.dev.

## 7. Pendências e observações

- **Link de pagamento:** todos os botões apontam para `#inscricao` (âncora da seção final). Quando houver URL de checkout, trocar `href="#inscricao"` nos botões e na barra inferior.
- As **descrições curtas das 10 etapas** do diagnóstico (ex.: "Modelo, posicionamento e capacidade de entrega") foram escritas pelo assistente e ainda não foram validadas pelo cliente.
- Redes sociais do rodapé apontam para `#inscricao` por falta dos links reais.
- Capas do hero: desktop 1920×1080 com título no canto superior esquerdo e pessoa à direita; mobile 1080×1620 com título na parte de baixo. Se a arte mudar de composição, revisar a posição dos ícones flutuantes e o `margin-top` negativo do texto no mobile (`.hero-content-wrap` na media query de 900 px).

## 8. Histórico resumido

- Set/2026 — v1 gerada no Claude Design (formato `.dc.html` com runtime React).
- 12/set/2026 — Redesign v2: funil novo, ritmo de cores, botões, cards, FAQ, ficha técnica, cápsula, trilha lateral, divisor de luz, rodapé com selos. Conversão para HTML estático e otimização de imagens. Capas novas do hero. Todos os commits estão no histórico do git com descrição.
