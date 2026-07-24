# Handoff: Portfólio Mobile — Camila Ferreira

## Overview
App de portfólio pessoal em formato mobile (412×892 lógico), estética escura, tipografia
pesada em caixa alta, textura de grão/xerox e um acento blurple usado como linha e brilho
(nunca como preenchimento grande). Seis seções navegáveis por barra inferior numerada,
alternador PT/EN, tema claro/escuro, cursor próprio, transições cinematográficas entre telas
e integração ao vivo com a API pública do GitHub na aba Projetos.

Direção aprovada: **Setlist** (home como tracklist numerada).

## About the Design Files
Os arquivos deste pacote são **referências de design escritas em HTML** — protótipos que
mostram aparência e comportamento pretendidos, **não** código de produção para copiar.
A tarefa é **recriar estes designs no ambiente do codebase de destino** (React/Next, Vue,
SwiftUI, Jetpack Compose, Flutter…) usando os padrões e bibliotecas já estabelecidos lá.
Se ainda não existe ambiente, escolha o framework mais adequado ao projeto e implemente ali.

Observação específica: dado o perfil da autora (dev mobile, Kotlin/Swift/Flutter), duas rotas
naturais são (a) **Jetpack Compose** (Material 3, tema escuro custom) ou (b) **React/Next.js**
para web. O protótipo não impõe nenhuma.

## Fidelity
**High-fidelity (hifi).** Cores, tipografia, espaçamentos, estados e microinterações são finais.
Recrie a UI fielmente usando as bibliotecas do codebase. Onde houver design system próprio,
mapeie os tokens abaixo para os equivalentes existentes antes de introduzir novos valores.

O visual deriva do design system **Nocturne** (tema escuro, acento #9184d9, raio 8px,
escala de espaçamento densa 0.70×). `styles.css` está incluído como referência de tokens.

---

## Estrutura geral (shell do app)

Frame: 412×892 (Android). Dentro dele:

1. **Header fixo** — 1px de borda inferior `--line`; padding `12px 16px 10px`; fundo `--bg`.
   - Esquerda (botão → Home): monograma `CF` em caixa 26×26, borda 1px `--acc`, texto `--acc`,
     Archivo Black 11px, `letter-spacing:-.02em`; ao lado, duas linhas — nome
     "Camila Ferreira" (Archivo Black 12px, uppercase, `letter-spacing:.02em`) e
     "Dev Mobile · Kotlin" (9.5px, uppercase, `letter-spacing:.14em`, cor `--dim`, `nowrap`).
   - Direita: seletor **PT/EN** (borda 1px `--line`, raio 3px; cada rótulo 9.5px/600,
     `letter-spacing:.12em`; o idioma ativo recebe uma barra de 2px em `--acc` colada embaixo,
     `left/right:5px; bottom:3px`) e **botão de tema** 28×28, borda 1px `--line`, raio 3px,
     glifo = círculo 12px com borda 1.5px `--ink`; em escuro tem `box-shadow:inset 4px -3px 0 0 var(--ink)`
     (lua), em claro é preenchido (sol).
2. **Área de conteúdo** — `flex:1`, scroll vertical próprio, barra de rolagem oculta
   (`scrollbar-width:none`). É o container de scroll usado por parallax e reveal.
3. **Barra inferior de navegação** — 6 itens iguais (`flex:1`), padding `9px 2px 10px`,
   borda superior 1px `--line`, fundo `--bg`. Cada item: número 8px (`tabular-nums`) +
   rótulo 9px/600 `letter-spacing:.08em`. Item ativo: número e barra em `--acc`
   (barra de 2px no topo do item, `left:24%; right:24%`), rótulo em `--ink`; inativos em `--dim`.
   Ordem: `01 Casa · 02 Obras · 03 Linha · 04 Stack · 05 Trilha · 06 Sobre`
   (EN: `Home · Work · Path · Stack · Sound · About`).
