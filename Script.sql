-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DB_EDUCACION_ESPECIAL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DB_EDUCACION_ESPECIAL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DB_EDUCACION_ESPECIAL` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `DB_EDUCACION_ESPECIAL` ;

-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Areas_curriculares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Areas_curriculares` (
  `Id_area_curricular` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única de registro de área curricular',
  `nombre_area` VARCHAR(75) NOT NULL COMMENT 'Nombre del área curricular necesario para el área de informes',
  `activo` ENUM('1', '0') NULL DEFAULT '1',
  PRIMARY KEY (`Id_area_curricular`),
  UNIQUE INDEX `Areas_curriculares_UNIQUE` (`Id_area_curricular` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Nivel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Nivel` (
  `Id_nivel` INT NOT NULL AUTO_INCREMENT,
  `nombre_nivel` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_nivel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Grados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Grados` (
  `Id_grado` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de los grados que utlizan los centros educativos ',
  `nombre_grado` VARCHAR(45) NULL COMMENT 'Nombre de grados de los centros educativos',
  `Nivel_Id_nivel` INT NOT NULL,
  PRIMARY KEY (`Id_grado`),
  INDEX `fk_Grados_Nivel1_idx` (`Nivel_Id_nivel` ASC) VISIBLE,
  CONSTRAINT `fk_Grados_Nivel1`
    FOREIGN KEY (`Nivel_Id_nivel`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Nivel` (`Id_nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Secciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Secciones` (
  `Id_seccion` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de tipo de persona',
  `nombre_seccion` TINYTEXT NULL COMMENT 'Nombre de las secciones de los centros educativos',
  `Grados_Id_grado` INT NOT NULL,
  PRIMARY KEY (`Id_seccion`),
  INDEX `fk_Secciones_Grados1_idx` (`Grados_Id_grado` ASC) VISIBLE,
  CONSTRAINT `fk_Secciones_Grados1`
    FOREIGN KEY (`Grados_Id_grado`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Grados` (`Id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Sectores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Sectores` (
  `Id_sector` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de los sectores',
  `nombre_sector` VARCHAR(45) NULL COMMENT 'Nombre del sector',
  PRIMARY KEY (`Id_sector`),
  UNIQUE INDEX `Id_sector_UNIQUE` (`Id_sector` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`departamentos` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro del los departamentos',
  `name` VARCHAR(30) NOT NULL COMMENT 'Nombre del departamento',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Id_departamento_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`municipios` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de municipios',
  `departamento_Id` INT NOT NULL COMMENT 'Clave foránea para ligar a los municipios a un departamento',
  `name` VARCHAR(30) NOT NULL COMMENT 'Nombre del municipio',
  PRIMARY KEY (`Id`),
  INDEX `fk_Municipios_Departamentos1_idx` (`departamento_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Municipios_Departamentos1`
    FOREIGN KEY (`departamento_Id`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`departamentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Centros_educativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Centros_educativos` (
  `Id_centro_educativo` VARCHAR(300) NOT NULL COMMENT 'Clave única para registro de centros educativos',
  `nombre_centro_educativo` VARCHAR(200) NULL COMMENT 'Nombre del centro educativo ',
  `direccion` VARCHAR(75) NULL COMMENT 'Direccion del centro educativo ',
  `telefono` INT(8) NULL COMMENT 'Numero telefónico del centro educativo',
  `correo` VARCHAR(45) NULL,
  `modalidad` ENUM('Monolingüe', 'Bilingüe') NULL,
  `Sectores_Id_sector` INT NULL COMMENT 'Clave foránea para ligar a un sector al informe al centro educativo ',
  `departamentos_id` INT NOT NULL,
  `Municipios_Id_municipio` INT NOT NULL COMMENT 'Clave foránea para ligar a un municipio al informe al centro educativo ',
  PRIMARY KEY (`Id_centro_educativo`),
  UNIQUE INDEX `Id_centro_educativo_UNIQUE` (`Id_centro_educativo` ASC) VISIBLE,
  INDEX `fk_Centros_educativos_Sectores1_idx` (`Sectores_Id_sector` ASC) VISIBLE,
  INDEX `fk_Centros_educativos_Municipios1_idx` (`Municipios_Id_municipio` ASC) VISIBLE,
  INDEX `fk_Centros_educativos_departamentos1_idx` (`departamentos_id` ASC) VISIBLE,
  CONSTRAINT `fk_Centros_educativos_Sectores1`
    FOREIGN KEY (`Sectores_Id_sector`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Sectores` (`Id_sector`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Centros_educativos_Municipios1`
    FOREIGN KEY (`Municipios_Id_municipio`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`municipios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Centros_educativos_departamentos1`
    FOREIGN KEY (`departamentos_id`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`departamentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Comunidades_etnicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Comunidades_etnicas` (
  `Id_comunidad_etnica` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de las comunidades étnicas',
  `nombre` VARCHAR(250) NOT NULL COMMENT 'Nombre de las comunidades étnicas ',
  PRIMARY KEY (`Id_comunidad_etnica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Personas` (
  `Id_persona` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de personas',
  `nombres` VARCHAR(75) NOT NULL COMMENT 'Nombres del empleado',
  `apellidos` VARCHAR(75) NOT NULL COMMENT 'Apellidos del empleado',
  `fecha_nacimiento` DATE NOT NULL COMMENT 'Fecha de nacimiento de la persona ',
  `telefono` INT(8) NULL COMMENT 'Numero telefónico de la persona',
  `correo` VARCHAR(45) NULL COMMENT 'Correo de empleado',
  `sexo` ENUM('M', 'F', 'Otro') NOT NULL COMMENT 'Sexo del empleado',
  `activo` ENUM('1', '0') NULL DEFAULT '1',
  PRIMARY KEY (`Id_persona`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Estudiantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Estudiantes` (
  `Id_estudiante` VARCHAR(300) NOT NULL COMMENT 'Clave única para registro de estudiantes',
  `Comunidades_etnicas_Id_comunidad` INT NOT NULL COMMENT 'Clave foránea para ligar estudiantes a las comunidades étnicas ',
  `Personas_Id_persona` INT NOT NULL COMMENT 'Clave foránea para ligar estudiantes con las personas',
  PRIMARY KEY (`Id_estudiante`),
  INDEX `fk_Estudiantes_Comunidades_etnicas1_idx` (`Comunidades_etnicas_Id_comunidad` ASC) VISIBLE,
  INDEX `fk_Estudiantes_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_Estudiantes_Comunidades_etnicas1`
    FOREIGN KEY (`Comunidades_etnicas_Id_comunidad`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Comunidades_etnicas` (`Id_comunidad_etnica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estudiantes_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`inscripciones` (
  `Id_inscripcion` INT NOT NULL AUTO_INCREMENT,
  `resultado` VARCHAR(45) NULL COMMENT 'Resultado del estudiante en base al ciclo académico',
  `obvservacion` VARCHAR(45) NULL COMMENT 'Observaciones de inscripción ',
  `ciclo_academico` VARCHAR(45) NULL COMMENT 'Ciclo académico de inscripción ',
  `jornada` ENUM('Matutina ', 'Vespertina ', 'Nocturna ') NULL,
  `Nivel_Id_nivel` INT NOT NULL,
  `Grados_Id_grado` INT NOT NULL,
  `Secciones_Id_seccion` INT NOT NULL COMMENT 'Clave foránea para ligar a una sección a la inscripción',
  `Centros_educativos_Id_centro_educativo` VARCHAR(300) NOT NULL COMMENT 'Clave foránea para ligar a un estudiante a un centro educativo ',
  `Estudiantes_Id_estudiante` VARCHAR(300) NOT NULL COMMENT 'Clave foránea para ligar a un estudiante a la inscripción',
  INDEX `fk_inscripciones_Secciones1_idx` (`Secciones_Id_seccion` ASC) VISIBLE,
  INDEX `fk_inscripciones_Centros_educativos1_idx` (`Centros_educativos_Id_centro_educativo` ASC) VISIBLE,
  INDEX `fk_inscripciones_Estudiantes1_idx` (`Estudiantes_Id_estudiante` ASC) VISIBLE,
  PRIMARY KEY (`Id_inscripcion`),
  INDEX `fk_inscripciones_Nivel1_idx` (`Nivel_Id_nivel` ASC) VISIBLE,
  INDEX `fk_inscripciones_Grados1_idx` (`Grados_Id_grado` ASC) VISIBLE,
  CONSTRAINT `fk_inscripciones_Secciones1`
    FOREIGN KEY (`Secciones_Id_seccion`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Secciones` (`Id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripciones_Centros_educativos1`
    FOREIGN KEY (`Centros_educativos_Id_centro_educativo`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Centros_educativos` (`Id_centro_educativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripciones_Estudiantes1`
    FOREIGN KEY (`Estudiantes_Id_estudiante`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Estudiantes` (`Id_estudiante`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inscripciones_Nivel1`
    FOREIGN KEY (`Nivel_Id_nivel`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Nivel` (`Id_nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripciones_Grados1`
    FOREIGN KEY (`Grados_Id_grado`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Grados` (`Id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (
  `Id_info_adec_curriculares` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de los informes de adecuaciones curriculares',
  `ciclo` VARCHAR(45) NOT NULL COMMENT 'ciclo académico del informe de adecuaciones curriculares',
  `lugar` VARCHAR(75) NOT NULL COMMENT 'lugar del informe de adecuaciones curriculares',
  `observaciones` VARCHAR(200) NULL COMMENT 'observaciones específicas sobre el informe de adecuaciones curriculares',
  `observacion_general` VARCHAR(200) NULL COMMENT 'Observación general sobre el informe de adecuaciones curriculares',
  `acciones` VARCHAR(200) NULL COMMENT 'acciones ',
  `alcance` VARCHAR(200) NULL,
  `estrategia_pedagogica` VARCHAR(45) NULL COMMENT 'Estrategia utilizada',
  `fecha` DATE NOT NULL COMMENT 'Fecha de creación del informe de adecuaciones curriculares',
  `inscripciones_Id_inscripcion` INT NOT NULL,
  `comentario` VARCHAR(300) NULL,
  `fortalezas` VARCHAR(200) NULL,
  `dificultades` VARCHAR(200) NULL,
  `recomendaciones` VARCHAR(200) NULL,
  `opcional` VARCHAR(200) NULL,
  `tipo` INT NOT NULL,
  `forma` INT NOT NULL,
  `discapacidad_multiple` VARCHAR(100) NULL,
  `Trastornos_generalizados` VARCHAR(100) NULL,
  `otro_programa_modalidad` VARCHAR(45) NULL,
  `otros_b` VARCHAR(45) NULL,
  `otras_modalidades_programas` VARCHAR(100) NULL,
  `nivel` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_info_adec_curriculares`),
  UNIQUE INDEX `Id_info_adec_curriculares_UNIQUE` (`Id_info_adec_curriculares` ASC) VISIBLE,
  INDEX `fk_Informes_adecuaciones_curriculares_inscripciones1_idx` (`inscripciones_Id_inscripcion` ASC) VISIBLE,
  CONSTRAINT `fk_Informes_adecuaciones_curriculares_inscripciones1`
    FOREIGN KEY (`inscripciones_Id_inscripcion`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`inscripciones` (`Id_inscripcion`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Area_informes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Area_informes` (
  `Id_area_informe` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de la unión de áreas curriculares y los informes de adecuación',
  `activo` ENUM('1', '0') NOT NULL DEFAULT '0',
  `Areas_curriculares_Id_area_curricular` INT NOT NULL,
  `Informes_adecuaciones_curriculares_Id_info_adec_curriculares` INT NOT NULL,
  `Elemento` INT NULL,
  PRIMARY KEY (`Id_area_informe`),
  UNIQUE INDEX `Id_area_informe_UNIQUE` (`Id_area_informe` ASC) VISIBLE,
  INDEX `fk_Area_informes_Areas_curriculares1_idx` (`Areas_curriculares_Id_area_curricular` ASC) VISIBLE,
  INDEX `fk_Area_informes_Informes_adecuaciones_curriculares1_idx` (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares` ASC) VISIBLE,
  CONSTRAINT `fk_Area_informes_Areas_curriculares1`
    FOREIGN KEY (`Areas_curriculares_Id_area_curricular`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Areas_curriculares` (`Id_area_curricular`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Area_informes_Informes_adecuaciones_curriculares1`
    FOREIGN KEY (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (`Id_info_adec_curriculares`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Programas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Programas` (
  `Id_programa` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de programas',
  `nombre_programa` VARCHAR(100) NULL COMMENT 'Nombre del programa al que va estar ligado el usuario ',
  PRIMARY KEY (`Id_programa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Usuarios` (
  `Id_usuario` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de usuarios',
  `fecha_contratacion` DATE NULL COMMENT 'Fecha de contratacion de usuarios',
  `usuario` VARCHAR(45) NOT NULL COMMENT 'Nombre de usuario para para ingresar al sistema con ciertos privilegios ',
  `clave` VARCHAR(45) NOT NULL COMMENT 'Clave de usuario para para ingresar al sistema con ciertos privilegios ',
  `Personas_Id_persona` INT NOT NULL COMMENT 'Clave foránea para ligar usuarios y personas ',
  `Tipo_persona_persona_Id_tipo_persona` INT NOT NULL,
  `Programas_Id_programa` INT NOT NULL,
  PRIMARY KEY (`Id_usuario`),
  INDEX `fk_Usuarios_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC) VISIBLE,
  INDEX `fk_Usuarios_Programas1_idx` (`Programas_Id_programa` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Programas1`
    FOREIGN KEY (`Programas_Id_programa`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Programas` (`Id_programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Cronograma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Cronograma` (
  `Id_cronograma` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para los cronogramas',
  `fecha` DATE NOT NULL COMMENT 'Fecha de creación de cronogramas',
  `descripcion` VARCHAR(300) NOT NULL COMMENT 'Descripción de los cronogramas',
  `Usuarios_Id_usuario` INT NOT NULL,
  `archivo1` LONGTEXT NULL,
  PRIMARY KEY (`Id_cronograma`),
  INDEX `fk_Cronograma_Usuarios1_idx` (`Usuarios_Id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Cronograma_Usuarios1`
    FOREIGN KEY (`Usuarios_Id_usuario`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Usuarios` (`Id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Noticias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Noticias` (
  `Id_noticias` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para las noticias creadas por los usuarios ',
  `titulo` VARCHAR(45) NOT NULL COMMENT 'Titulo de la noticia ',
  `descripcion` VARCHAR(300) NOT NULL COMMENT 'Espacio para redacción de noticia',
  `fecha` DATE NULL COMMENT 'Fecha de creacion de la noticia ',
  `Usuarios_Id_usuario` INT NULL COMMENT 'Clave foránea para conocer al creador de las noticias  ',
  `archivo` LONGTEXT NULL,
  PRIMARY KEY (`Id_noticias`),
  INDEX `fk_Noticias_Usuarios1_idx` (`Usuarios_Id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Noticias_Usuarios1`
    FOREIGN KEY (`Usuarios_Id_usuario`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Usuarios` (`Id_usuario`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Recursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Recursos` (
  `Id_recursos` INT NOT NULL COMMENT 'Clave única para los recursos creados por los usuarios ',
  `nombre_archivo` VARCHAR(45) NOT NULL COMMENT 'Nombre del archivo subido por usuarios',
  `archivo` LONGTEXT NOT NULL COMMENT 'Espacio para archivo',
  `fecha_publicacion` DATE NOT NULL COMMENT 'Fecha de publicación de los recursos',
  `Usuarios_Id_usuario` INT NOT NULL COMMENT ' Clave foránea para conocer al usuario que sube el archivo',
  PRIMARY KEY (`Id_recursos`),
  INDEX `fk_Recursos_Usuarios1_idx` (`Usuarios_Id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Recursos_Usuarios1`
    FOREIGN KEY (`Usuarios_Id_usuario`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Usuarios` (`Id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Agendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Agendas` (
  `Id_agenda` INT NOT NULL COMMENT 'Clave única para las agendas creadas por los usuarios ',
  `actividad` VARCHAR(45) NULL COMMENT 'Actividad de agenda ',
  `fecha_inicial` DATETIME NULL COMMENT 'Fecha de actividad',
  `Usuarios_Id_usuario` INT NOT NULL COMMENT 'Clave foránea para conocer al creador de la agenda ',
  `fecha_final` DATETIME NULL,
  `color` VARCHAR(50) NULL,
  `titulo` VARCHAR(300) NULL,
  PRIMARY KEY (`Id_agenda`),
  INDEX `fk_Agendas_Usuarios1_idx` (`Usuarios_Id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Agendas_Usuarios1`
    FOREIGN KEY (`Usuarios_Id_usuario`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Usuarios` (`Id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Infraescritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Infraescritos` (
  `Id_insfraescrito` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave única para registro de la unión de informes de adecuaciones curriculares y las personas',
  `Personas_Id_persona` INT NOT NULL COMMENT 'Clave foránea para ligar personas a informes de adecuaciones curriculares',
  `Informes_adecuaciones_curriculares_Id_info_adec_curriculares` INT NOT NULL,
  PRIMARY KEY (`Id_insfraescrito`),
  INDEX `fk_Infraescritos_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  INDEX `fk_Infraescritos_Informes_adecuaciones_curriculares1_idx` (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares` ASC) VISIBLE,
  CONSTRAINT `fk_Infraescritos_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Infraescritos_Informes_adecuaciones_curriculares1`
    FOREIGN KEY (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (`Id_info_adec_curriculares`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Maestros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Maestros` (
  `Id_maestro` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clave única de registro de tipo de maestros',
  `Personas_Id_persona` INT NOT NULL COMMENT 'Clave foránea para ligar al maestro que impartirá clases a un alumno',
  `codigo_personal` VARCHAR(45) NULL,
  `Grados_Id_grado` INT NOT NULL,
  `Secciones_Id_seccion` INT NOT NULL,
  `tipo` ENUM('M', 'T', 'F') NOT NULL,
  PRIMARY KEY (`Id_maestro`),
  INDEX `fk_Maestros_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  INDEX `fk_Maestros_Grados1_idx` (`Grados_Id_grado` ASC) VISIBLE,
  INDEX `fk_Maestros_Secciones1_idx` (`Secciones_Id_seccion` ASC) VISIBLE,
  CONSTRAINT `fk_Maestros_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maestros_Grados1`
    FOREIGN KEY (`Grados_Id_grado`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Grados` (`Id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maestros_Secciones1`
    FOREIGN KEY (`Secciones_Id_seccion`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Secciones` (`Id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Responsables_CREI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Responsables_CREI` (
  `Id_responsable_CREI` INT NOT NULL AUTO_INCREMENT,
  `Personas_Id_persona` INT NOT NULL,
  `municipios_Id` INT NOT NULL,
  PRIMARY KEY (`Id_responsable_CREI`),
  INDEX `fk_Responsables_CREI_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  INDEX `fk_Responsables_CREI_municipios1_idx` (`municipios_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Responsables_CREI_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Responsables_CREI_municipios1`
    FOREIGN KEY (`municipios_Id`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`municipios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Directores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Directores` (
  `Id_director` INT NOT NULL AUTO_INCREMENT,
  `Personas_Id_persona` INT NOT NULL,
  PRIMARY KEY (`Id_director`),
  INDEX `fk_Directores_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_Directores_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Supervisores_educativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Supervisores_educativos` (
  `Id_supervisor_educativo` INT NOT NULL AUTO_INCREMENT,
  `Personas_Id_persona` INT NOT NULL,
  `municipios_Id` INT NOT NULL,
  PRIMARY KEY (`Id_supervisor_educativo`),
  INDEX `fk_Supervisores_educativos_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  INDEX `fk_Supervisores_educativos_municipios1_idx` (`municipios_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Supervisores_educativos_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supervisores_educativos_municipios1`
    FOREIGN KEY (`municipios_Id`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`municipios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Coordinadores_educacion_especial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Coordinadores_educacion_especial` (
  `Id_coordinador_educacion_especial` INT NOT NULL AUTO_INCREMENT,
  `Personas_Id_persona` INT NOT NULL,
  `departamentos_id` INT NOT NULL,
  PRIMARY KEY (`Id_coordinador_educacion_especial`),
  INDEX `fk_Coordinadores_educacion_especial_Personas1_idx` (`Personas_Id_persona` ASC) VISIBLE,
  INDEX `fk_Coordinadores_educacion_especial_departamentos1_idx` (`departamentos_id` ASC) VISIBLE,
  CONSTRAINT `fk_Coordinadores_educacion_especial_Personas1`
    FOREIGN KEY (`Personas_Id_persona`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Personas` (`Id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Coordinadores_educacion_especial_departamentos1`
    FOREIGN KEY (`departamentos_id`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`departamentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`maestro_centro_educativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`maestro_centro_educativo` (
  `Id_mastro_centro_educativo` INT NOT NULL AUTO_INCREMENT,
  `Maestros_Id_maestro` INT UNSIGNED NOT NULL,
  `Centros_educativos_Id_centro_educativo` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`Id_mastro_centro_educativo`),
  INDEX `fk_Mastro_centro_educativo_Maestros1_idx` (`Maestros_Id_maestro` ASC) VISIBLE,
  INDEX `fk_Mastro_centro_educativo_Centros_educativos1_idx` (`Centros_educativos_Id_centro_educativo` ASC) VISIBLE,
  CONSTRAINT `fk_Mastro_centro_educativo_Maestros1`
    FOREIGN KEY (`Maestros_Id_maestro`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Maestros` (`Id_maestro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mastro_centro_educativo_Centros_educativos1`
    FOREIGN KEY (`Centros_educativos_Id_centro_educativo`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Centros_educativos` (`Id_centro_educativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Jornadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Jornadas` (
  `Id_jornada` INT NOT NULL AUTO_INCREMENT,
  `nombre_jornada` VARCHAR(45) NOT NULL,
  `Directores_Id_director` INT NOT NULL,
  `Centros_educativos_Id_centro_educativo` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`Id_jornada`),
  INDEX `fk_Jornadas_Directores1_idx` (`Directores_Id_director` ASC) VISIBLE,
  INDEX `fk_Jornadas_Centros_educativos1_idx` (`Centros_educativos_Id_centro_educativo` ASC) VISIBLE,
  CONSTRAINT `fk_Jornadas_Directores1`
    FOREIGN KEY (`Directores_Id_director`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Directores` (`Id_director`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jornadas_Centros_educativos1`
    FOREIGN KEY (`Centros_educativos_Id_centro_educativo`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Centros_educativos` (`Id_centro_educativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`necesidades_educativas_especiales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`necesidades_educativas_especiales` (
  `Id_necesidad_educativa_especial` INT NOT NULL AUTO_INCREMENT,
  `discapacidad_visual` INT NULL,
  `sistema_braille` INT NULL,
  `dispacidad_auditiva` INT NULL,
  `aparata_auditivo` INT NULL,
  `lengua_senias` INT NULL,
  `opciones` INT NULL,
  `Informes_adecuaciones_curriculares_Id_info_adec_curriculares` INT NOT NULL,
  PRIMARY KEY (`Id_necesidad_educativa_especial`),
  INDEX `fk_necesidades_educativas_especiales_Informes_adecuaciones__idx` (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares` ASC) VISIBLE,
  CONSTRAINT `fk_necesidades_educativas_especiales_Informes_adecuaciones_cu1`
    FOREIGN KEY (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (`Id_info_adec_curriculares`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`areas_curriculares_2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`areas_curriculares_2` (
  `Id_area_curricular_2` INT NOT NULL AUTO_INCREMENT,
  `nombre_area` VARCHAR(45) NOT NULL,
  `activo` ENUM('0', '1') NULL DEFAULT '1',
  `Nivel_Id_nivel` INT NOT NULL,
  PRIMARY KEY (`Id_area_curricular_2`),
  INDEX `fk_areas_curriculares_2_Nivel1_idx` (`Nivel_Id_nivel` ASC) VISIBLE,
  CONSTRAINT `fk_areas_curriculares_2_Nivel1`
    FOREIGN KEY (`Nivel_Id_nivel`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Nivel` (`Id_nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Asignaturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Asignaturas` (
  `Id_asignatura` INT NOT NULL AUTO_INCREMENT,
  `contenidos` VARCHAR(45) NULL,
  `indicadores` VARCHAR(45) NULL,
  `actividades` VARCHAR(45) NULL,
  `metodologia` VARCHAR(45) NULL,
  `evaluacion` VARCHAR(45) NULL,
  `fortalezas` VARCHAR(45) NULL,
  `dificultades` VARCHAR(45) NULL,
  `Maestros_Id_maestro` INT UNSIGNED NULL,
  `Informes_adecuaciones_curriculares_Id_info_adec_curriculares` INT NOT NULL,
  `areas_curriculares_2_Id_area_curricular_2` INT NOT NULL,
  PRIMARY KEY (`Id_asignatura`),
  INDEX `fk_Asignaturas_Maestros1_idx` (`Maestros_Id_maestro` ASC) VISIBLE,
  INDEX `fk_Asignaturas_Informes_adecuaciones_curriculares1_idx` (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares` ASC) VISIBLE,
  INDEX `fk_Asignaturas_areas_curriculares_21_idx` (`areas_curriculares_2_Id_area_curricular_2` ASC) VISIBLE,
  CONSTRAINT `fk_Asignaturas_Maestros1`
    FOREIGN KEY (`Maestros_Id_maestro`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Maestros` (`Id_maestro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asignaturas_Informes_adecuaciones_curriculares1`
    FOREIGN KEY (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (`Id_info_adec_curriculares`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asignaturas_areas_curriculares_21`
    FOREIGN KEY (`areas_curriculares_2_Id_area_curricular_2`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`areas_curriculares_2` (`Id_area_curricular_2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`programas_informes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`programas_informes` (
  `Id_programa` INT NOT NULL AUTO_INCREMENT,
  `CEMUCAF` INT NULL,
  `NUFED` INT NULL DEFAULT '1',
  `PEPS` INT NULL,
  `Informes_adecuaciones_curriculares_Id_info_adec_curriculares` INT NOT NULL,
  PRIMARY KEY (`Id_programa`),
  INDEX `fk_programas_Informes_adecuaciones_curriculares1_idx` (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares` ASC) VISIBLE,
  CONSTRAINT `fk_programas_Informes_adecuaciones_curriculares1`
    FOREIGN KEY (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (`Id_info_adec_curriculares`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`carrera` (
  `Id_carrera` INT NOT NULL AUTO_INCREMENT,
  `nombre_carrera` VARCHAR(150) NULL,
  PRIMARY KEY (`Id_carrera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Estudiante_carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Estudiante_carrera` (
  `Id_informe_carrera` INT NOT NULL AUTO_INCREMENT,
  `Estudiantes_Id_estudiante` VARCHAR(300) NOT NULL,
  `carrera_Id_carrera` INT NOT NULL,
  PRIMARY KEY (`Id_informe_carrera`),
  INDEX `fk_Estudiante_carrera_Estudiantes1_idx` (`Estudiantes_Id_estudiante` ASC) VISIBLE,
  INDEX `fk_Estudiante_carrera_carrera1_idx` (`carrera_Id_carrera` ASC) VISIBLE,
  CONSTRAINT `fk_Estudiante_carrera_Estudiantes1`
    FOREIGN KEY (`Estudiantes_Id_estudiante`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Estudiantes` (`Id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estudiante_carrera_carrera1`
    FOREIGN KEY (`carrera_Id_carrera`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`carrera` (`Id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`necesidades_educativas_especiales_2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`necesidades_educativas_especiales_2` (
  `Id_necesidad_educativa_especial_2` INT NOT NULL AUTO_INCREMENT,
  `dificultades_lenguaje` INT NULL,
  `dificultades_aprendizaje` INT NULL,
  `superdotacion` INT NULL,
  `Informes_adecuaciones_curriculares_Id_info_adec_curriculares` INT NOT NULL,
  PRIMARY KEY (`Id_necesidad_educativa_especial_2`),
  INDEX `fk_necesidades_educativas_especiales_2_Informes_adecuacione_idx` (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares` ASC) VISIBLE,
  CONSTRAINT `fk_necesidades_educativas_especiales_2_Informes_adecuaciones_1`
    FOREIGN KEY (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (`Id_info_adec_curriculares`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Componentes_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Componentes_area` (
  `Id_componente` INT NOT NULL AUTO_INCREMENT,
  `nombre_componente_area` VARCHAR(100) NOT NULL,
  `areas_curriculares_2_Id_area_curricular_2` INT NOT NULL,
  INDEX `fk_Componentes_area_areas_curriculares_21_idx` (`areas_curriculares_2_Id_area_curricular_2` ASC) VISIBLE,
  PRIMARY KEY (`Id_componente`),
  CONSTRAINT `fk_Componentes_area_areas_curriculares_21`
    FOREIGN KEY (`areas_curriculares_2_Id_area_curricular_2`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`areas_curriculares_2` (`Id_area_curricular_2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`asignaturas_2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`asignaturas_2` (
  `Id_asignatura_2` INT NOT NULL AUTO_INCREMENT,
  `contenidos` VARCHAR(45) NULL,
  `indicadores` VARCHAR(45) NULL,
  `actividades` VARCHAR(45) NULL,
  `metodologia` VARCHAR(45) NULL,
  `evaluacion` VARCHAR(45) NULL,
  `activo` VARCHAR(45) NULL,
  `areas_curriculares_2_Id_area_curricular_2` INT NOT NULL,
  `Informes_adecuaciones_curriculares_Id_info_adec_curriculares` INT NOT NULL,
  `Componentes_area_Id_componente` INT NULL,
  PRIMARY KEY (`Id_asignatura_2`),
  INDEX `fk_asignaturas_2_areas_curriculares_21_idx` (`areas_curriculares_2_Id_area_curricular_2` ASC) VISIBLE,
  INDEX `fk_asignaturas_2_Informes_adecuaciones_curriculares1_idx` (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares` ASC) VISIBLE,
  INDEX `fk_asignaturas_2_Componentes_area1_idx` (`Componentes_area_Id_componente` ASC) VISIBLE,
  CONSTRAINT `fk_asignaturas_2_areas_curriculares_21`
    FOREIGN KEY (`areas_curriculares_2_Id_area_curricular_2`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`areas_curriculares_2` (`Id_area_curricular_2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignaturas_2_Informes_adecuaciones_curriculares1`
    FOREIGN KEY (`Informes_adecuaciones_curriculares_Id_info_adec_curriculares`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Informes_adecuaciones_curriculares` (`Id_info_adec_curriculares`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignaturas_2_Componentes_area1`
    FOREIGN KEY (`Componentes_area_Id_componente`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Componentes_area` (`Id_componente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Solicitudes_becas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Solicitudes_becas` (
  `Id_solicitud` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('Aprobada', 'Pendiente', 'Rechazado') NULL,
  `Estudiantes_Id_estudiante` VARCHAR(300) NOT NULL,
  `archivo` LONGTEXT NULL,
  `ciclo` INT NULL,
  PRIMARY KEY (`Id_solicitud`),
  INDEX `fk_Solicitud_Estudiantes1_idx` (`Estudiantes_Id_estudiante` ASC) VISIBLE,
  CONSTRAINT `fk_Solicitud_Estudiantes1`
    FOREIGN KEY (`Estudiantes_Id_estudiante`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Estudiantes` (`Id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`contrato_becas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`contrato_becas` (
  `Id_beca_aprobada` INT NOT NULL AUTO_INCREMENT,
  `Solicitud_Id_solicitud` INT NOT NULL,
  `archivo1` LONGTEXT NULL,
  PRIMARY KEY (`Id_beca_aprobada`),
  INDEX `fk_Beca_aprobada_foto_Solicitud1_idx` (`Solicitud_Id_solicitud` ASC) VISIBLE,
  CONSTRAINT `fk_Beca_aprobada_foto_Solicitud1`
    FOREIGN KEY (`Solicitud_Id_solicitud`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Solicitudes_becas` (`Id_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Lista_verificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Lista_verificacion` (
  `Id_lista_verificacion` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `nombre_entrega` VARCHAR(250) NULL,
  `nombre_recibe` VARCHAR(250) NULL,
  `nombre_dideduc` VARCHAR(150) NULL,
  `Estudiantes_Id_estudiante` VARCHAR(300) NOT NULL,
  `Solicitud_Id_solicitud` INT NOT NULL,
  `lugar` VARCHAR(250) NULL,
  PRIMARY KEY (`Id_lista_verificacion`),
  INDEX `fk_Lista_verificacion_Estudiantes1_idx` (`Estudiantes_Id_estudiante` ASC) VISIBLE,
  INDEX `fk_Lista_verificacion_Solicitud1_idx` (`Solicitud_Id_solicitud` ASC) VISIBLE,
  CONSTRAINT `fk_Lista_verificacion_Estudiantes1`
    FOREIGN KEY (`Estudiantes_Id_estudiante`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Estudiantes` (`Id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lista_verificacion_Solicitud1`
    FOREIGN KEY (`Solicitud_Id_solicitud`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Solicitudes_becas` (`Id_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`estudio_socioeconomico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`estudio_socioeconomico` (
  `Id_estudio_socioeconomico` INT NOT NULL AUTO_INCREMENT,
  `direccion_actual_estudiante` VARCHAR(150) NULL,
  `epoca_estudios` ENUM('padres', 'huesped', 'Viaje') NOT NULL,
  `traslado` ENUM('camioneta', 'pie', 'otro') NOT NULL,
  `costo_transporte` DOUBLE NOT NULL,
  `familiares_becas` INT NOT NULL,
  `centro_familiar` VARCHAR(100) NULL,
  `observacion_1` VARCHAR(150) NULL,
  `Solicitud_Id_solicitud` INT NOT NULL,
  `padres_juntos` VARCHAR(75) NOT NULL,
  `padrasto` INT NULL,
  `madrastra` INT NULL,
  `alcohilmo_drogas` INT NULL,
  `problema_alcohilmo_drogas` VARCHAR(150) NULL,
  `nombre_encargado` VARCHAR(150) NULL,
  `dpi_encargado` VARCHAR(13) NULL,
  `telefono_encargado` VARCHAR(8) NULL,
  `correo_encargado` VARCHAR(100) NULL,
  `lugar` VARCHAR(150) NULL,
  `fecha` DATE NULL,
  `persona_recibe` VARCHAR(150) NULL,
  `observaciones_2` VARCHAR(300) NULL,
  `promedio_academico` VARCHAR(45) NULL,
  `rango_socioeconomico` VARCHAR(5) NULL,
  `ingreso_familiar` DOUBLE NULL,
  `Ingreso_percapita` DOUBLE NULL,
  `cantidad_familiares` VARCHAR(45) NULL,
  `lugar_nacimiento` VARCHAR(150) NULL,
  `causa_padres_juntos` VARCHAR(300) NULL,
  `direccion_notificaciones` VARCHAR(600) NULL,
  PRIMARY KEY (`Id_estudio_socioeconomico`),
  INDEX `fk_estudio_socioeconomico_Solicitud1_idx` (`Solicitud_Id_solicitud` ASC) VISIBLE,
  UNIQUE INDEX `correo_encargado_UNIQUE` (`correo_encargado` ASC) VISIBLE,
  CONSTRAINT `fk_estudio_socioeconomico_Solicitud1`
    FOREIGN KEY (`Solicitud_Id_solicitud`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Solicitudes_becas` (`Id_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`calificacion` (
  `Id_calificacion` INT NOT NULL AUTO_INCREMENT,
  `formulario_Id_solicitud_beca` INT NOT NULL,
  PRIMARY KEY (`Id_calificacion`),
  INDEX `fk_calificacion_formulario1_idx` (`formulario_Id_solicitud_beca` ASC) VISIBLE,
  CONSTRAINT `fk_calificacion_formulario1`
    FOREIGN KEY (`formulario_Id_solicitud_beca`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`estudio_socioeconomico` (`Id_estudio_socioeconomico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Requisitos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Requisitos` (
  `Id_requisito` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(300) NOT NULL,
  `estado` ENUM('Activo', 'Desactivo') NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_requisito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`familiares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`familiares` (
  `Id_familiares` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(75) NOT NULL,
  `apellidos` VARCHAR(75) NOT NULL,
  `edad` VARCHAR(75) NOT NULL,
  `ocuacion` VARCHAR(70) NULL,
  `grado` VARCHAR(30) NULL,
  `establecimiento` VARCHAR(150) NULL,
  `lugar_trabajo` VARCHAR(150) NULL,
  `tipo` ENUM('padre', 'madre', 'hijo') NOT NULL,
  `estudio_socioeconomico_Id_estudio_socioeconomico` INT NOT NULL,
  `menores` INT NULL,
  PRIMARY KEY (`Id_familiares`),
  INDEX `fk_familiares_estudio_socioeconomico1_idx` (`estudio_socioeconomico_Id_estudio_socioeconomico` ASC) VISIBLE,
  CONSTRAINT `fk_familiares_estudio_socioeconomico1`
    FOREIGN KEY (`estudio_socioeconomico_Id_estudio_socioeconomico`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`estudio_socioeconomico` (`Id_estudio_socioeconomico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`situacion_economica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`situacion_economica` (
  `Id_situacion_economica` INT NOT NULL AUTO_INCREMENT,
  `ingreso_mensual` VARCHAR(45) NULL,
  `ingreso_padre` DOUBLE NULL,
  `ingreso_madre` DOUBLE NULL,
  `ingreso_otro` DOUBLE NULL,
  `ayuda_familiar` DOUBLE NULL,
  `total_ingresos` DOUBLE NULL,
  `gasto_mensual` DOUBLE NULL,
  `alimentacion` DOUBLE NULL,
  `vivienda` DOUBLE NULL,
  `transporte` DOUBLE NULL,
  `agua` DOUBLE NULL,
  `luz` DOUBLE NULL,
  `medicina` DOUBLE NULL,
  `otros` DOUBLE NULL,
  `observacion` VARCHAR(150) NULL,
  `agricultura_terreno` INT NULL,
  `medida_terreno` VARCHAR(200) NULL,
  `cultiva` VARCHAR(40) CHARACTER SET 'armscii8' NULL,
  `venta_cultiva` INT NULL,
  `consume` INT NULL,
  `comerciante_negocio` VARCHAR(300) NULL,
  `estudio_socioeconomico_Id_estudio_socioeconomico` INT NOT NULL,
  `total_otros` INT NULL,
  PRIMARY KEY (`Id_situacion_economica`),
  INDEX `fk_situacion_economica_estudio_socioeconomico1_idx` (`estudio_socioeconomico_Id_estudio_socioeconomico` ASC) VISIBLE,
  CONSTRAINT `fk_situacion_economica_estudio_socioeconomico1`
    FOREIGN KEY (`estudio_socioeconomico_Id_estudio_socioeconomico`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`estudio_socioeconomico` (`Id_estudio_socioeconomico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`condicion_discapacidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`condicion_discapacidad` (
  `Id_condicion_discapacidad` INT NOT NULL AUTO_INCREMENT,
  `fisica_motora` VARCHAR(100) NULL,
  `auditiva` ENUM('leve', 'moderado', 'profundo', 'apato', 'si', 'no') NULL,
  `visual` ENUM('parcial', 'cegera', 'lentes', 'si', 'no') NULL,
  `intelectual` INT NULL,
  `silla_ruedas` INT NULL,
  `otras` ENUM('acondroplasia', 'displasia', 'otra') NULL,
  `tipo_discapacidad` ENUM('congenta', 'adquirida') NULL,
  `otros_miembros` INT NULL,
  `otros_miembros_quien` VARCHAR(45) NULL,
  `asistencia_medica` INT NULL,
  `proporcion_asistencia_medica` VARCHAR(150) NULL,
  `frecuencia_asistencia` VARCHAR(45) NULL,
  `recetado_medicamento` INT NULL,
  `observacion` VARCHAR(200) NULL,
  `estudio_socioeconomico_Id_estudio_socioeconomico` INT NOT NULL,
  PRIMARY KEY (`Id_condicion_discapacidad`),
  INDEX `fk_condicion_discapacidad_estudio_socioeconomico1_idx` (`estudio_socioeconomico_Id_estudio_socioeconomico` ASC) VISIBLE,
  CONSTRAINT `fk_condicion_discapacidad_estudio_socioeconomico1`
    FOREIGN KEY (`estudio_socioeconomico_Id_estudio_socioeconomico`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`estudio_socioeconomico` (`Id_estudio_socioeconomico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`vivienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`vivienda` (
  `Id_vivienda` INT NOT NULL,
  `estudio_socioeconomico_Id_estudio_socioeconomico` INT NOT NULL,
  `casa` ENUM('propia', 'alquila', 'paga') NULL,
  `alojamiento` INT NULL,
  `cuartos_casas` INT NULL,
  `material_casa` ENUM('block', 'ladrillo', 'adobe', 'otros') NULL,
  `tipo_piso` ENUM('piso', 'tierra', 'otros') NULL,
  `energia_electrica` INT NULL,
  `bombillos` INT NULL,
  `tipo_servicio` ENUM('fosa', 'otros', 'inodoro') NULL,
  `servicio_agua` ENUM('pozo', 'lluvia', 'potable') NULL,
  `drenaje` INT NULL,
  `aparatos_electrodomesticos` INT NULL,
  `obsercaciones` VARCHAR(300) NULL,
  PRIMARY KEY (`Id_vivienda`),
  INDEX `fk_vivienda_estudio_socioeconomico1_idx` (`estudio_socioeconomico_Id_estudio_socioeconomico` ASC) VISIBLE,
  CONSTRAINT `fk_vivienda_estudio_socioeconomico1`
    FOREIGN KEY (`estudio_socioeconomico_Id_estudio_socioeconomico`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`estudio_socioeconomico` (`Id_estudio_socioeconomico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`verificacion_requisito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`verificacion_requisito` (
  `Id_lista_requisito` INT NOT NULL AUTO_INCREMENT,
  `Requisitos_Id_requisito` INT NOT NULL,
  `Lista_verificacion_Id_lista_verificacion` INT NOT NULL,
  `folio` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_lista_requisito`),
  INDEX `fk_verificacion_requisito_Requisitos1_idx` (`Requisitos_Id_requisito` ASC) VISIBLE,
  INDEX `fk_verificacion_requisito_Lista_verificacion1_idx` (`Lista_verificacion_Id_lista_verificacion` ASC) VISIBLE,
  CONSTRAINT `fk_verificacion_requisito_Requisitos1`
    FOREIGN KEY (`Requisitos_Id_requisito`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Requisitos` (`Id_requisito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_verificacion_requisito_Lista_verificacion1`
    FOREIGN KEY (`Lista_verificacion_Id_lista_verificacion`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Lista_verificacion` (`Id_lista_verificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`configuracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`configuracion` (
  `Id_configuracion` INT NOT NULL AUTO_INCREMENT,
  `valor` VARCHAR(50) NULL,
  `tipo` LONGTEXT NULL,
  PRIMARY KEY (`Id_configuracion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`Tipo_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`Tipo_persona` (
  `Id_tipo` INT NOT NULL AUTO_INCREMENT,
  `tipo_persona` VARCHAR(200) NOT NULL,
  `Programas_Id_programa` INT NOT NULL,
  PRIMARY KEY (`Id_tipo`),
  INDEX `fk_Tipo_persona_Programas1_idx` (`Programas_Id_programa` ASC) VISIBLE,
  CONSTRAINT `fk_Tipo_persona_Programas1`
    FOREIGN KEY (`Programas_Id_programa`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Programas` (`Id_programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_EDUCACION_ESPECIAL`.`informes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_EDUCACION_ESPECIAL`.`informes` (
  `Id_informe` INT NOT NULL,
  `fecha` DATE NULL,
  `descripcion` VARCHAR(300) NULL,
  `archivo1` LONGTEXT NULL,
  `Usuarios_Id_usuario` INT NOT NULL,
  PRIMARY KEY (`Id_informe`),
  INDEX `fk_informes_Usuarios1_idx` (`Usuarios_Id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_informes_Usuarios1`
    FOREIGN KEY (`Usuarios_Id_usuario`)
    REFERENCES `DB_EDUCACION_ESPECIAL`.`Usuarios` (`Id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
