DROP DATABASE pickingdb;

CREATE DATABASE pickingdb;

USE pickingdb;

CREATE TABLE `Operador` (
    `num_empleado` VARCHAR(6) NOT NULL,
    `nombre` VARCHAR(50) NOT NULL,
    `correo` VARCHAR(50),
    PRIMARY KEY (`num_empleado`)
)  ;

-- Se creara un usuario para los lideres del almacen, hasta el momento solo se tiene un tipo de usuario (1:Lider), no es necesario crear usaurios por operadores

CREATE TABLE `Usuario` (
    `operador_num_empleado` VARCHAR(6) NOT NULL,
    `usuario` VARCHAR(20),
    `contrasena` VARCHAR(32),
    `tipo_usuario` INT NOT NULL, -- 1: Lider de almacen
    PRIMARY KEY (`operador_num_empleado`),
    FOREIGN KEY (`operador_num_empleado`) REFERENCES `Operador` (`num_empleado`)
)  ;

CREATE TABLE `Reporte` (
    `reporte_id` INT NOT NULL AUTO_INCREMENT,
    `operador_num_empleado` VARCHAR(6) NOT NULL,
    `reporte` TEXT NOT NULL,
    `respuesta` TEXT,
    `fecha` DATETIME NOT NULL,
    PRIMARY KEY (`reporte_id`),
    FOREIGN KEY (`operador_num_empleado`) REFERENCES `Operador` (`num_empleado`)
)  ;

CREATE TABLE `Dispositivo` (
    `dispositivo_id` VARCHAR(17) NOT NULL,
    `operador_num_empleado` VARCHAR(6),
    `tipo` VARCHAR(15),
    `activo` BOOLEAN,
    PRIMARY KEY (`dispositivo_id`),
    FOREIGN KEY (`operador_num_empleado`) REFERENCES `Operador` (`num_empleado`)
)  ;

CREATE TABLE `Producto` (
    `sku` INT NOT NULL,
    `id_linea` VARCHAR(3) NOT NULL,
    `generico` CHAR(1) NOT NULL,
    `unidad_medida` INT NOT NULL, -- 1:Para aquellos que no tengan UM
    `descripcion` VARCHAR(100),
    `stock` INT,
    PRIMARY KEY (`sku`)
);

CREATE TABLE `Ubicacion` (
    `ubicacion` VARCHAR(11) NOT NULL,
    `sku` INT NOT NULL,
    `pasillo` CHAR(1) NOT NULL,
    `rack` TINYINT NOT NULL,
    `columna` TINYINT NOT NULL,
    `nivel` TINYINT NOT NULL,
    PRIMARY KEY (`ubicacion`),
    FOREIGN KEY (`sku`) REFERENCES `Producto` (`sku`)
);

CREATE TABLE `Contenedor` (
    `contenedor_id` INT NOT NULL AUTO_INCREMENT,
    `medida` INT,
    `estado` BOOLEAN,
    `ubicacion` VARCHAR(15),
    PRIMARY KEY (`contenedor_id`)
);

CREATE TABLE `Control` (
    `control_id` INT NOT NULL AUTO_INCREMENT,
    `sku` INT NOT NULL,
    `numero_control` INT NOT NULL,
    `id_sucursal` INT NOT NULL,
    `apartado` INT NOT NULL, -- Cantidad que pide la sucursal del sku
    `asignado` BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (`control_id`),
    FOREIGN KEY (`sku`) REFERENCES `Producto` (`sku`)
);

CREATE TABLE `Operador_has_control` (
    `control_id` INT NOT NULL,
    `num_empleado` VARCHAR(6) NOT NULL,
    `contenedor_id` INT,
    `prioridad` INT NOT NULL,
    FOREIGN KEY (`control_id`) REFERENCES `Control` (`control_id`),
    FOREIGN KEY (`num_empleado`) REFERENCES `Operador` (`num_empleado`),
    FOREIGN KEY (`contenedor_id`) REFERENCES `Contenedor` (`contenedor_id`)
);    

