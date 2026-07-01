\# Dashboard de Análise de Mercado - Laptops (Kaggle Dataset)



Este repositório apresenta um projeto completo (End-to-End) de Engenharia e Análise de Dados. O objetivo principal foi extrair dados legados e públicos sobre especificações e preços de laptops do Kaggle Contendo dados de hardware, realizar toda a modelagem e tratamento de dados utilizando SQL, e estruturar um painel interativo focado em métricas de negócio para tomada de decisão.



\## 🛠️ Tecnologias Utilizadas

\* \*\*Origem dos Dados:\*\* Kaggle (Dados legados de especificações de hardware)

\* \*\*Banco de Dados:\*\* PostgreSQL

\* \*\*IDE de Banco de Dados:\*\* DBeaver

\* \*\*Ferramenta de BI:\*\* Power BI Desktop

\* \*\*Linguagem:\*\* SQL (PostgreSQL Dialect)



\---



\## 💾 Etapa 1: Engenharia \& Tratamento de Dados (SQL)



Para garantir uma arquitetura de dados performática, toda a limpeza pesada dos dados brutos obtidos no Kaggle foi delegada à origem (Banco de Dados). Através do \*\*DBeaver\*\*, criei uma \*\*View Otimizada\*\* aplicando as seguintes regras de tratamento:

1\. \*\*Limpeza de Strings:\*\* Remoção do sufixo de texto `'GB'` da coluna de memória RAM, permitindo agregações matemáticas posteriores.

2\. \*\*Tratamento de Anomalias:\*\* Substituição de caracteres inválidos (`'?'`) por valores nulos (`NULL`) para evitar quebras nos gráficos.

3\. \*\*Conversão de Tipos (Casting):\*\* Conversão explícita das colunas `ram` para `INTEGER` e `price` para `NUMERIC(10,2)` garantindo a integridade dos dados financeiros.



```sql

CREATE OR REPLACE VIEW public.v\_laptops\_clean AS

SELECT 

&#x20;   unnamed\_0,

&#x20;   company AS company\_tratado,

&#x20;   typename AS typename\_tratado,

&#x20;   inches AS inches\_tratado,

&#x20;   screenresolution AS screenresolution\_tratado,

&#x20;   cpu AS cpu\_tratado,

&#x20;   -- Tratamento de RAM: Removendo texto e convertendo para Inteiro

&#x20;   CASE 

&#x20;       WHEN ram IS NULL OR ram = '?' THEN NULL

&#x20;       ELSE CAST(REPLACE(ram, 'GB', '') AS INTEGER)

&#x20;   END AS ram\_tratado,

&#x20;   memory AS memory\_tratado,

&#x20;   gpu AS gpu\_tratado,

&#x20;   opsys AS opsys\_tratado,

&#x20;   weight AS weight\_tratado,

&#x20;   -- Tratamento de Preço: Removendo anomalias e formatando como numérico decimal

&#x20;   CASE 

&#x20;       WHEN price IS NULL OR price = '?' THEN NULL

&#x20;       ELSE CAST(price AS NUMERIC(10,2))

&#x20;   END AS price\_tratado

FROM public.laptops;

