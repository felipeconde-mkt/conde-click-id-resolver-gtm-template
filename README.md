# Click ID Resolver — Conde MKTech

<p align="left">
  <img src="assets/crown.svg" width="128" height="128" alt="Coroa Conde MKTech">
</p>

Variável para **Google Tag Manager WEB** que centraliza identificadores de clique de Google Ads, Meta, TikTok, Microsoft Ads, Pinterest, LinkedIn, X, Taboola, Outbrain, Snapchat, Reddit, Yandex, Impact e fontes personalizadas.

## Destaques

- Uma variável retorna todos os Click IDs em um objeto.
- Parâmetro oficial tem prioridade.
- Contingência por nomes invertidos/alternativos para cenários de ITP, redirects e filtros de parâmetros.
- Os Click IDs são lidos exclusivamente da URL atual e nunca são persistidos.
- Apenas `google_session_attributes` é salvo no `localStorage`, replicando o comportamento do código original para reutilização nas páginas seguintes.
- Permite adicionar mapeamentos personalizados pela interface.

## Instalação manual

1. Baixe `template.tpl`.
2. No GTM WEB, acesse **Templates → Variable Templates → New**.
3. Use **Import** e selecione o arquivo.
4. Salve e crie uma variável usando **Click ID Resolver — Conde MKTech**.

## Atualizações

Quando o template for aprovado na Community Template Gallery, containers que o instalarem pela galeria poderão receber avisos de atualização mantendo a configuração da variável. Importações manuais não se vinculam automaticamente ao repositório.

## Autor

[Conde MKTech](https://conde.marketing)

## Licença

Apache License 2.0.
