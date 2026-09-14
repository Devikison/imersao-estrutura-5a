# Imersão Estrutura 5A · Grupo 2!H

Landing page de venda da **Imersão Estrutura 5A** (Grupo 2!H): imersão online e ao vivo de 4 horas, 10 de outubro, R$ 27.

- **Site no ar:** https://imersaoestrutura5a.agencia2h.com.br/ (GitHub Pages, domínio no arquivo `CNAME`). O domínio antigo `imersao5a.sitepreviavisual.site` foi aposentado: o GitHub Pages serve um domínio personalizado por vez, então ele para de responder assim que o novo `CNAME` chega na `main`. No Hostinger, o subdomínio é um registro **CNAME** `imersaoestrutura5a` apontando para `devikison.github.io`.
- **Repositório:** https://github.com/Devikison/imersao-estrutura-5a (branch `main`)
- **Publicação:** todo `git push` na `main` vai ao ar em cerca de 30 a 60 segundos. Confira com Ctrl+F5 ou aba anônima.

> **Para o assistente de código (Claude Code ou similar):** leia este README inteiro e o `index.html` inteiro antes de qualquer alteração. Siga os padrões da seção "Regras aprovadas pelo cliente". Toda mudança deve ser testada no preview local, commitada e enviada com `git push origin main`.

---

## 1. Estrutura do repositório

| Caminho | O que é |
|---|---|
| `index.html` | **A landing page inteira.** HTML estático com CSS no `<style>` do `<head>` e JavaScript no `<script>` no fim do `<body>`. Sem build e sem framework. A única coisa carregada de fora é o **Google Tag Manager** (`GTM-PDKH7XHJ`), com o script no topo do `<head>` e o `<noscript>` logo depois do `<body>`; fontes e imagens são todas do próprio domínio. |
| `assets/` | Logos (inclusive `logo-imersao-5a.png`, o letreiro "Imersão Estrutura 5A" recortado da capa do hero com fundo transparente), ícones, imagens e as fontes (`assets/fonts`: General Sans 400-700 e Inter variável, em woff2, declaradas no `<style>` da página). As capas do hero são servidas em JPEG (`hero-creative-*.jpg`); os PNG (`hero-creative.png`, `hero-creative-mobile.png`) ficam só como arquivo-fonte e **não são carregados pela página**. |
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

1. **Hero** — criativo com foto (fundo no desktop, imagem inteira 2:3 no mobile), logo da imersão (`.hero-logo`) alinhado acima do título, título, subtítulo, botão dourado "Quero garantir minha vaga" e botão vidro "O que você vai enxergar". Ícones flutuantes (Google Ads, Facebook, seta) posicionados por porcentagem, com valores diferentes para desktop e mobile.
2. **Faixa do 1º lote** (`.lote`) — logo depois do hero, fundo escuro. O cronômetro dela usa `.cdown-grid.dourado`: plaquinhas douradas com o número preto (o do CTA final continua escuro com número claro). "Encerra em" e os rótulos das plaquinhas ficam em branco só aqui. Selo "1º lote" à esquerda no desktop (`.lote-tag-d`) e acima de "Encerra em" no mobile (`.lote-tag-m`) — são dois elementos, e cada largura mostra um. Ao lado, "36% das vagas já foram preenchidas", a barra de progresso e, abaixo dela, a linha de data (`.lote-data`: ícone de calendário + "10 de outubro, às 19:00 · ao vivo e online"). Essa linha veio do hero, onde era uma pílula (a porcentagem vem da variável CSS `--vagas` no `style` da própria seção, e a barra enche quando entra na tela) e o cronômetro em versão compacta à direita. No mobile o cronômetro vai para cima e o resto centraliza.
3. **Faixa dourada** em marquee com os argumentos rápidos.
4. **A ideia central + Funil** — citação à esquerda, funil animado à direita (SVG + leads em HTML). Leads entram com ícone de canal, parte se perde no meio (fica cinza com X), parte vira moeda que cai no prato de "Receita · Margem". Contadores ao vivo abaixo. Rótulos em maiúsculas (Leads entrando, Atendimento, Comercial, Venda, Receita · Margem) aparecem no desktop e no mobile.
5. **Seis crenças** — fundo creme, cards escuros **empilhados no scroll** (sticky): cada card gruda no topo e o próximo desliza por cima, o de trás encolhe e escurece.
6. **O diagnóstico completo** — 10 etapas (Negócio a Margem), **mesmo empilhamento** dos cards das crenças. No desktop a coluna esquerda mostra "Etapa X de 10" com barra de progresso.
7. **Seis ângulos** — linha do tempo vertical que acende conforme rola. No mobile a linha passa por trás dos ícones. Abaixo, chips dos canais (Meta, Instagram, WhatsApp, Google Ads). Um **divisor de luz** (linha dourada, brilho e feixe correndo) separa esta seção da anterior.
8. **Frases que doem** — seção inteira dourada com pílulas escuras em marquee duplo. O título quebra em duas linhas no desktop ("Frases que você já deveria" / "estar se fazendo") com `<br class="hook-br">` e o cabeçalho usa `.hook-head` para caber; no mobile a quebra some e o texto flui sozinho.
9. **A oferta** — título "Tudo o que a imersão entrega por R$ 27" em duas linhas no desktop (`<br class="oferta-br">`, mesmo mecanismo do `.hook-br`). Card escuro com borda animada, logo da imersão (`.offer-logo`) no topo à esquerda, ao lado do selo "À venda hoje", preço R$ 27, checklist, botão e a nota "Pagamento seguro" abaixo dele.
10. **FAQ** — acordeão em vidro escuro, cada pergunta aparece individualmente ao entrar na tela.
11. **Ficha técnica** — 4 cards brancos (data, formato, duração, investimento). No desktop lado a lado; no mobile em **duas fileiras de dois que empilham no scroll**.
12. **Inscrição** — CTA final com anéis e brilho. Entre os chips e o botão fica o **cronômetro** (`.cdown`, split-flap: dias, horas, minutos e segundos) com o título "As inscrições encerram em breve.".
13. **Rodapé** — logo, e-mail, links, redes, selos pequenos (Compra 100% segura, Dados criptografados) e "© 2026 Grupo 2!H · Imersão Estrutura 5A. Todos os direitos reservados."