4. **Camadas decorativas** (todas `pointer-events:none`, exceto onde indicado):
   - **Grão**: `inset:-40px`, `opacity:.3`, `mix-blend-mode:overlay`, `z-index:60`,
     background = SVG inline `feTurbulence type="fractalNoise" baseFrequency="0.85" numOctaves="3"`,
     animação `noc-drift` 6s `steps(6)` infinita (background-position 0 0 → 120px 120px).
   - **Vinheta**: `z-index:59`, `radial-gradient(120% 80% at 50% 0%, transparent 40%, rgba(0,0,0,.55) 100%)`.
   - **Cursor próprio**: círculo 22×22 com borda 1px `--acc`, `z-index:80`, segue o mouse via
     `transform: translate(x,y)`; sobre elemento interativo (`[data-hot]`) cresce para 40×40 e
     ganha fundo `--acctint`; transições de 160ms. O app inteiro usa `cursor:none`.
     Em toque/mobile real: **não implementar** (só desktop/web).
   - **Wipe de transição**: retângulo full-bleed em `--acc`, `mix-blend-mode:hard-light`,
     `z-index:75`, `transform:scaleY(0)`; animado a cada troca de tela.

---

## Screens / Views

### 1. Casa (Home) — variante aprovada "Setlist"
**Purpose:** apresentação e ponto de partida da navegação.

**Layout, de cima para baixo:**
1. Seção de título, padding `26px 16px 8px`:
   - kicker "Lado A · Setlist" (EN "Side A · Setlist") — 9.5px, uppercase, `letter-spacing:.2em`, `--acc`, `margin-bottom:10px`.
   - `h1` em três linhas: **DEV / MOBILE / KOTLIN** — Archivo Black 52px, `line-height:.8`,
     `letter-spacing:-.045em`, uppercase. A terceira linha ("Kotlin") é vazada:
     `color:transparent; -webkit-text-stroke:1px var(--acc)`.
   - parágrafo 12.5px/1.5 em `--dim`, `margin-top:18px`, `text-wrap:pretty`:
     "Duas formações técnicas, ADS em andamento e uma pasta de apps que realmente saem do forno."
     (EN: "Two technical degrees, a CS degree in progress, and a folder of apps that ship.")
2. **Setlist de navegação** — lista de 5 linhas (todas as seções menos a Casa), borda superior
   1px `--line`, `margin-top:18px`. Cada linha: `padding:15px 16px`, borda inferior 1px `--line`,
   colunas = número (10px, `--acc`, `tabular-nums`) · rótulo (Archivo Black 19px, uppercase,
   `letter-spacing:-.02em`, `flex:1`) · meta (10px, uppercase, `letter-spacing:.14em`, `--dim`)
   · seta "→" 13px em `--acc`.
   **Hover:** `padding-left:22px` (a linha "entra" para a direita).
   Conteúdo: `02 OBRAS 03` · `03 LINHA 06` · `04 STACK 07` · `05 TRILHA 06` · `06 SOBRE —`
   (o meta é a contagem de itens da seção).
3. **Em destaque** (`padding:22px 16px 8px`): cabeçalho com "Em destaque" (10px, uppercase,
   `letter-spacing:.2em`, `--dim`) e link "todos os projetos →" (10px, uppercase, `--acc`).
   Dois cartões (os dois primeiros projetos), cada um: `display:flex; gap:12px; padding:10px`,
   fundo `--surf`, borda 1px `--line`, raio 8px; à esquerda um bloco 76×76 (raio 5px, borda 1px
   `--line`, fundo `--raise`) com o número do projeto em Archivo Black 25px `--acc`; à direita
   título (Archivo Black 17px uppercase), resumo (11.5px `--dim`) e stack (9px uppercase `--acc`).
   **Hover:** `translateY(-2px)` + borda `--acc` (220ms).
4. **Faixa de trilha** (`margin:6px 16px 26px; padding:12px`, fundo `--surf`, borda 1px `--line`,
   raio 8px): equalizador de 4 barras 3px em `--acc` (animação `noc-bar` .9s, delays 0/.15/.3/.45s,
   `transform-origin:bottom`, `scaleY .25 → 1`), rótulo "Compilando ao som de" (9px uppercase `--dim`)
   + faixa atual (12.5px/600) e botão "trilha" (borda 1px `--acc`, texto `--acc`, 9.5px uppercase)
   que navega para a aba Trilha.

*(Variantes não usadas, mantidas no código: "Pôster" — retrato full-bleed com parallax e nome em
66px; "Colagem" — recortes rotacionados, etiqueta de fita e letreiro rolante. Prop `hero`.)*

