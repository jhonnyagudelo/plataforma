CREATE DATABASE plataforma;

-- accion que va a ejecutar el usuario
CREATE TABLE IF NOT EXISTS rol (
    rol_id SERIAL NOT NULL PRIMARY KEY,
    code INT NOT NULL UNIQUE,
    name_rol VARCHAR(25) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TYPE document AS ENUM (
    'C.c',
    'Pasaporte',
    'T.identidad'
);

CREATE TYPE gender AS ENUM(
    'M',
    'F',
    'Otro'
);

CREATE TABLE _user(
    user_id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    image VARCHAR(200),
    state BOOLEAN DEFAULT 'true',
    document_type document NOT NULL,
    gender_type gender NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_rol (
    user_rol_id SERIAL NOT NULL PRIMARY KEY,
    rol_id INT NOT NULL  REFERENCES rol(rol_id),
    user_id INT NOT NULL REFERENCES _user(user_id),
    description VARCHAR(200),
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP    
);


CREATE TABLE IF NOT EXISTS session(
    sesion_id SERIAL NOT NULL PRIMARY KEY,
    user_id INT NOT NULL  REFERENCES _user(user_id),
    start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Los perfiles son el conjunto de caracteristicas para ejecutar acciones
CREATE TABLE IF NOT EXISTS profile(
    profile_id SERIAL NOT NULL PRIMARY KEY,
    code_profile INT NOT NULL UNIQUE,
    name_profile VARCHAR(50) NOT NULL,
    description VARCHAR(150),
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP   
);

CREATE TABLE IF NOT EXISTS user_profile(
    user_profile_id SERIAL NOT NULL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES _user(user_id),
    profile INT NOT NULL REFERENCES profile(profile_id),
    description VARCHAR(100),
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS course(
    course_id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    description VARCHAR(200),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP    
);

CREATE TABLE IF NOT EXISTS class(
    class_id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    image VARCHAR(200) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    description VARCHAR(150) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP      
);

CREATE TABLE IF NOT EXISTS course_class(
    course_class_id SERIAL NOT NULL PRIMARY KEY,
    course_id INT NOT NULL REFERENCES course(course_id),
    class_id INT NOT NULL REFERENCES class(class_id),
    state BOOLEAN DEFAULT 'true',
    description VARCHAR(150) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP   
);

CREATE TABLE IF NOT EXISTS setting(
    setting_id SERIAL NOT NULL PRIMARY KEY,
    class_id INT NOT NULL REFERENCES class(class_id),
    title VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL DEFAULT 'Sin descripcion',
    images  VARCHAR(500),
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS thematic (
    thematic_id SERIAL NOT NULL PRIMARY KEY,
    setting_id INT NOT NULL REFERENCES setting(setting_id),
    title VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL DEFAULT 'Sin descripcion',
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);  

CREATE TABLE IF NOT EXISTS competition(
    competition_id SERIAL NOT NULL PRIMARY KEY,
    setting_id INT NOT NULL REFERENCES setting(setting_id),
    title VARCHAR(50) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS competition_point(
    competition_point_id SERIAL NOT NULL PRIMARY KEY,
    competition_id INT NOT NULL REFERENCES competition(competition_id),
    point VARCHAR(250) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS recommendation(
    recommendation_id SERIAL NOT NULL PRIMARY KEY,
    setting_id INT NOT NULL REFERENCES setting(setting_id),
    title VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL DEFAULT 'Sin descripcion',
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS recommendation_point(
    recommendation_point_id SERIAL NOT NULL PRIMARY KEY,
    recommendation_id INT NOT NULL REFERENCES competition(competition_id),
    point VARCHAR(250) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS project(
    project_id SERIAL NOT NULL PRIMARY KEY,
    class_id INT NOT NULL REFERENCES class(class_id),
    title VARCHAR(50) NOT NULL,
    description VARCHAR(500) NOT NULL DEFAULT 'Sin descripcion',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL CHECK(end_date > start_date),
    images  VARCHAR(500),
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS guide(
    guide_id SERIAL NOT NULL PRIMARY KEY,
    clasd_id INT NOT NULL REFERENCES class(class_id),
    title VARCHAR(50) NOT NULL, 
    description  VARCHAR(500) NOT NULL DEFAULT 'Sin descripcion',
    archive VARCHAR(200) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS repository(
    repository_id SERIAL NOT NULL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES project(project_id),
    title VARCHAR(50) NOT NULL,
    description  VARCHAR(500) NOT NULL DEFAULT 'Sin descripcion',
    archive VARCHAR(200) NOT NULL,
    state BOOLEAN DEFAULT 'true',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

------------------> insert <---------------
INSERT INTO rol (code, name_rol) VALUES (01, 'Director'),(02,'Docente'),(03,'Cadete'),(04, 'Administrador');
INSERT INTO rol (code, name_rol) VALUES (03, 'Administrador');

INSERT INTO profiles (code, name_profile, description) VALUES (01, 'Director', 'El encargado de dirigir las actividades a realizar en la carrera es quién toma las desiciones y establece los tiempos de entregas de las actividades'),(02, 'Docente', 'Da los lineamientos, asesora y corrige las actividades a desarrollar como tambien realiza seguimiento para que las actividades se presenten en los tiempos establecidos'), (03, 'Cadete', 'La persona que tiene un interes por cierto tema o cierta carrera el cual busca aprender y asesorarse para adquirir o fortalecer sus capacidades' ), (04, 'Administrador','Es el responsable de gestionar y conservar los datos del aplicativo');

insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Arel', 'Rastall', '(455) 9784676', '1936/07/06', 'arastall0@hibu.`.fake', 'WMOkinGTB7Yk', 'M', 'C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Myca', 'Wasielewski', '(940) 8512852', '1929/08/22', 'mwasielewski1@nationalgeographic.`.fake', 'Qvvary', 'M','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Ruby', 'Vaneschi', '(244) 5353229', '1893/02/01', 'rvaneschi2@netscape.`.fake', '3nNJ0cc', 'F','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Kirstin', 'Blakely', '(378) 6430790', '1984/06/06', 'kblakely3@earthlink.`.fake', '7f87O2uI3y', 'F','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Kenny', 'Paul', '(631) 1195608', '1886/02/14', 'kpaul4@cpanel.`.fake', 'fw4oWjL3n', 'M','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Evy', 'Broek', '(618) 3559063', '1913/09/15', 'ebroek5@t-online.`.fake', 'NGteAsyrmZX', 'F','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Smith', 'Anstice', '(486) 5208386', '1939/07/01', 'sanstice6@boston.`.fake', 'BUy3kRt', 'M','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Benjie', 'Bateman', '(799) 7509674', '1944/08/09', 'bbateman7@ustream.`.fake', '0f6ECDH', 'M','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Maribeth', 'Jarrett', '(658) 6611061', '1986/03/10', 'mjarrett8@ihg.`.fake', '4D8MFnH1', 'F','C.c');
insert into _user (name, last_name, phone, birth_date, email, password, gender_type, document_type) values ('Inger', 'Feldon', '(353) 7356805', '1916/02/29', 'ifeldon9@admin.`.fake', '2vXq4kUE', 'M','C.c');

INSERT INTO user_rol (rol_id, user_id) VALUES (1,1),(2,1),(2,5),(2,10),(2,3),(3,2),(3,4),(3,6)(3,7),(3,8),(3,9),(5,1);

INSERT INTO user_profile(profile, user_id) VALUES(4,1); (1,1),(2,1),(2,5),(2,10),(2,3),(3,2),(3,4),(3,6),(3,7),(3,8),(3,9),(4,1);



INSERT INTO course(name) VALUES ('Ingeniería informatica'),('Ingeniería mecánica'),('Administración aeronautica')
INSERT INTO class(name) VALUES ("Gestion de investigacion");
INSERT INTO course_class(course_id, class_id) VALUES (1,1),(2,1)(3,1);

INSERT INTO sentting(title, class_id, description) VALUES ('Ambientacion', 2, 'En los siguientes segmentos encontrará la Ambientación, las competencias del espacio, las recomendaciones metodológicas');
INSERT INTO competition (setting_id, title) VALUES (1,'Competencias del espacio de aprendizaje');

INSERT INTO competition_point (competition_id, point) VALUES (1,'Liderar'),(1,'Coordinar'),(1,'Innovar');

INSERT INTO recommendation (setting_id, title, descripTion) VALUES (1,'Recomendaciones generales', 'Apreciado estudiante, en nombre del Programa Académico, le doy la más cordial bienvenida a este espacio creado para apoyar el desarrollo académico en esta metodología de, Por favor lea con atención las siguientes sugerencias que serán de gran ayuda para iniciar el proceso académico en la asignatura');
INSERT INTO recommendation_point(recommendation_id, point) VALUES (1,'Antes de iniciar el desarrollo de cada una de las actividades propuestas, por favor lea con cuidado todos los momentos que a continuación se describen, para tener una visión global de la pretensión de este espacio de aprendizaje, así como de las actividades que debe realizar y los tiempos programados para ellas'),
                                                                  (1,'Es fundamental para el éxito de este espacio de aprendizaje establecer una permanente comunicación con su docente,'),
                                                                  (1,'Todas las actividades propuestas deben realizarse. Para tal efecto, es importante que realice una programación de las actividades y el tiempo que requiere para su ejecución'),
                                                                  (1,'Descargue las lecturas y actividades propuestas. Asímismo, debe guardar una copia de estas en la unidad de almacenamiento de la cual disponga (su computador, memoria USB o disco duro)');





-----Consultas-----------
SELECT     
    u.name ||', '|| u.last_name AS nombre_completo
    ,r.name_rol
    ,p.description
        
    FROM _user u
        INNER JOIN user_rol u_r
            ON u.user_id = u_r.user_id

        INNER JOIN rol r
            ON u_r.rol_id = r.rol_id

        INNER JOIN profile p
            ON  p.name_profile = r.name_rol
    WHERE TRUE
    and u.name = 'Arel'
    order by nombre_completo


  SELECT 
    c.name
    ,c_s.name
           