Sobre a página inteira: o **popup de captura** (`.lead`, markup logo antes do `<script>`) abre em qualquer um dos 5 botões de CTA, fecha no X, no fundo ou no Esc.

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
- `setupCountdown` — cronômetros da página (faixa do 1º lote e CTA final). Um só `setInterval` alimenta todos os blocos `[data-countdown]`; cada um tem o seu `data-deadline`. Cada plaquinha tem quatro metades (`.fc-t`/`.fc-b` fixas e `.fc-a`/`.fc-c` que giram): ao trocar de número, a metade de cima do valor antigo tomba em 0,3 s e revela o novo por baixo, depois a metade de baixo do novo sobe. A classe `virando` dispara as duas animações e some 620 ms depois. Com `prefers-reduced-motion` o número troca sem girar. A data-limite vem do atributo `data-deadline` do bloco `[data-countdown]` no HTML (hoje `2026-10-10T19:00:00-03:00`, ou seja, o início da imersão). Ao zerar, o título vira "As inscrições foram encerradas." e o timer para.
- `setupLead` — popup de captura: abre pelos `[data-cta]`, valida nome/e-mail/WhatsApp, aplica a máscara `(11) 99999-9999`, envia por POST ao `WEBHOOK` (sem `Content-Type` próprio, de propósito: evita o preflight de CORS) e manda a pessoa para a URL que o fluxo devolver, ou para a constante `CHECKOUT`. Se nenhuma existir, mostra a tela de confirmação. As duas constantes ficam no topo do `<script>`.
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
- O **Google Tag Manager** é a única requisição para fora. Ele carrega de forma assíncrona e não segura a renderização, mas o que pesa de verdade são as tags configuradas dentro do contêiner: se a página ficar lenta depois de alguma mudança, olhe lá antes de procurar no `index.html`.
- Seta neon do hero é SVG inline; logo e ícones de canal em PNG no tamanho exibido; imagens abaixo da dobra com `loading="lazy"`; grupos dos marquees duplicados por JavaScript.
- `lang="pt-BR"`, meta description, Open Graph, `width`/`height` nas imagens.
- Se voltar a rodar o PageSpeed, a API pública sem chave estoura cota; use o site pagespeed.web.dev.

## 7. Pendências e observações

- **Plataforma:** a pílula do hero termina em "ao vivo e online" porque a plataforma (Zoom, YouTube etc.) não foi informada. Quando houver, trocar para "ao vivo no X". O horário de início (19:00, confirmado pelo cliente) aparece na pílula e no `data-deadline` do cronômetro: os dois andam juntos.
- **Logo duplicado no hero (desktop):** a capa `hero-creative.png` ainda traz o mesmo letreiro no canto superior esquerdo, então no desktop ele aparece duas vezes. O cliente sabe: a ideia é trocar a foto do hero por uma sem o letreiro. Ao trocar, rodar `tools\make-hero-jpg.ps1` de novo.
- **Checkout / popup de captura:** os 5 botões de CTA (hero, esteira, card da oferta, CTA final e barra fixa) têm `data-cta` e abrem o **popup** (`#lead`), que envia nome, e-mail, WhatsApp, a origem do clique, a URL da página e as UTMs para o webhook do n8n por POST e, em seguida, manda a pessoa para o checkout. O `href="#inscricao"` continua como plano B se o JavaScript não rodar. O destino é a constante `CHECKOUT` no topo do `<script>` (hoje `https://pay.kiwify.com.br/u3dyAhj`); se o fluxo do n8n responder com uma URL própria (redirect, texto puro ou JSON com `url`/`checkout`/`link`/`redirect`), ela ganha. Nos dois casos a página acrescenta `customer.name`, `customer.email` e `customer.phone` (com o 55 na frente) para o checkout abrir preenchido — são os parâmetros que a Kiwify documenta. **Falta confirmar com o n8n:** se o fluxo aceita `application/x-www-form-urlencoded` com os nomes `nome`, `email` e `whatsapp`, e se o nó Webhook libera o CORS para `https://imersaoestrutura5a.agencia2h.com.br` (sem isso os dados chegam, mas a página não consegue ler a resposta — o redirecionamento continua funcionando pela constante).
- As **descrições curtas das 10 etapas** do diagnóstico (ex.: "Modelo, posicionamento e capacidade de entrega") foram escritas pelo assistente e ainda não foram validadas pelo cliente.
- Redes sociais do rodapé apontam para `#inscricao` por falta dos links reais.
- Capas do hero: desktop 1920×1080 com título no canto superior esquerdo e pessoa à direita; mobile 1080×1620 com título na parte de baixo. Se a arte mudar de composição, revisar a posição dos ícones flutuantes e o `margin-top` negativo do texto no mobile (`.hero-content-wrap` na media query de 900 px).

## 8. Histórico resumido

- Set/2026 — v1 gerada no Claude Design (formato `.dc.html` com runtime React).
- 12/set/2026 — Redesign v2: funil novo, ritmo de cores, botões, cards, FAQ, ficha técnica, cápsula, trilha lateral, divisor de luz, rodapé com selos. Conversão para HTML estático e otimização de imagens. Capas novas do hero. Todos os commits estão no histórico do git com descrição.