CREATE TABLE `Transaccion` (
    `transaccion_id` INT NOT NULL AUTO_INCREMENT,
    `num_empleado` VARCHAR(6) NOT NULL,
    `contenedor_id` INT,
    `sku` INT NOT NULL,
    `control_id` INT,
    `hora_realizada` DATETIME NOT NULL,
    `tipo_movimiento` CHAR(2) NOT NULL, -- P:Pickup; SA: Surte Almacen; R:Reabasto
    `cantidad` INT NOT NULL, -- cantidad > 0 : reabasto ; cabtudad < 0 p | sa ; producto faltante : 0
    PRIMARY KEY (`transaccion_id`),
    FOREIGN KEY (`num_empleado`) REFERENCES `Operador` (`num_empleado`),
    FOREIGN KEY (`contenedor_id`) REFERENCES `Contenedor` (`contenedor_id`),
    FOREIGN KEY (`sku`) REFERENCES `Producto` (`sku`),
    FOREIGN KEY (`control_id`) REFERENCES `Control` (`control_id`)
);

insert into producto (sku, id_linea, generico, unidad_medida, descripcion) values
    (508748 , "AJG" , "E", 1, "TRENZADO AMARILLO"),
    (508749 , "AJG" , "E", 1, "TRENZADO ROSA"),
    (508752 , "AJG" , "E", 1, "CORDON AMARILLO"),
    (508753 , "AJG" , "E", 1, "TRENZADO TIPO PIEL NARANJA"),
    (508754 , "AJG" , "E", 1, "TRENZADO TIPO PIEL VERDE"),
    (508755 , "AJG" , "E", 1, "KPKMEX VERDE"),
    (508756 , "AJG" , "E", 1, "KPKMEX ROSA"),
    (508757 , "AJG" , "E", 1, "KPKMEX NARANJA"),
    (549219 , "AJG" , "E", 1, "AIJ012 ROSA"),
    (220568 , "ALC" , "E", 1, "OPTI FREE PUREMOIST 300 "),
    (5405 , "AOT" , "E", 1, "MICROFIBRAS LUX CORTESIA "),
    (15760 , "BAU" , "E", 1, "GOTAS LUBRICANTES Y REHUMECTANTES "),
    (17445 , "BAU" , "E", 1, "BIOTRUE "),
    (17753 , "BAU" , "E", 1, "GOTAS ARTELAC REBALANCE 10 ML "),
    (508945 , "BAU" , "E", 1, "RENU FRESH "),
    (546765 , "BAU" , "E", 1, "KIT 3 PACK BIOTRUE "),
    (551366 , "BAU" , "E", 1, "RENU FRESH 355ML "),
    (551268 , "BLO" , "E", 1, "LENTE BLUE LIGHT 8062020"),
    (551269 , "BLO" , "E", 1, "LENTE BLUE LIGHT 8062020"),
    (551436 , "BLO" , "E", 1, "BLUE LIGHT "),
    (551437 , "BLO" , "E", 1, "BLUE LIGHT "),
    (551440 , "BLO" , "E", 1, "BLUE LIGHT "),
    (5635 , "CAD" , "E", 1, "SUJETADOR DE RESORTE NEGRO"),
    (503672 , "CAD" , "E", 1, "SUJETADOR DE RESORTE BLACK"),
    (504852 , "CHU" , "E", 1, "CHU12106100 "),
    (504854 , "CHU" , "E", 1, "CHU12424361 "),
    (504855 , "CHU" , "E", 1, "CHU12112101 "),
    (504856 , "CHU" , "E", 1, "CHU12115100 "),
    (504858 , "CHU" , "E", 1, "CHU30054100 "),
    (504859 , "CHU" , "E", 1, "CHU12129887 "),
    (504860 , "CHU" , "E", 1, "CHU12128349 "),
    (504861 , "CHU" , "E", 1, "CHU12406100 "),
    (504862 , "CHU" , "E", 1, "CHU12311100 "),
    (504863 , "CHU" , "E", 1, "CHU31094100 "),
    (504864 , "CHU" , "E", 1, "CHU54252 "),
    (504865 , "CHU" , "E", 1, "CHU31090100 "),
    (504866 , "CHU" , "E", 1, "CHU30080 "),
    (504925 , "CHU" , "E", 1, "CHU12106101 "),
    (504927 , "CHU" , "E", 1, "CHU12424362 "),
    (504928 , "CHU" , "E", 1, "CHU12424363 "),
    (504929 , "CHU" , "E", 1, "CHU12424365 "),
    (504930 , "CHU" , "E", 1, "CHU12112102 "),
    (504931 , "CHU" , "E", 1, "CHU12115101 "),
    (504932 , "CHU" , "E", 1, "CHU12115114 "),
    (504933 , "CHU" , "E", 1, "CHU12115501 "),
    (504934 , "CHU" , "E", 1, "CHU12128100 "),
    (504935 , "CHU" , "E", 1, "CHU12129888 "),
    (504936 , "CHU" , "E", 1, "CHU12129460 "),
    (504938 , "CHU" , "E", 1, "CHU12406155 "),
    (504939 , "CHU" , "E", 1, "CHU12406749 "),
    (504940 , "CHU" , "E", 1, "CHU12311341 "),
    (504941 , "CHU" , "E", 1, "CHU12311871 "),
    (504942 , "CHU" , "E", 1, "CHU31094223 "),
    (508989 , "CHU" , "E", 1, "SHADE SHELL BALCK/BRINGHT PINK ROSA"),
    (551291 , "CLI" , "E", 1, "DIRECT-CASE NN"),
    (504746 , "CLM" , "E", 1, "KIT DE LIMPIEZA CON SOLUCION, MICROFIBRA Y TOALLITAS HUMEDAS "),
    (507575 , "CLM" , "E", 1, "KIT DE LIMPIEZA PREMIUM "),
    (507576 , "CLM" , "E", 1, "TOALLITAS HUMEDAS "),
    (507577 , "CLM" , "E", 1, "MICROFIBRA NARANJA"),
    (507578 , "CLM" , "E", 1, "ESTUCHES NEGRO"),
    (507582 , "CLM" , "E", 1, "LENTES DE VISTA CANSADA NEGRO"),
    (508241 , "CLM" , "E", 1, "LENTES PRE GRADUADOS AZUL AZUL"),
    (508243 , "CLM" , "E", 1, "LENTES PRE GRADUADOS AZUL AZUL"),
    (508244 , "CLM" , "E", 1, "LENTES PRE GRADUADOS AZUL AZUL"),
    (508249 , "CLM" , "E", 1, "LENTES PRE GRADUADOS NEGRO NEGRO"),
    (508250 , "CLM" , "E", 1, "LENTES PRE GRADUADOS NEGRO NEGRO"),
    (508251 , "CLM" , "E", 1, "LENTES PRE GRADUADOS NEGRO NEGRO"),
    (508254 , "CLM" , "E", 1, "LENTES PRE GRADUADOS ROJO ROJO"),
    (549033 , "CLM" , "E", 1, "LENTE BLUE LIGHT 8062020"),
    (551294 , "CLM" , "E", 1, "BLUE LIGHT "),
    (551295 , "CLM" , "E", 1, "BLUE LIGHT "),
    (551296 , "CLM" , "E", 1, "BLUE LIGHT "),
    (551299 , "CLM" , "E", 1, "PREGRADUADO 2.5 NEGRO"),
    (551301 , "CLM" , "E", 1, "PREGRADUADO 1.5 AZUL"),
    (551304 , "CLM" , "E", 1, "PREGRADUADO 3.0 AZUL"),
    (551307 , "CLM" , "E", 1, "PREGRADUADO 2.5 CAREY"),
    (551308 , "CLM" , "E", 1, "PREGRADUADO 3.0 CAREY"),
    (551375 , "CLM" , "E", 1, "LENTES PROTECTORES TRANSPARENTE"),
    (551532 , "CLM" , "E", 1, "LENTES BLUE LIGHT ROSA"),
    (551533 , "CLM" , "E", 1, "LENTES BLUE LIGHT NEGRO"),
    (16028 , "EST" , "E", 1, "FORTIUS GRANDE CORTESIA "),
    (221448 , "EST" , "E", 1, "ESTUCHE R- 85 GRANDE MAS VISION "),
    (507586 , "EST" , "E", 1, "ESTUCHE MAS VISION GRANDE PARA VENTA NEGRO"),
    (549212 , "FSL" , "E", 1, "GEL ANTIBACTERIAL  INDIVIDUAL TRANSPARENTE"),
    (551266 , "FSL" , "E", 1, "GEL-001-3 TRANSPARENTE"),
    (551330 , "FSL" , "E", 1, "CUBRE-30000-4 AZUL"),
    (551349 , "FSL" , "E", 1, "LENTE VENUS CON ANTIEMPANANTE TRANSP/NEGRO"),
    (551384 , "FSL" , "E", 1, "LENTES DE SEGURIDAD NEGRO/AZUL"),
    (508295 , "GVS" , "E", 1, "ESTUCHE GENERICO "),
    (186326 , "HIL" , "E", 1, "VENTURE WITH SPORTS CLIP NEGRO"),
    (507552 , "HIL" , "E", 1, "KIDS PALS COLLECTION TEDDY BEAR HOLDER ROJO"),
    (507553 , "HIL" , "E", 1, "KIDS PALS COLLECTION CAT HOLDER AMARILLO"),
    (507554 , "HIL" , "E", 1, "KIDS PALS COLLECTION MOUSE HOLDER AZUL"),
    (507557 , "HIL" , "E", 1, "LEADER SPORTS LINE COLLECTION FLECK BROWN MARRON"),
    (507558 , "HIL" , "E", 1, "LEADER SPORTS LINE COLLECTION BLACK NEGRO"),
    (507559 , "HIL" , "E", 1, "LEADER SPORTS LINE COLLECTION FLECK BLACK NEGRO"),
    (507561 , "HIL" , "E", 1, "CALISA FASHION EYEWEAR HOLDER DORADA"),
    (507563 , "HIL" , "E", 1, "SNAP-ON SPORT BAND COLLECTION  INDIVIDUAL NEGRO"),
    (507584 , "HIL" , "E", 1, "ZIP SPECS NEGRO/CAFE/NARANJA/ROSA"),
    (508240 , "HIL" , "E", 1, "FFEDUCHI RODEO STOK CAFE CAFE"),
    (5402 , "HMS" , "E", 1, "TOALLAS HUMEDAS "),
    (549214 , "HMS" , "E", 1, "CUBETA DE TOALLAS DESINFECTANTES BLANCAS"),
    (549213 , "HPS" , "E", 1, "CUBREBOCAS NEOPRENO NEGRO"),
    (503205 , "INS" , "E", 1, "DIRECT-CASE LL"),
    (551292 , "JUL" , "E", 1, "DIRECT-CASE BB"),
    (509404 , "KUS" , "E", 1, "JADE DORADO/JADE"),
    (509406 , "KUS" , "E", 1, "OJO DE TIGRE DORADO/CAFE/AZU"),
    (509409 , "KUS" , "E", 1, "CRISTAL VERDE VICTORIA DORADO/PIEDRASV"),
    (221449 , "LIM" , "E", 1, "MICROFIBRAS NARANJO MAS VISION "),
    (549216 , "LIM" , "E", 1, "GEL ANTIBACTERIAL TRANSPARENTE"),
    (551290 , "MIN" , "E", 1, "DIRECT-CASE LL"),
    (551521 , "POM" , "E", 1, "FN009/BLACK/ BLACK"),
    (551522 , "POM" , "E", 1, "FN044/RED/ RED"),
    (551523 , "POM" , "E", 1, "FN067/WHITE/ WHITE"),
    (551524 , "POM" , "E", 1, "FN073/YELLOW/ YELLOW"),
    (551525 , "POM" , "E", 1, "FN076/FLY/ FLY"),
    (551406 , "PVH" , "E", 1, "CUBREBOCAS N95 PARA NINOS COLORES"),
    (551407 , "PVH" , "E", 1, "CUBREBOCAS TRES CAPAS PARA NINO BLANCO/AZUL"),
    (551408 , "PVH" , "E", 1, "CARETA PROTECTORA CON LENTE INCLUIDO TRANSPARENTE"),
    (551409 , "PVH" , "E", 1, "CAJA ESTERILIZADORA PARA TELEFONO Y CUBREBOCAS BLANCA"),
    (551526 , "PVH" , "E", 1, "KN95 HALLOWEEN NINOS HALLOWEEN"),
    (551527 , "PVH" , "E", 1, "KN95 NINOS COLORES COLORES"),
    (16614 , "SBN" , "E", 1, "CLEANER GP "),
    (17755 , "SBN" , "E", 1, "EQUIPO DE INICIACION BLANDO "),
    (215072 , "SBN" , "E", 1, " GOTAS HUMECTANTES LACRIFRESH "),
    (506974 , "SBN" , "E", 1, "UNICA CON ALOE VERA "),
    (551293 , "SEN" , "E", 1, "DIRECT-CASE BB"),
    (551348 , "SFM" , "E", 1, "CUBRE-KN95 BLANCO/AZUL"),
    (551351 , "SLM" , "E", 1, "SANIFEX SPRAY 170 TRANSPARENTE"),
    (551352 , "SLM" , "E", 1, "SANIFEX TOALLAS 30 BLANCO"),
    (216080 , "SO" , "E", 1, ",/SODM50/ACCESORIOS/LINEA POLARIZADO////62/17// BB"),
    (216081 , "SO" , "E", 1, ",/SODM50/ACCESORIOS/LINEA POLARIZADO////62/17// EE"),
    (216082 , "SO" , "E", 1, ",/SODM50/ACCESORIOS/LINEA POLARIZADO////62/17// NN"),
    (216083 , "SO" , "E", 1, ",/SODM51/ACCESORIOS/LINEA POLARIZADO////62/18// NN"),
    (216084 , "SO" , "E", 1, ",/SODM52/ACCESORIOS/LINEA POLARIZADO////62/14// BB"),
    (216085 , "SO" , "E", 1, ",/SODM52/ACCESORIOS/LINEA POLARIZADO////62/14// EE"),
    (216086 , "SO" , "E", 1, ",/SODM52/ACCESORIOS/LINEA POLARIZADO////62/14// NN"),
    (5633 , "URS" , "E", 1, "PORTALENTE DE PIEL VARIOS"),
    (10053 , "URS" , "E", 1, "METALICA NEGRO"),
    (10055 , "URS" , "E", 1, "METALICA ORO"),
    (11522 , "URS" , "E", 1, "PORTALENTE DE RESORTE "),
    (15748 , "URS" , "E", 1, "METALICA PLATA"),
    (15755 , "URS" , "E", 1, "METALICA PLATA"),
    (16997 , "URS" , "E", 1, "SUJETADOR KIDS DELGADO MULTICOLOR"),
    (290525 , "URS" , "E", 1, "METALICA ORO"),
    (290546 , "URS" , "E", 1, "SUJETADOR JEANS GRUESO MARINO"),
    (290549 , "URS" , "E", 1, "SUJETADOR KIDS GRUESO MULTICOLOR"),
    (298977 , "URS" , "E", 1, "PERLAS DE MADERA VINO/MADERA"),
    (501860 , "URS" , "E", 1, "TIPO AGUJETA CLASICA ROJO"),
    (501883 , "URS" , "E", 1, "PERLAS DE MADERA COLORES"),
    (501884 , "URS" , "E", 1, "RESORTE CAFE"),
    (501885 , "URS" , "E", 1, "RESORTE AZUL"),
    (501887 , "URS" , "E", 1, "RESORTE NEGRO"),
    (502035 , "URS" , "E", 1, "PORTALENTES DE CORDON NARANJA"),
    (502037 , "URS" , "E", 1, "PORTALENTES DE CORDON VERDE"),
    (502042 , "URS" , "E", 1, "TIPO AGUJETA CLASICA MORADO"),
    (502045 , "URS" , "E", 1, "SUJETADOR JEANS DELGADO GRIS"),
    (502048 , "URS" , "E", 1, "SUJETADOR DE PIEL VINO");

