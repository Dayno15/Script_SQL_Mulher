USE dados_mulher_novo;
---Evolução da Violência Doméstica por Ano
SELECT t.ano, COUNT(*) AS total_casos
FROM mulherr m
JOIN dimtempo t ON m.idDimtempo = t.idDimtempo
GROUP BY t.ano
ORDER BY t.ano;

----Distribuição de Casos por Estado
SELECT e.estado, COUNT(*) AS total_casos
FROM mulherr m
JOIN dimestado e ON m.idEstado = e.idEstado
GROUP BY e.estado
ORDER BY total_casos DESC;

---Distribuição de Casos por Faixa Etária
SELECT i.faixa_etaria, COUNT(*) AS total_casos
FROM mulherr m
JOIN dimidade i ON m.idIdade = i.idIdade
GROUP BY i.faixa_etaria
ORDER BY total_casos DESC;

---Distribuição de Casos por Raça
SELECT r.raca, COUNT(*) AS total_casos
FROM mulherr m
JOIN dimraca r ON m.idRaca = r.idRaca
GROUP BY r.raca
ORDER BY total_casos DESC;

--Distribuição de Casos por Sexo
SELECT s.sexo, COUNT(*) AS total_casos
FROM mulherr m
JOIN dimsexo s ON m.idSexo = s.idSexo
GROUP BY s.sexo
ORDER BY total_casos DESC;