### 2. Obras (Projetos)
**Purpose:** listar projetos com filtro por stack e abrir o detalhe.

- Cabeçalho `padding:20px 16px 12px`: `h2` "PROJETOS" (Archivo Black 36px, `line-height:.85`,
  `letter-spacing:-.04em`), linha "N itens · filtre por stack" (11.5px `--dim`, N em `--acc`)
  e **selo de status ao vivo**: ponto 7px + texto 9.5px uppercase `letter-spacing:.16em` `--dim`.
  Estados: `ao vivo do GitHub` (ponto `--acc` com halo `0 0 0 3px var(--acctint)`) ·
  `sincronizando com o GitHub…` (ponto piscando, `noc-blink` 1.2s) ·
  `GitHub indisponível — dados salvos` (ponto vazado, borda 1px `--line`).
- **Chips de filtro**: fila horizontal com scroll (`gap:6px; padding:0 16px 12px`), cada chip
  borda 1px `--line`, raio 99px, `padding:6px 11px`, 10px/600 uppercase `letter-spacing:.1em`.
  Ativo: preenchimento `--acc` e texto `--bg` (em tema claro, texto `#f3f5fe`).
  Valores: `Todos · React · Node · TypeScript · IoT · MySQL`.
- **Cartões de projeto** (coluna, `gap:12px; padding:0 16px 26px`), sem imagem:
  fundo `--surf`, borda 1px `--line`, raio 8px, `overflow:hidden`.
  - Cabeçalho do cartão (`padding:12px 12px 0`): número (Archivo Black 11px `--acc`) ·
    régua que esmaece (`height:1px; linear-gradient(90deg,var(--line),transparent)`, `flex:1`) ·
    meta ao vivo (9px uppercase `--acc`, `nowrap`) — ex. `★ 5 · atualizado nov 2025`;
    sem dados ao vivo, mostra apenas o ano.
  - Corpo (`padding:12px 12px 13px; gap:6px`): título (Archivo Black 21px uppercase,
    `letter-spacing:-.025em`), resumo (12px/1.45 `--dim`), tags (borda 1px `--line`, raio 99px,
    `padding:3px 8px`, 9px uppercase `--acc`).
  - **Hover:** `translateY(-3px)` + borda `--acc` (240ms `cubic-bezier(.2,.7,.2,1)`).
  - Entrada em cena: animação de reveal (ver Interações).
- **Outros repositórios** (só quando a API respondeu): título 10px uppercase `--dim` e lista de
  até 8 linhas separadas por 1px `--line` sobre fundo `--surf` — nome (12.5px/600), descrição
  (10.5px `--dim`, fallback "Sem descrição no GitHub."), linguagem (9px uppercase `--acc`) e "↗".
  **Hover:** fundo `--raise`. Cada linha abre o repositório em nova aba.

### 3. Detalhe do projeto
Aberto ao tocar um cartão (substitui a lista; a barra inferior mantém "Obras" ativa).

- **Cabeçalho tipográfico** (`padding:14px 16px 20px`, borda inferior 1px `--line`): listras de
  xerox ao fundo (`repeating-linear-gradient(96deg, transparent 0 22px, color-mix(in srgb,var(--ink) 6%,transparent) 22px 23px)`,
  `opacity:.5`); botão "← voltar" (borda 1px `--line`, 10px uppercase `letter-spacing:.14em`;
  hover borda+texto `--acc`); depois kicker `NN · ANO` (9.5px uppercase `--acc`) com régua que
  esmaece em `--acc`, e `h2` do título (Archivo Black 40px, `line-height:.85`, `letter-spacing:-.04em`).
- Corpo (`padding:18px 16px 26px; gap:18px`):
  - parágrafo longo 13px/1.55.
  - **grade de especificações** 2×2: `gap:1px` sobre fundo `--line` (as próprias células em
    `--surf`, `padding:11px 12px`), rótulo 9px uppercase `--dim` + valor 12px/600.
    Campos: `Stack`, `Também`, `Papel`, e `Atualizado` (data real do GitHub) ou `Ano` (fallback).
  - **"O que aprendi"**: título 10px uppercase `--dim`; itens com marcador "▪" em `--acc`,
    texto 12.5px/1.45.
  - **Links**: "Código no GitHub" (borda 1px `--acc`, texto `--acc`, hover fundo `--acctint`) e,
    quando existir, "Ver rodando" (borda `--line`, hover borda+texto `--acc`). Ambos abrem em nova aba.
  - **"Próximo · TÍTULO"**: botão de contorno `--acc`, 10px/600 uppercase, cicla para o projeto seguinte.