insert into control 
    (sku,numero_control,id_sucursal,apartado,asignado)
    values
    (10053, 1, 12197, 1, 0),
    (10053, 1, 12817, 1, 0),
    (11522, 1, 12135, 1, 0),
    (15755, 1, 12082, 1, 0),
    (15760, 1, 12213, 6, 0),
    (15760, 1, 12004, 6, 0),
    (15760, 1, 12197, 6, 0),
    (15760, 1, 12030, 6, 0),
    (15760, 1, 12042, 6, 0),
    (15760, 1, 12035, 6, 0),
    (15760, 1, 12159, 6, 0),
    (15760, 1, 12321, 6, 0),
    (15760, 1, 12046, 6, 0),
    (15760, 1, 12320, 6, 0),
    (15760, 1, 12059, 6, 0),
    (15760, 1, 12057, 6, 0),
    (15760, 1, 12025, 6, 0),
    (15760, 1, 12255, 6, 0),
    (15760, 1, 12819, 6, 0),
    (15760, 1, 12078, 6, 0),
    (15760, 1, 12821, 6, 0),
    (15760, 1, 12055, 6, 0),
    (15760, 1, 12258, 6, 0),
    (15760, 1, 12875, 6, 0),
    (15760, 1, 12846, 6, 0),
    (15760, 1, 12319, 6, 0),
    (16997, 1, 12135, 1, 0),
    (17445, 1, 12009, 6, 0),
    (17445, 1, 12017, 6, 0),
    (17445, 2, 12024, 5, 0),
    (17445, 2, 12041, 2, 0),
    (17445, 2, 12004, 1, 0),
    (17445, 2, 12148, 6, 0),
    (17445, 2, 12011, 6, 0),
    (17445, 3, 12042, 6, 0),
    (17445, 3, 12056, 6, 0),
    (17445, 3, 12006, 6, 0),
    (17445, 3, 12002, 6, 0),
    (17445, 3, 12012, 6, 0),
    (17445, 3, 12847, 6, 0),
    (17445, 3, 12320, 6, 0),
    (17445, 3, 12238, 6, 0),
    (17445, 3, 12014, 6, 0),
    (17445, 3, 12034, 6, 0),
    (17445, 3, 12031, 6, 0),
    (17445, 3, 12255, 6, 0),
    (17445, 3, 12131, 6, 0),
    (17445, 3, 12819, 6, 0),
    (17445, 3, 12832, 6, 0),
    (17445, 3, 12322, 6, 0),
    (17445, 3, 12044, 6, 0),
    (17445, 3, 12078, 6, 0),
    (17445, 3, 12263, 6, 0),
    (17445, 3, 12875, 6, 0),
    (17445, 3, 12230, 6, 0),
    (17445, 3, 12319, 6, 0),
    (17445, 3, 12843, 6, 0),
    (17755, 3, 12037, 3, 0),
    (17755, 3, 12004, 4, 0),
    (17755, 4, 12100, 3, 0),
    (17755, 4, 12042, 4, 0),
    (17755, 4, 12035, 1, 0),
    (17755, 4, 12076, 1, 0),
    (17755, 4, 12021, 2, 0),
    (17755, 4, 12177, 1, 0),
    (17755, 4, 12320, 2, 0),
    (17755, 4, 12164, 1, 0),
    (17755, 4, 12049, 3, 0),
    (17755, 4, 12877, 1, 0),
    (17755, 4, 12079, 2, 0),
    (17755, 4, 12014, 1, 0),
    (17755, 4, 12239, 1, 0),
    (17755, 4, 12098, 2, 0),
    (17755, 4, 12137, 2, 0),
    (17755, 4, 12066, 1, 0),
    (17755, 4, 12190, 2, 0),
    (17755, 4, 12251, 2, 0),
    (17755, 4, 12853, 2, 0),
    (17755, 4, 12161, 1, 0),
    (17755, 4, 12027, 2, 0),
    (17755, 4, 12219, 1, 0),
    (17755, 4, 12878, 1, 0),
    (216080, 4, 12091, 1, 0),
    (216080, 4, 12830, 1, 0),
    (220568, 4, 12082, 3, 0),
    (220568, 4, 12213, 1, 0),
    (220568, 4, 12024, 1, 0),
    (220568, 4, 12004, 4, 0),
    (220568, 4, 12016, 1, 0),
    (220568, 4, 12038, 2, 0),
    (220568, 4, 12100, 1, 0),
    (220568, 4, 12148, 2, 0),
    (220568, 4, 12077, 1, 0);

