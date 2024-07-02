USE dados_mulher_novo;

---Comandos DDL---

CREATE TABLE mulherr (
  DT_NOTIFIC date DEFAULT NULL,
  DT_NASC text COLLATE utf8mb4_unicode_ci,
  NU_IDADE_N int DEFAULT NULL,
  CS_SEXO text COLLATE utf8mb4_unicode_ci,
  CS_RACA text COLLATE utf8mb4_unicode_ci,
  DB_CIDADE varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UF varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  OUT_VEZES text COLLATE utf8mb4_unicode_ci,
  LES_AUTOP text COLLATE utf8mb4_unicode_ci,
  VIOL_FISIC text COLLATE utf8mb4_unicode_ci,
  VIOL_PSICO text COLLATE utf8mb4_unicode_ci,
  VIOL_SEXU text COLLATE utf8mb4_unicode_ci,
  NUM_ENVOLV text COLLATE utf8mb4_unicode_ci,
  AUTOR_SEXO text COLLATE utf8mb4_unicode_ci,
  ORIENT_SEX text COLLATE utf8mb4_unicode_ci,
  IDENT_GEN text COLLATE utf8mb4_unicode_ci,
  idDimtempo int NOT NULL,
  idIdade int DEFAULT NULL,
  idEstado int DEFAULT NULL,
  idRaca int DEFAULT NULL,
  idSexo int DEFAULT NULL,
  KEY fk_idDimtempo (idDimtempo),
  KEY idx_mulherr_cidade_correct (DB_CIDADE,UF),
  KEY fk_idade (idIdade),
  KEY fk_estado (idEstado),
  KEY fk_raca (idRaca),
  KEY fk_sexo (idSexo),
  CONSTRAINT FK_dimtempo FOREIGN KEY (idDimtempo) REFERENCES dimtempo (idDimtempo),
  CONSTRAINT fk_estado FOREIGN KEY (idEstado) REFERENCES dimestado (idEstado),
  CONSTRAINT fk_idade FOREIGN KEY (idIdade) REFERENCES dimidade (idIdade),
  CONSTRAINT fk_md_cidade_correct FOREIGN KEY (DB_CIDADE, UF) REFERENCES md (DB_CIDADE, UF),
  CONSTRAINT fk_raca FOREIGN KEY (idRaca) REFERENCES dimraca (idRaca),
  CONSTRAINT fk_sexo FOREIGN KEY (idSexo) REFERENCES dimsexo (idSexo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE dimtempo (
  idDimtempo int NOT NULL,
  data date NOT NULL,
  ano int NOT NULL,
  mes int NOT NULL,
  dia int NOT NULL,
  bimestre int NOT NULL,
  semestre int NOT NULL,
  NomeDia varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  NomeMes varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  FinaldeSemana char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'F',
  PRIMARY KEY (idDimtempo),
  KEY idx_data (data),
  CONSTRAINT dimtempo_chk_1 CHECK ((FinaldeSemana in (_utf8mb4'T',_utf8mb4'F')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE dimtempo (
  idDimtempo int NOT NULL AUTO_INCREMENT,
  data date NOT NULL,
  ano int NOT NULL,
  mes int NOT NULL,
  dia int NOT NULL,
  trimestre int DEFAULT NULL,
  semestre int DEFAULT NULL,
  nomeDia varchar(10) DEFAULT NULL,
  nomeMes varchar(15) DEFAULT NULL,
  finalDeSemana char(1) DEFAULT NULL,
  PRIMARY KEY (idDimtempo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE mulherr (
  id int NOT NULL AUTO_INCREMENT,
  DT_NOTIFIC date DEFAULT NULL,
  NU_IDADE_N int DEFAULT NULL,
  CS_SEXO varchar(50) DEFAULT NULL,
  CS_RACA varchar(50) DEFAULT NULL,
  UF varchar(50) DEFAULT NULL,
  idDimtempo int DEFAULT NULL,
  idIdade int DEFAULT NULL,
  idEstado int DEFAULT NULL,
  idRaca int DEFAULT NULL,
  idSexo int DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_tempo (idDimtempo),
  KEY fk_idade (idIdade),
  KEY fk_estado (idEstado),
  KEY fk_raca (idRaca),
  KEY fk_sexo (idSexo),
  CONSTRAINT fk_tempo FOREIGN KEY (idDimtempo) REFERENCES dimtempo (idDimtempo),
  CONSTRAINT fk_idade FOREIGN KEY (idIdade) REFERENCES dimidade (idIdade),
  CONSTRAINT fk_estado FOREIGN KEY (idEstado) REFERENCES dimestado (idEstado),
  CONSTRAINT fk_raca FOREIGN KEY (idRaca) REFERENCES dimraca (idRaca),
  CONSTRAINT fk_sexo FOREIGN KEY (idSexo) REFERENCES dimsexo (idSexo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE dimraca (
  idRaca int NOT NULL AUTO_INCREMENT,
  raca varchar(50) NOT NULL,
  PRIMARY KEY (idRaca)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE dimestado (
  idEstado int NOT NULL AUTO_INCREMENT,
  estado varchar(50) NOT NULL,
  populacao int DEFAULT NULL,
  PRIMARY KEY (idEstado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE dimidade (
  idIdade int NOT NULL AUTO_INCREMENT,
  faixa_etaria varchar(50) NOT NULL,
  PRIMARY KEY (idIdade)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE md (
  id int NOT NULL AUTO_INCREMENT,
  DB_CIDADE varchar(50) DEFAULT NULL,
  UF varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE dimsexo (
  idSexo int NOT NULL AUTO_INCREMENT,
  sexo varchar(50) NOT NULL,
  PRIMARY KEY (idSexo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--Comandos DQL---

---Evolução da Violência Doméstica por Ano
SELECT t.ano, COUNT(*) AS total_casos
FROM mulherr m
JOIN dimtempo t ON m.idDimtempo = t.idDimtempo
GROUP BY t.ano
ORDER BY t.ano;

---Distribuição de Casos por Estado
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