### 4. Linha (Experiência + Formação)
- `h2` "LINHA DO TEMPO" + linha de apoio "Onde trabalho e o que cada formação ensinou."
- **Experiência** (título 10px uppercase `--dim`): cartão fundo `--surf`, borda 1px `--line`,
  raio 8px, `padding:13px 13px 14px`, `margin-bottom:26px` — período (Archivo Black 11px `--acc`),
  cargo (Archivo Black 19px uppercase), empresa (11px uppercase `letter-spacing:.1em` `--dim`),
  descrição 12px/1.5 e lista de atividades com marcador "—" em `--acc` (11px/1.4).
- **Formação** (título 10px uppercase `--dim`): trilha vertical — linha de 1px à esquerda com
  gradiente que esmaece nas pontas (`transparent → var(--acc) 12% → var(--acc) 88% → transparent`),
  itens com `padding-left:20px`, marcador circular 9px (borda 1px `--acc`, fundo `--bg`),
  período (Archivo Black 13px `--acc`), título (14px/600), descrição (11.5px `--dim`) e
  competências em bullets "—" (11px/1.4). **Ordem: mais recente primeiro (ADS no topo).**

### 5. Stack
`h2` "STACK" + "Toque num bloco para ver como eu uso." Lista de botões (fundo `--surf`,
borda 1px `--line`, raio 8px, `padding:11px 12px`, hover borda `--acc`): nome (Archivo Black 15px
uppercase), 5 "pips" de 7×7 (preenchidos em `--acc` até o nível, os demais com borda `--line`) e
tempo (9px uppercase `--dim`, largura fixa 52px, alinhado à direita). Ao tocar, expande uma nota
(12px/1.45 `--dim`) separada por borda superior 1px `--line` — acordeão de um item por vez.

### 6. Trilha
`h2` "TRILHA" + "O que toca enquanto o build roda — o resto está no Spotify."
- **Cartão-link do Spotify**: borda 1px `--acc`, raio 8px, `padding:12px 13px`, texto `--acc`,
  hover fundo `--acctint`; à esquerda o equalizador animado (4 barras, `noc-bar`), depois
  "Meu perfil no Spotify" (12.5px/600) + "todas as playlists, de verdade" (9.5px uppercase `--dim`)
  e "↗". Abre o perfil em nova aba.
- **Lista de faixas** (estática, sem player): linhas `padding:13px 16px`, borda inferior 1px
  `--line`, número 10px `--acc` (largura 16px), título 13.5px/600, artista 10.5px `--dim`,
  e "humor" 9px uppercase `--dim` à direita.

### 7. Sobre
`h2` "SOBRE"; retrato 228px de altura (borda 1px `--line`, raio 6px, `overflow:hidden`) com fade
inferior de 56px (`linear-gradient` até `color-mix(in srgb,var(--bg) 88%,transparent)`) e legenda
"Camila Ferreira" (9px uppercase `letter-spacing:.18em` `--acc`, `left:11px; bottom:9px`);
dois parágrafos (13px/1.55; o segundo em `--dim`); bloco **Formação** (células `--surf` separadas
por 1px `--line`: título 12.5px/600 + status 9.5px uppercase `--acc`, e meta
"período · duração · instituição" 10.5px `--dim`); bloco **Contato** com três links empilhados
(`gap:8px`, `padding:11px 12px`, raio 3px, 11px/600 uppercase `letter-spacing:.14em`): GitHub em
contorno `--acc` (hover fundo `--acctint`), LinkedIn e e-mail em contorno `--line`
(hover borda+texto `--acc`).

---

## Interactions & Behavior

- **Navegação**: estado `tab`; a barra inferior e a setlist trocam de tela. Abrir projeto define
  `tab:'detail'` + `pid`; "voltar" retorna para `work`.