insert into operador values
    ("123456", "Donaldo", null),
    ("111111", "Eduardo", null);

insert into ubicacion values 
    ("A.01.01.09", 10053, 'A', 1, 1, 1),
    ("A.01.01.03", 11522, 'A', 1, 1, 3),
    ("A.01.01.04", 15748, 'A', 1, 1, 4),
    ("A.01.01.05", 15755, 'A', 1, 1, 5),
    ("A.01.01.06", 15760, 'A', 1, 1, 6),
    ("A.01.01.08", 16028, 'A', 1, 1, 8),
    ("A.02.01.03", 17445, 'A', 2, 1, 3);

insert into contenedor 
    (medida,estado,ubicacion)
    values
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01"),
    (10, false, "A.01.01.01");

insert into operador_has_control values
    (1, "123456", NULL, 1),
    (2, "123456", NULL, 1),
    (3, "123456", NULL, 1),
    (4, "123456", NULL, 1),
    (5, "123456", NULL, 1),
    (6, "123456", NULL, 1),
    (7, "123456", NULL, 1),
    (8, "123456", NULL, 1),
    (9, "123456", NULL, 1),
    (30, "111111", NULL, 1),
    (31, "111111", NULL, 1),
    (32, "111111", NULL, 1),
    (33, "111111", NULL, 1),
    (34, "111111", NULL, 1);

UPDATE Control SET asignado = 1; -- Suponiendo que ya estan asignados
UPDATE Producto SET unidad_medida = 50 WHERE sku = 10053; -- Cambio en UM para un sku
INSERT INTO Usuario VALUE ('123456', NULL, NULL, 1);
