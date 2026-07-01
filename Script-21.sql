CREATE TABLE staging_laptops (   ---Criei uma tabela para agregar os dados legados do cliente
    unnamed_0 VARCHAR(50),
    company VARCHAR(100),
    typename VARCHAR(100),
    inches VARCHAR(50),
    screenresolution VARCHAR(255),
    cpu VARCHAR(255),
    ram VARCHAR(50),
    memory VARCHAR(255),
    opsys VARCHAR(100),
    weight VARCHAR(50),
    price VARCHAR(100)
);




CREATE OR REPLACE VIEW v_laptops_clean AS   ----uma VIWE de tratamento de dados
WITH staging_laptops_tratados AS (

	SELECT 
		unnamed_0,
		INITCAP(TRIM(company)) AS company_tratado,
		INITCAP(TRIM(typename)) AS typename_tratado,
		INITCAP(TRIM(cpu)) AS cpu_tratado,
		
		
		NULLIF(NULLIF(TRIM(inches), ''), '?')::DECIMAL(4,1) AS inches_tratado,
		
		INITCAP(TRIM(screenresolution)) AS screenresolution_tratado,
	

		NULLIF(NULLIF(TRIM(REPLACE(UPPER(ram), 'GB', '')), ''), '?')::INT AS ram_tratado,
		
		TRIM(UPPER(memory)) AS memory_tratado,
		INITCAP(TRIM(opsys)) AS opsys_tratado,
		
		
		NULLIF(NULLIF(TRIM(REPLACE(UPPER(weight), 'KG', '')), ''), '?')::DECIMAL(10,2) AS weight_tratado,
		
		
		NULLIF(NULLIF(TRIM(price), ''), '?')::DECIMAL(10,2) AS price_tratado,
		
		INITCAP(TRIM(gpu)) AS gpu_tratado				
	FROM staging_laptops
)
SELECT 
	sl.unnamed_0,
	sl.company_tratado,
	sl.typename_tratado,
	sl.inches_tratado,
	sl.screenresolution_tratado,
	sl.cpu_tratado,
	sl.ram_tratado,
	sl.memory_tratado,
	sl.opsys_tratado,
	sl.weight_tratado,
	sl.price_tratado,
	sl.gpu_tratado
FROM staging_laptops_tratados AS sl;

SELECT * FROM v_laptops_clean

--estas querys são apenas para exemplificar que o tratamento funcionou, assim consigo fazer o resto pelo powe bi
SELECT v.company_tratado
FROM v_laptops_clean AS v
WHERE v.company_tratado LIKE '%Lenovo%';  ---procurar uma empresa em específico


SELECT v.company_tratado,
	AVG(ram_tratado) AS media
FROM v_laptops_clean AS v
GROUP BY v.company_tratado  --- media das memórias rans vendidas conforme as empresas


SELECT v.company_tratado,
	SUM(price_tratado) AS total 
FROM v_laptops_clean AS v
GROUP BY v.company_tratado   ---soma dos produtos vendidos conforme cada empresa