- **Transição de tela** (a cada mudança de `tab`/`pid`):
  1. o container de conteúdo volta para `scrollTop = 0`;
  2. anima `opacity 0→1`, `translateY(20px)→0`, `scale(.988)→1`, `blur(7px)→0` —
     **460ms `cubic-bezier(.2,.7,.2,1)`**;
  3. o wipe em `--acc` faz `scaleY 0→1` (origem embaixo) e `1→0` (origem em cima),
     **540ms `cubic-bezier(.6,0,.2,1)`**, opacidade .9→.5→.9.
- **Reveal ao entrar em cena**: `IntersectionObserver` (root = container de scroll, threshold .15)
  anima uma única vez `opacity 0→1` + `translateY(16px)→0`, **520ms `cubic-bezier(.2,.7,.2,1)`**.
  Elementos marcados: cartões de projeto, itens da formação, cartão de experiência, blocos do hero.
- **Parallax**: no scroll, elementos marcados recebem `translateY(scrollTop × k)` com k entre
  0.14 e 0.30 (usado nas variantes de hero e cabeçalhos com imagem).
- **Cursor próprio**: ver camadas decorativas. Só desktop.
- **Hovers**: descritos por componente acima. Nada usa estado padrão do browser.
- **Foco de teclado**: `:focus-visible { outline: 2px solid var(--acc); outline-offset: 2px }`.
- **PT/EN**: alterna todos os textos, inclusive períodos ("fev 2025 – jun 2026" ⇄ "Feb 2025 – Jun 2026").
  No protótipo, textos estáticos trazem a versão inglesa em `data-en` e o conteúdo dinâmico vem de
  objetos `{pt, en}`; no app real, use i18n do codebase (duas chaves por string).
- **Claro/escuro**: troca o conjunto de variáveis CSS na raiz do app, com transição de 420ms em
  `background` e `color`. No tema claro, o blend das imagens vira `normal` (no escuro é `lighten`).
- **Estados de carregamento/erro**: apenas na aba Projetos (selo ao vivo). Falha de rede ou limite
  de API ⇒ mantém o conteúdo curado e mostra "GitHub indisponível — dados salvos".

## State Management

| Estado | Tipo | Papel |
| --- | --- | --- |
| `tab` | `'home' \| 'work' \| 'detail' \| 'time' \| 'skills' \| 'sound' \| 'about'` | tela atual |
| `pid` | `string \| null` | projeto aberto no detalhe |
| `lang` | `'pt' \| 'en'` | idioma |
| `theme` | `'dark' \| 'light'` | tema |
| `tag` | `'all' \| string` | filtro de stack |
| `skill` | `string \| null` | item de stack expandido |
| `repos` | `Repo[] \| null` | resposta da API do GitHub |
| `repoErr` | `boolean` | falha na busca |

**Data fetching** — uma chamada, sem autenticação, no primeiro render:

```
GET https://api.github.com/users/camistallica/repos?per_page=100&sort=updated
```

Uso da resposta:
- casa por `name` com os projetos curados (`satsmeter`, `projetoquizds`, `apm-senai`) e mostra
  `stargazers_count` e `pushed_at || updated_at` (formatado "mmm aaaa", meses localizados);
- repositórios restantes (excluindo forks) alimentam "Outros repositórios" (até 8), usando
  `name`, `description`, `language`, `html_url`;
- os textos, notas e tags dos três projetos curados são **conteúdo editorial** — não sobrescrever
  com a descrição do GitHub.

Limite: 60 req/h por IP na API pública. Em produção, prefira cache (revalidação a cada 1h) ou
uma rota de servidor com token; mantenha o fallback para os dados salvos.

## Design Tokens

**Cores — tema escuro (padrão)**
| Token | Valor |
| --- | --- |
| `--bg` | `#161826` |
| `--surf` | `#232532` |
| `--raise` | `#292b31` |
| `--ink` | `#e9e9ed` |
| `--dim` | `#9397ab` |
| `--line` | `rgba(233,233,237,0.16)` |
| `--acc` | `#9184d9` |
| `--accdim` | `#5d5294` |
| `--acctint` | `rgba(145,132,217,0.14)` |
| `--blend` | `lighten` |

