CREATE DATABASE IF NOT EXISTS enquestas ;
USE enquestas;

CREATE LANGUAGE plpgsql;


CREATE TABLE Empresa(

  id_empresa serial PRIMARY KEY,
  nombre varchar(255) NOT NULL

);


CREATE TABLE enquestadores (

 id_enquestadores serial PRIMARY key,
 localizacion VARCHAR(255) not null,
 id_empresa INT REFERENCES Empresa(id_empresa) ON DELETE CASCADE

);

CREATE TABLE agents (

 id_agents serial PRIMARY key,
 localizacion VARCHAR(255) not null,
 id_empresa INT REFERENCES Empresa(id_empresa) ON DELETE CASCADE

);

CREATE TABLE Usuarios(

  id serial PRIMARY KEY,
  nombre varchar(255) NOT NULL,
  correo VARCHAR(255) NOT null,
  contrasenya VARCHAR(255) NOT null,
 CONSTRAINT correo_valido CHECK (correo ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'),
 created_at TIMESTAMP WITHOUT TIME ZONE ,
 updated_at  TIMESTAMP WITHOUT TIME ZONE , 
 id_enquestadores  INT REFERENCES enquestadores(id_enquestadores) ON DELETE CASCADE ,
 id_agents INT REFERENCES agents(id_agents) ON DELETE CASCADE

 

);


-- Asegúrate de que la extensión pgcrypto esté habilitada
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE OR REPLACE FUNCTION hash_password(input_text VARCHAR) RETURNS VARCHAR AS $$
BEGIN
  RETURN crypt(input_text, gen_salt('bf', 8));  -- Usa la función crypt() con el formato 'bf' para bcrypt
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to automatically hash the password before inserting a new row
CREATE OR REPLACE FUNCTION hash_password_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
  NEW.contrasenya := hash_password(NEW.contrasenya);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER hash_password_trigger
BEFORE INSERT ON Usuarios
FOR EACH ROW
EXECUTE FUNCTION hash_password_trigger_function();


CREATE TABLE encuesta (
  id_encuesta serial PRIMARY KEY,
  Descripcion text NOT NULL,
  data_Creacion date NOT NULL CHECK (data_Creacion >= CURRENT_DATE),
  data_finalizacion date NOT NULL CHECK (data_finalizacion >= CURRENT_DATE AND data_finalizacion > data_Creacion),
  id_empresa INT REFERENCES Empresa(id_empresa) ON DELETE CASCADE

);





CREATE table tipus_pregunta(
    id_tipus serial PRIMARY key,
    tipus varchar(255) not null

);




INSERT INTO tipus_pregunta (id_tipus , tipus) VALUES
(1 , 'slider'),
(2, 'imagen'),
(3, 'text'),
(4, 'si/no');



CREATE TABLE preguntas (
id_pregunta serial PRIMARY key,
enunciado text not  null ,
id_tipus int REFERENCES tipus_pregunta(id_tipus) ON DELETE CASCADE not null

);



CREATE TABLE preguntes_enquestes (
  id_preguntes_enquestes serial PRIMARY KEY,
  id_encuesta INT REFERENCES encuesta(id_encuesta) ON DELETE CASCADE not null,
  id_pregunta INT REFERENCES preguntas(id_pregunta) ON DELETE CASCADE not null
);

CREATE TABLE opciones(

    id_opcion serial PRIMARY key,
    descripcion text,
    id_tipus INT REFERENCES preguntas(id_pregunta) ON DELETE CASCADE not null


);

CREATE TABLE respuestas (

  id_respuesta serial PRIMARY KEY,
  data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL CHECK (data_resposta >= CURRENT_TIMESTAMP),
  id_pregunta int REFERENCES preguntas(id_pregunta) ON DELETE CASCADE not null,
  id_usuarios int  REFERENCES Usuarios(id) ON DELETE CASCADE not null

);

create table informes(
  id_informe serial PRIMARY key,
  usuari INT REFERENCES Usuarios(id) ON DELETE CASCADE,
  enquesta INT REFERENCES encuesta(id_encuesta) ON DELETE CASCADE ,
  company INT REFERENCES Empresa(id_empresa) ON DELETE CASCADE,
  n_preguntas INT 
);



CREATE TABLE informe_encuestas (
    id serial PRIMARY KEY,
    id_encuesta INT,
    id_pregunta INT,
    tipo_pregunta VARCHAR(255),
    cantidad_respuestas INT
);

--  CREATE EXTENSION pgagent;



-- CREATE OR REPLACE FUNCTION generar_informe() RETURNS VOID AS $$
-- DECLARE
--     id_encuesta_temp INT;
--     id_pregunta_temp INT;
--     tipo_pregunta_temp VARCHAR(255);
--     cantidad_respuestas INT;
-- BEGIN
--     -- Limpiar la tabla de informes antes de generar un nuevo informe
--     TRUNCATE TABLE informe_encuestas;
    
--     -- recorrer 
--     FOR id_encuesta_temp IN SELECT id_encuesta FROM encuesta LOOP

--         FOR id_pregunta_temp IN SELECT id_pregunta FROM preguntes_enquestes WHERE id_encuesta = id_encuesta_temp LOOP
   
--             SELECT tipus INTO tipo_pregunta_temp FROM preguntas JOIN tipus_pregunta ON preguntas.id_tipus = tipus_pregunta.id_tipus WHERE preguntas.id_pregunta = id_pregunta_temp;
            
--             IF tipo_pregunta_temp IN ('slider', 'imagen', 'text') THEN
--                 -- Contar la cantidad de respuestas para cada tipo de respuesta
--                 SELECT COUNT(*) INTO cantidad_respuestas FROM respuestas WHERE id_pregunta = id_pregunta_temp;
                
--                 INSERT INTO informe_encuestas (id_encuesta, id_pregunta, tipo_pregunta, cantidad_respuestas) VALUES (id_encuesta_temp, id_pregunta_temp, tipo_pregunta_temp, cantidad_respuestas);
--             END IF;
--         END LOOP;
--     END LOOP;
-- END;
-- $$ LANGUAGE plpgsql;




-- Insertar ejemplo de Empresa
INSERT INTO Empresa ( id_empresa  ,  nombre) VALUES ( 1 , 'empresa_de_ahmed');

-- Insertar ejemplo de Enquestador asociado a un Usuario y una Empresa
INSERT INTO enquestadores (localizacion, id_usuarios, id_empresa) VALUES ('girona', 1, 1);


-- Insertar ejemplo de Usuario
insert into usuarios ( id ,nombre , correo , contrasenya , 1 ,2) values ( 1 , 'samir' , 'samirseraj03@gmail.com' , 'ahmed123');

-- Insertar ejemplo de Encuesta asociada a una Empresa
INSERT INTO encuesta (id_encuesta , Descripcion, data_Creacion, data_finalizacion, id_empresa) VALUES ( 1 , 'Encuesta de satisfacción', '2024-01-01', '2024-02-01', 1);

-- Insertar ejemplo de Pregunta
INSERT INTO preguntas (id_pregunta , enunciado , id_tipus) VALUES (1 , '¿Cómo calificarías nuestro servicio?' , 1);

-- Insertar ejemplo de Tipo de Pregunta
-- ya hemos insertado antes 

-- Insertar ejemplo de Preguntes_Enquestes asociando una Pregunta a una Encuesta
INSERT INTO preguntes_enquestes (id_encuesta, id_pregunta) VALUES (1, 1);

-- Insertar ejemplo de Opcion asociada a una Pregunta
INSERT INTO opciones (descripcion, id_tipus) VALUES ('Muy bueno', 1);

-- Insertar ejemplo de Respuesta asociada a una Pregunta y un Usuario
INSERT INTO respuestas (id_pregunta, id_usuarios) VALUES (1, 1);