**Cores — tema claro**
| Token | Valor |
| --- | --- |
| `--bg` | `#f3f5fe` |
| `--surf` | `#e4e7f5` |
| `--raise` | `#cfd3e5` |
| `--ink` | `#292b31` |
| `--dim` | `#595d6c` |
| `--line` | `rgba(41,43,49,0.16)` |
| `--acc` | `#5d5294` |
| `--accdim` | `#423a6a` |
| `--acctint` | `rgba(93,82,148,0.12)` |
| `--blend` | `normal` |

Rampas completas (100–900 de neutro e acento) em `styles.css` — use os passos escuros (700–900)
para preenchimentos tingidos e hovers no tema escuro, e 100–300 para texto sobre esses tingimentos.

**Tipografia**
- Display/títulos: **Archivo Black** 400 (fallback `Helvetica, sans-serif`).
  Escala usada: 66 / 52 / 42→40 / 36 / 25 / 21 / 19 / 17 / 15 / 13 / 11 / 10px.
  `line-height` .80–.86 nos títulos grandes, `letter-spacing` −.045em a −.02em, sempre uppercase.
- Texto: **Inter Tight** 400/500/600/700 (fallback `Helvetica, system-ui, sans-serif`).
  Escala: 13.5 / 13 / 12.5 / 12 / 11.5 / 11 / 10.5 / 10 / 9.5 / 9 / 8.5px;
  `line-height` 1.4–1.55; rótulos em uppercase com `letter-spacing` .1em–.2em.
- Nunca engrossar títulos além do peso próprio da Archivo Black; hierarquia é tamanho e espaço.

**Espaçamento** — grade de 16px nas laterais; blocos verticais 4/6/8/10/12/14/18/22/26px.
(Equivale à escala densa 0.70× do Nocturne: 2.8 / 5.6 / 8.4 / 11.2 / 16.8 / 22.4px.)

**Raios** — 3px (controles pequenos), 5–6px (miniaturas/retrato), 8px (cartões), 99px (chips).

**Elevação** — sem sombras empilhadas: no escuro, elevação = borda de 1px `--line` + escurecimento
ambiente. Referências do DS: `--shadow-sm: 0 0 0 1px #3f424d`,
`--shadow-md: 0 0 0 1px #595d6c, 0 6px 18px rgba(0,0,0,.55)`.

**Keyframes**
```css
@keyframes noc-marquee { from { transform: translateX(0) }   to { transform: translateX(-50%) } }
@keyframes noc-bar     { 0%,100% { transform: scaleY(.25) }  50% { transform: scaleY(1) } }
@keyframes noc-blink   { 0%,100% { opacity: .25 }            50% { opacity: 1 } }
@keyframes noc-drift   { from { background-position: 0 0 }   to { background-position: 120px 120px } }
```

**Texturas**
- Grão: SVG `feTurbulence` (`fractalNoise`, `baseFrequency .85`, `numOctaves 3`), `overlay`, `opacity .3`.
- Xerox/listras: `repeating-linear-gradient(96deg, transparent 0 22px, color-mix(in srgb,var(--ink) 6%,transparent) 22px 23px)`.
  (Na variante Colagem, 74deg com passo de 9/10px.)

## Assets
- `assets/camila-portrait.png` — retrato 1280×1280 fornecido pela autora e **tratado**:
  duotone (sombra `#101222`, alta luz `#d6d8e4`, leve tinta `#9184d9` nos meios-tons),
  contraste ×1.5, grão ±18 e vinheta forte (centro em 50%/38%). Use este arquivo já tratado;
  se substituir a foto, refaça o tratamento para manter a coerência.
- Ícones: nenhum arquivo — o protótipo usa glifos de texto (`→ ↗ ▪ — ✳`) e formas CSS.
  Se o codebase precisar de biblioteca, o Nocturne recomenda **Phosphor Icons**.
- Fontes: Google Fonts — `Archivo Black` e `Inter Tight` (400–700).
- Nenhuma imagem de projeto: os cartões são tipográficos por decisão de design.

## Conteúdo real (usar como está)
- Nome: **Camila Ferreira** · monograma **CF** · "Dev Mobile · Kotlin".
- Contato: `github.com/camistallica` · `linkedin.com/in/camilaferreira07` ·
  `camilaferri102@gmail.com` · Spotify:
  `https://open.spotify.com/user/sv33925q40bufe2pt4tpeyx7w?si=0dc36fb848e34af2`.
- Experiência: **Estagiária de Software · SyOS** (2026 — atual) — mobile nativo (Swift/Kotlin),
  Flutter, endpoints em API Node.js, criação/atualização de páginas web, coleta e análise de
  feedback, avaliação de novas funcionalidades e refatoração.
- Formação (mais recente primeiro): ADS · Mackenzie (2026–2028, cursando, 2 anos) ·
  Técnico em Desenvolvimento de Sistemas · Etec Albert Einstein (fev 2025 – jun 2026, concluído,
  1 ano e 4 meses) · Técnico Integrado ao Ensino Médio, Informática para Internet · Etec Albert
  Einstein (fev 2023 – dez 2025, concluído, 2 anos e 10 meses). As competências de cada curso
  estão nos arrays `TIMELINE`/`EDU` do protótipo.
- Projetos curados: **SatsMeter** (ESP32+INA219, MQTT, sats, relé com carência/religação,
  dashboard React+TS) · **Quiz DS** (Node/Express/MySQL, deploy Ubuntu Server) ·
  **APM Senai** (React+TS+Vite na Vercel). Resumos, textos longos e "o que aprendi" no array `PROJECTS`.
- Trilha: 6 faixas de Metallica com um "humor" cada (refatorar, build longo, debug 2h, foco puro,
  code review, merge feito).

## Files
| Arquivo | O que é |
| --- | --- |
| `PortfolioApp.dc.html` | O app completo: markup das 7 telas + toda a lógica e o conteúdo (arrays `PROJECTS`, `TIMELINE`, `SKILLS`, `TRACKS`, `EDU`, `JOB`, `NAV`, temas, fetch do GitHub). **Fonte principal da verdade.** |
| `Portfolio Mobile.dc.html` | Página de apresentação: monta o app dentro de um frame Android e traz o card de premissas do design. |
| `android-frame.jsx` | Moldura Android usada só na apresentação (status bar + barra de gestos). Não faz parte do produto. |
| `image-slot.js` | Componente de placeholder de imagem usado pelo retrato do Sobre no protótipo. Substituir por `<img>`/`Image` no app real. |
| `styles.css` | Tokens do design system Nocturne (rampas 100–900, tipografia, espaçamento, raios, sombras) — referência de mapeamento. |
| `assets/camila-portrait.png` | Retrato já tratado. |

Como abrir os protótipos: qualquer navegador moderno, direto no arquivo `.html`
(precisam de internet para as fontes e para a API do GitHub).

## Screenshots
Em `screenshots/` (capturas do protótipo dentro da moldura Android — a moldura não faz parte do produto):

| Arquivo | Tela |
| --- | --- |
| `01-casa-setlist.png` | Casa — variante Setlist aprovada |
| `02-projetos.png` | Projetos com selo ao vivo, chips de filtro e cartões |
| `03-projeto-detalhe.png` | Detalhe de projeto (cabeçalho tipográfico, specs, links) |
| `04-linha-experiencia-formacao.png` | Linha — cartão da SyOS + trilha de formação |
| `05-stack-item-aberto.png` | Stack com um item expandido |
| `06-trilha-spotify.png` | Trilha — cartão-link do Spotify e lista de faixas |
| `07-sobre.png` | Sobre — retrato tratado, formação e contato |
| `08-tema-claro.png` | Mesma tela no tema claro |

O grão animado não aparece nas capturas (limitação do exportador); ele existe no protótipo.

## Notas de implementação
1. A UI é toda inline-styled no protótipo por causa do ambiente de autoria. **No codebase, use
   o padrão de estilo local** (CSS Modules, Tailwind, `styled`, Compose `Modifier`…), mapeando os
   tokens acima para o sistema existente.
2. Os "espaços de imagem" (`<image-slot>`) são artefato do protótipo — no app real é `<img>`.
3. O cursor próprio e os hovers são para desktop/web; em app nativo, troque por `ripple`/`pressed`
   com o mesmo tingimento `--acctint`.
4. Acessibilidade a fechar na implementação: `aria-current` no item ativo da barra, rótulos
   acessíveis nos botões só-ícone (tema, PT/EN), foco visível já especificado, e contraste —
   o acento vale para chrome e texto grande; para corpo de texto em acento use um passo mais
   escuro da rampa (`--color-accent-300` no escuro).
