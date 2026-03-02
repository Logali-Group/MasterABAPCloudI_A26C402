CLASS zitab3_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zitab3_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*"FOR
*   " Estructuras para productos
*   TYPES: BEGIN OF ty_producto,
*            id       TYPE i,
*            nombre   TYPE string,
*            precio   TYPE p LENGTH 10 DECIMALS 2,
*            categoria TYPE string,
*          END OF ty_producto.
*
*   TYPES: BEGIN OF ty_producto_con_descuento,
*            id              TYPE i,
*            nombre          TYPE string,
*            precio_original TYPE p LENGTH 10 DECIMALS 2,
*            descuento       TYPE i,
*            precio_final    TYPE p LENGTH 10 DECIMALS 2,
*          END OF ty_producto_con_descuento.
*
*   DATA lt_productos TYPE TABLE OF ty_producto.
*
*   DATA lt_productos_descuento TYPE TABLE OF ty_producto_con_descuento.
*
*   "=================================================================
*   " CASO 1: Generar catálogo de productos con FOR UNTIL
*   "=================================================================
*
*   out->write( |CASO 1: Generar productos automáticamente| ).
*
*   " SIN FOR (forma tradicional - muchas líneas):
*   " DO 10 TIMES.
*   "   APPEND VALUE #( id = sy-index
*   "                   nombre = |Producto { sy-index }|
*   "                   precio = 100 + ( sy-index * 20 )
*   "                   categoria = ... ) TO lt_productos.
*   " ENDDO.
*
*
*   " CON FOR (forma moderna - una sola expresión):
*   lt_productos = VALUE #(
*     FOR i = 1 UNTIL i > 10
*     ( id        = i
*       nombre    = |Producto { i }|
*       precio    = 100 + ( i * 20 )
*       categoria = COND #( WHEN i <= 5 THEN 'Basico' ELSE 'Premium' ) )
*   ).
*
*   out->write( |Generados { lines( lt_productos ) } productos| ).
*   out->write( lt_productos ).
*   out->write( |\n| ).
*
*
*   "=================================================================
*   " CASO 2: Aplicar descuento a todos con FOR...IN
*   "=================================================================
*   out->write( |CASO 2: Aplicar descuentos según precio| ).
*   out->write( |==================================| ).
*
*   " SIN FOR (forma tradicional):
*   " LOOP AT lt_productos INTO DATA(ls_prod).
*   "   DATA(ls_con_desc) = VALUE ty_producto_con_descuento( ... ).
*   "   IF ls_prod-precio >= 200.
*   "     ls_con_desc-descuento = 20.
*   "   ELSE...
*   "   ls_con_desc-precio_final = ls_prod-precio * ...
*   "   APPEND ls_con_desc TO lt_productos_descuento.
*   " ENDLOOP.
*
*   " CON FOR (forma moderna con COND):
*   lt_productos_descuento = VALUE #(
*     FOR ls_prod IN lt_productos
*     LET descuento_aplicado = COND i( WHEN ls_prod-precio >= 200 THEN 20 "Transformación a entero para guardarlo en la variable
*                                      WHEN ls_prod-precio >= 150 THEN 15
*                                       ELSE 10 )
*     IN
*     ( id              = ls_prod-id
*       nombre          = ls_prod-nombre
*       precio_original = ls_prod-precio
*       descuento       = descuento_aplicado
*       precio_final    = ls_prod-precio * ( 100 - descuento_aplicado ) / 100 )
*   ).
*
*   out->write( |Todos los productos con descuento aplicado:| ).
*
*   LOOP AT lt_productos_descuento INTO DATA(ls_desc).
*     out->write( |{ ls_desc-nombre }: { ls_desc-precio_original } EUR -> { ls_desc-precio_final } EUR ({ ls_desc-descuento }% desc)| ).
*   ENDLOOP.
*
*   out->write( |\n| ).

   "=================================================================
   " CASO 3: Filtrar solo productos Premium con FOR...IN WHERE
   "=================================================================
   out->write( |CASO 3: Reporte solo de productos Premium| ).
   out->write( |====================================| ).

   " SIN FOR (forma tradicional):
   " DATA lt_premium TYPE TABLE OF ty_producto.
   " LOOP AT lt_productos INTO DATA(ls_producto).
   "   IF ls_producto-categoria = 'Premium'.
   "     APPEND ls_producto TO lt_premium.
   "   ENDIF.
   " ENDLOOP.

*   " CON FOR WHERE (filtrar y copiar):
*   DATA lt_solo_premium TYPE TABLE OF ty_producto.
*
*   lt_solo_premium = VALUE #( FOR ls_prod IN lt_productos
*                                WHERE ( categoria = 'Premium' )
*                                ( ls_prod ) ).
*
*   out->write( |Productos Premium: { lines( lt_solo_premium ) } de { lines( lt_productos ) }| ).
*
*   out->write( lt_solo_premium ).
*   out->write( |\n| ).

*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN SIMPLE:| ).
*   out->write( |=============| ).
*   out->write( |1. FOR i = 1 UNTIL i > 10| ).
*   out->write( |  -> Crea registros automáticamente (como DO)| ).
*   out->write( | | ).
*   out->write( |2. FOR elemento IN tabla| ).
*   out->write( |  -> Transforma cada elemento a nueva tabla| ).
*   out->write( | | ).
*   out->write( |3. FOR elemento IN tabla WHERE ( condición )| ).
*   out->write( |  -> Filtra Y transforma al mismo tiempo| ).
*   out->write( | | ).
*   out->write( |COND: IF-THEN-ELSE en una sola línea| ).
*   out->write( |LET: Define variables temporales dentro del FOR| ).


*"Ordenar registros - en qué tipos de tablas?
*
*   " Obtenemos vuelos desde la CDS View estándar
*
*   SELECT FROM /DMO/I_Flight
*     FIELDS AirlineID,
*            ConnectionID,
*            FlightDate,
*            Price,
*            CurrencyCode
*     WHERE CurrencyCode = 'EUR'
*     INTO TABLE @DATA(lt_vuelos)
*     UP TO 10 ROWS.
*
*   out->write( |Datos originales sin ordenar:| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 1: SORT por clave primaria (ascendente por defecto)
*   "=================================================================
*   out->write( |CASO 1: Ordenar por clave primaria| ).
*   out->write( |================================| ).
*
*   " Como lt_vuelos se declaró inline con DATA(...), tiene clave vacía.
*   " SORT ordenará por TODOS los campos en orden de aparición.
*
*   SORT lt_vuelos.
*
*   out->write( |Después de SORT (clave primaria ascendente):| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: SORT DESCENDING (orden inverso)
*   "=================================================================
*
*   out->write( |CASO 2: Ordenar descendente| ).
*   out->write( |=======================| ).
*
*   SORT lt_vuelos DESCENDING.
*
*   out->write( |Después de SORT DESCENDING:| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 3: SORT BY campo específico
*   "=================================================================
*
*   out->write( |CASO 3: Ordenar por campo específico (FlightDate)| ).
*   out->write( |=============================================| ).
*
*   " Ordenar solo por fecha de vuelo (ascendente)
*   SORT lt_vuelos BY FlightDate.
*
*   out->write( |Ordenado por FlightDate ascendente:| ).
*
*   LOOP AT lt_vuelos INTO DATA(ls_vuelo).
*     out->write( |{ ls_vuelo-AirlineID }{ ls_vuelo-ConnectionID } - { ls_vuelo-FlightDate } - { ls_vuelo-Price } { ls_vuelo-CurrencyCode }| ).
*   ENDLOOP.
*
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 4: SORT BY campo descendente
*   "=================================================================
*   out->write( |CASO 4: Ordenar por precio (más caro primero)| ).
*   out->write( |=========================================| ).
*
*   " Ordenar por precio de mayor a menor
*   SORT lt_vuelos BY Price DESCENDING.
*
*   out->write( |Ordenado por Price descendente:| ).
*
*   LOOP AT lt_vuelos INTO ls_vuelo.
*     out->write( |{ ls_vuelo-AirlineID }{ ls_vuelo-ConnectionID } - Precio: { ls_vuelo-Price } { ls_vuelo-CurrencyCode }| ).
*   ENDLOOP.
*
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 5: SORT múltiples campos con diferentes direcciones
*   "=================================================================
*
*   out->write( |CASO 5: Ordenar por varios campos| ).
*   out->write( |=============================| ).
*
*   " Primero por aerolínea (ascendente), luego por precio (descendente)
*
*   SORT lt_vuelos BY AirlineID ASCENDING
*                     Price DESCENDING.
*   out->write( |Ordenado por CarrierID (asc) y luego Price (desc):| ).
*
*   LOOP AT lt_vuelos INTO ls_vuelo.
*     out->write( |{ ls_vuelo-AirlineID } - { ls_vuelo-ConnectionID } - { ls_vuelo-Price } EUR| ).
*   ENDLOOP.
*
*   out->write( |\n| ).

*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN:| ).
*   out->write( |=======| ).
*   out->write( |SORT tabla               → Ordena por clave primaria ascendente| ).
*   out->write( |SORT tabla DESCENDING    → Ordena por clave primaria descendente| ).
*   out->write( |SORT tabla BY campo      → Ordena por campo específico| ).
*   out->write( |SORT tabla BY campo DESCENDING → Campo descendente| ).
*   out->write( |SORT tabla BY campo1 ASC campo2 DESC → Múltiples campos| ).
*   out->write( | | ).
*   out->write( |IMPORTANTE:| ).
*   out->write( |Solo aplica a tablas STANDARD y HASHED| ).
*   out->write( |Las tablas SORTED ya están ordenadas, no necesitan SORT| ).
*   out->write( |Por defecto el orden es ASCENDING (ascendente)| ).
*

"MODIFY
*   " Estructura simple
*   TYPES: BEGIN OF ty_vuelo,
*            id     TYPE i,
*            precio TYPE i,
*            estado TYPE string,
*          END OF ty_vuelo.
*
*   DATA lt_vuelos TYPE TABLE OF ty_vuelo.
*
*   " Crear algunos vuelos
*   lt_vuelos = VALUE #(
*     ( id = 1 precio = 200 estado = 'Disponible' )
*     ( id = 2 precio = 300 estado = 'Disponible' )
*     ( id = 3 precio = 250 estado = 'Disponible' )
*   ).
*
*   out->write( |Datos originales:| ).
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 1: MODIFY por índice (posición específica)
*   "=================================================================
*   out->write( |CASO 1: Modificar el segundo vuelo por índice| ).
*   " Crear nueva estructura con los cambios
*
*   DATA(ls_cambio) = VALUE ty_vuelo( id = 2 precio = 350 estado = 'Promoción' ).
*
*   " Modificar la posición 2
*
*   MODIFY lt_vuelos FROM ls_cambio INDEX 2.
*
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: MODIFY en LOOP con FIELD-SYMBOL (más común y eficiente)
*   "=================================================================
*
*   out->write( |CASO 2: Aplicar descuento 10% a todos| ).
*
*   " Modificar directamente cada registro en el LOOP
*
*   LOOP AT lt_vuelos ASSIGNING FIELD-SYMBOL(<fs_vuelo>).
*     <fs_vuelo>-precio = <fs_vuelo>-precio * 90 / 100.  " 10% descuento
*     <fs_vuelo>-estado = 'Rebajado'.
*   ENDLOOP.
*
*   out->write( lt_vuelos ).
*   out->write( |\n| ).
**
*   "=================================================================
*   " CASO 3: MODIFY condicional (solo algunos registros)
*   "=================================================================
*
*   out->write( |CASO 3: Cambiar estado solo si precio < 300| ).
*
*   LOOP AT lt_vuelos ASSIGNING FIELD-SYMBOL(<fs_v>).
*     IF <fs_v>-precio < 300.
*       <fs_v>-estado = 'Oferta Especial'.
*     ENDIF.
*   ENDLOOP.
*
*   out->write( lt_vuelos ).
*   out->write( |\n| ).

*   "=================================================================
*   " RESUMEN
*   "=================================================================
*
*   out->write( |RESUMEN:| ).
*   out->write( |MODIFY tabla FROM estructura INDEX n → Cambia posición n| ).
*   out->write( |LOOP con FIELD-SYMBOL → Forma más común y eficiente| ).
*   out->write( |FIELD-SYMBOL modifica directamente, sin copias| ).
*
*
*"Eliminar registros
*
*   " Obtener clientes
*   SELECT FROM /DMO/I_Customer
*     FIELDS CustomerID, FirstName, LastName, CountryCode
*     INTO TABLE @DATA(lt_clientes)
*     UP TO 15 ROWS.
*
*   out->write( |Clientes iniciales: { lines( lt_clientes ) }| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 1: DELETE INDEX (eliminar por posición)
*   "=================================================================
*   out->write( |CASO 1: Eliminar el segundo cliente (posición 2)| ).
*
*   DELETE lt_clientes INDEX 2.
*
*   out->write( |Después de DELETE INDEX 2: { lines( lt_clientes ) } clientes| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: DELETE WHERE (eliminar por condición)
*   "=================================================================
*
*   out->write( |CASO 2: Eliminar clientes de Alemania| ).
*
*   DELETE lt_clientes WHERE CountryCode = 'DE'.
*
*   out->write( |Después de DELETE WHERE: { lines( lt_clientes ) } clientes| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 3: DELETE ADJACENT DUPLICATES (eliminar duplicados)
*   "=================================================================
*
*   out->write( |CASO 3: Eliminar duplicados por país| ).
*
*   " IMPORTANTE: Primero SORT, luego DELETE ADJACENT
*   SORT lt_clientes BY CountryCode.
*
*   DELETE ADJACENT DUPLICATES FROM lt_clientes COMPARING CountryCode.
*
*   out->write( |Solo un cliente por país: { lines( lt_clientes ) }| ).
*   out->write( lt_clientes ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 4: CLEAR vs FREE vs VALUE #()
*   "=================================================================
*   out->write( |CASO 4: Tres formas de vaciar una tabla| ).
*
*   DATA lt_temp TYPE TABLE OF /dmo/i_customer.
*
*   SELECT FROM /DMO/I_Customer
*     FIELDS *
*     INTO CORRESPONDING FIELDS OF TABLE @lt_temp
*     UP TO 50 ROWS.
*
*   out->write( |Tabla con { lines( lt_temp ) } registros| ).
*
*   " Opción 1: CLEAR (mantiene memoria)
*   CLEAR lt_temp.
*   out->write( |Después de CLEAR: { lines( lt_temp ) } - memoria reservada| ).
*
*   " Rellenar otra vez
*   SELECT FROM /DMO/I_Customer
*     FIELDS *
*     INTO CORRESPONDING FIELDS OF TABLE @lt_temp
*     UP TO 50 ROWS.
*
*   " Opción 2: FREE (libera memoria)
*   FREE lt_temp.
*   out->write( |Después de FREE: { lines( lt_temp ) } - memoria liberada| ).
*
*   " Rellenar otra vez
*   SELECT FROM /DMO/I_Customer
*     FIELDS *
*     INTO CORRESPONDING FIELDS OF TABLE @lt_temp
*     UP TO 50 ROWS.
*
*   " Opción 3: VALUE #() (forma moderna, igual que CLEAR)
*   lt_temp = VALUE #( ).
*
*   out->write( |Después de VALUE #(): { lines( lt_temp ) } - forma moderna| ).
*   out->write( |\n| ).
*
**   "=================================================================
**   " RESUMEN
**   "=================================================================
**   out->write( |RESUMEN:| ).
**   out->write( |DELETE:| ).
**   out->write( |DELETE tabla INDEX n -> Elimina posición n| ).
**   out->write( |DELETE tabla WHERE condición -> Elimina por condición| ).
**   out->write( |DELETE ADJACENT DUPLICATES -> Elimina duplicados (primero SORT)| ).
**   out->write( | | ).
**   out->write( |VACIAR TABLA:| ).
**   out->write( |CLEAR tabla -> Vacía, mantiene memoria| ).
**   out->write( |FREE tabla -> Vacía ->, libera memoria| ).
**   out->write( |tabla = VALUE #()- Forma moderna (igual que CLEAR)| ).
*
*
*"COLLECT
*   " Estructura para ventas
*
*   TYPES: BEGIN OF ty_venta,
*            producto  TYPE string,
*            cantidad  TYPE i,
*            importe   TYPE p LENGTH 10 DECIMALS 2,
*          END OF ty_venta.
*
*   " Tabla HASHED con clave en producto
*   " HASHED es perfecto para COLLECT - búsqueda rápida por clave
*
*   DATA lt_ventas_acumuladas TYPE HASHED TABLE OF ty_venta
*     WITH UNIQUE KEY producto.
*
*   DATA ls_venta TYPE ty_venta.
*
*   out->write( |Simulando ventas del día...| ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " Simulamos ventas que van llegando durante el día
*   "=================================================================
*
*   " Primera venta de Laptop
*   ls_venta = VALUE #( producto = 'Laptop' cantidad = 2 importe = 1000 ).
*
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*
*   out->write( |Venta 1: 2 Laptops por 1000 EUR| ).
*
*   " Venta de Mouse
*   ls_venta = VALUE #( producto = 'Mouse' cantidad = 5 importe = 50 ).
*
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*
*   out->write( |Venta 2: 5 Mouse por 50 EUR| ).
*
*   " Segunda venta de Laptop - COLLECT sumará automáticamente
*
*   ls_venta = VALUE #( producto = 'Laptop' cantidad = 1 importe = 500 ).
*
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*
*   out->write( |Venta 3: 1 Laptop por 500 EUR (se suma a la anterior)| ).
*
*   " Otra venta de Mouse - COLLECT sumará
*   ls_venta = VALUE #( producto = 'Mouse' cantidad = 10 importe = 100 ).
*
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*
*   out->write( |Venta 4: 10 Mouse por 100 EUR (se suma a la anterior)| ).
*
*   " Venta de Teclado
*
*   ls_venta = VALUE #( producto = 'Teclado' cantidad = 3 importe = 150 ).
*
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*
*   out->write( |Venta 5: 3 Teclados por 150 EUR| ).
*
*   " Tercera venta de Laptop
*   ls_venta = VALUE #( producto = 'Laptop' cantidad = 1 importe = 600 ).
*
*   COLLECT ls_venta INTO lt_ventas_acumuladas.
*
*   out->write( |Venta 6: 1 Laptop por 600 EUR (se suma a las anteriores)| ).
*   out->write( |\n| ).
*   out->write( |RESULTADO: Ventas acumuladas por producto| ).
*
*   out->write( |=========================================| ).
*
*   LOOP AT lt_ventas_acumuladas INTO DATA(ls_acum).
*     out->write( |Producto: { ls_acum-producto }| ).
*     out->write( |  Cantidad total: { ls_acum-cantidad } unidades| ).
*     out->write( |  Importe total: { ls_acum-importe } EUR| ).
*     out->write( |---| ).
*   ENDLOOP.
*
*   out->write( |\n| ).
*   out->write( |Observa cómo COLLECT acumuló automáticamente:| ).
*   out->write( | Laptop: 2+1+1 = 4 unidades, 1000+500+600 = 2100 EUR| ).
*   out->write( | Mouse: 5+10 = 15 unidades, 50+100 = 150 EUR| ).
*   out->write( | Teclado: 3 unidades, 150 EUR (solo una venta)| ).
*   out->write( |\n| ).

*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN DE COLLECT:| ).
*   out->write( |=================| ).
*   out->write( |¿Qué hace?| ).
*   out->write( |  • Si la clave NO existe -> Inserta nuevo registro| ).
*   out->write( |  • Si la clave YA existe -> SUMA campos numéricos| ).
*   out->write( | | ).
*   out->write( |¿Cuándo usar?| ).
*   out->write( |   Para acumular totales (ventas, cantidades, importes)| ).
*   out->write( |   Con tablas HASHED o SORTED (rápidas)| ).
*   out->write( |   Cuando quieres evitar duplicados automáticamente| ).
*   out->write( | | ).
*   out->write( |¿Cuándo NO usar?| ).
*   out->write( |   Con tablas STANDARD (muy lento con muchos datos)| ).
*   out->write( |   Si no necesitas sumar, usa APPEND o INSERT| ).
*   out->write( | | ).
*   out->write( |Tipos de tabla recomendados:| ).
*   out->write( |  • HASHED TABLE -> Mejor rendimiento para COLLECT| ).
*   out->write( |  • SORTED TABLE -> También funciona bien| ).
*
*
*"BASE
*   " Estructura simple
*
*   TYPES: BEGIN OF ty_producto,
*            id     TYPE i,
*            nombre TYPE string,
*            precio TYPE i,
*          END OF ty_producto.
*
*   DATA lt_productos TYPE TABLE OF ty_producto.
*
*   DATA lt_productos_nuevos TYPE TABLE OF ty_producto.
*
*   " Primeros productos
*   lt_productos = VALUE #(
*     ( id = 1 nombre = 'Laptop' precio = 1000 )
*     ( id = 2 nombre = 'Mouse'  precio = 50 )
*   ).
*
*   out->write( |Productos iniciales: { lines( lt_productos ) }| ).
*   out->write( lt_productos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 1: SIN BASE con VALUE - Reemplaza todo
*   "=================================================================
*   out->write( |CASO 1: SIN BASE - Reemplaza todo| ).
*
*   lt_productos = VALUE #(
*     ( id = 3 nombre = 'Teclado' precio = 80 )
*   ).
*
*   out->write( |Resultado: { lines( lt_productos ) } producto| ).
*   out->write( |¡Se perdieron Laptop y Mouse!| ).
*   out->write( lt_productos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 2: CON BASE usando VALUE - Mantiene y agrega
*   "=================================================================
*
*   out->write( |CASO 2: CON BASE usando VALUE| ).
*   " Volver a crear los iniciales
*   lt_productos = VALUE #(
*     ( id = 1 nombre = 'Laptop' precio = 1000 )
*     ( id = 2 nombre = 'Mouse'  precio = 50 )
*   ).
*
*   " Agregar nuevos CON BASE
*   lt_productos = VALUE #( BASE lt_productos
*     ( id = 3 nombre = 'Teclado' precio = 80 )
*     ( id = 4 nombre = 'Monitor' precio = 300 )
*   ).
*
*   out->write( |Resultado: { lines( lt_productos ) } productos| ).
*   out->write( |¡Se mantuvieron los anteriores y se agregaron nuevos!| ).
*   out->write( lt_productos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " CASO 3: CON BASE usando CORRESPONDING
*   "=================================================================
*   out->write( |CASO 3: CON BASE usando CORRESPONDING| ).
*   " Reiniciar tabla
*   lt_productos = VALUE #(
*     ( id = 1 nombre = 'Laptop' precio = 1000 )
*     ( id = 2 nombre = 'Mouse'  precio = 50 )
*   ).
*   " Preparar productos nuevos de otra fuente
*   lt_productos_nuevos = VALUE #(
*     ( id = 3 nombre = 'Teclado' precio = 80 )
*     ( id = 4 nombre = 'Monitor' precio = 300 )
*     ( id = 5 nombre = 'Webcam'  precio = 120 )
*   ).
*   out->write( |Productos existentes: { lines( lt_productos ) }| ).
*   out->write( |Productos nuevos a agregar: { lines( lt_productos_nuevos ) }| ).
*
*   " SIN BASE: Reemplaza todo
*   lt_productos = CORRESPONDING #( lt_productos_nuevos ).
*   out->write( |Sin BASE - Solo quedan: { lines( lt_productos ) } productos| ).
*   out->write( |Se perdieron los 2 iniciales| ).
*   out->write( |\n| ).
*
*   " Reiniciar para demostrar CON BASE
*   lt_productos = VALUE #(
*     ( id = 1 nombre = 'Laptop' precio = 1000 )
*     ( id = 2 nombre = 'Mouse'  precio = 50 )
*   ).

*   " CON BASE: Mantiene los anteriores y agrega los nuevos
*   lt_productos = CORRESPONDING #( BASE ( lt_productos ) lt_productos_nuevos ).
*   out->write( |Con BASE - Total: { lines( lt_productos ) } productos| ).
*   out->write( |Se mantuvieron los 2 iniciales + se agregaron los 3 nuevos| ).
*   out->write( lt_productos ).
*   out->write( |\n| ).
*
*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN:| ).
*   out->write( |=========| ).
*   out->write( |Sin BASE (reemplaza todo):| ).
*   out->write( |   tabla = VALUE #( ... )| ).
*   out->write( |   tabla = CORRESPONDING #( otra_tabla )| ).
*   out->write( | | ).
*   out->write( |Con BASE (mantiene y agrega):| ).
*   out->write( |   tabla = VALUE #( BASE tabla ... )| ).
*   out->write( |   tabla = CORRESPONDING #( BASE ( tabla ) otra_tabla )| ).
*   out->write( | | ).
*   out->write( |Uso típico: Acumular datos de diferentes fuentes| ).


"Agrupación de registros
   " Obtener clientes
   SELECT FROM /DMO/I_Customer
     FIELDS CustomerID, FirstName, LastName, CountryCode, City
     INTO TABLE @DATA(lt_clientes).

   out->write( |Total de clientes: { lines( lt_clientes ) }| ).
   out->write( |\n| ).

   "=================================================================
   " CASO 1: GROUP BY simple (agrupar por país)
   "=================================================================

   out->write( |CASO 1: Agrupar clientes por país| ).
   out->write( |===============================| ).

   " Primer LOOP: Recorre cada GRUPO (cada país)
   LOOP AT lt_clientes ASSIGNING FIELD-SYMBOL(<fs_cliente>)

     GROUP BY <fs_cliente>-CountryCode.
     " <fs_cliente> contiene el PRIMER cliente de cada grupo

     out->write( |País: { <fs_cliente>-CountryCode }| ).

     " Segundo LOOP: Recorre los MIEMBROS de este grupo (todos los clientes del país)
     DATA lt_clientes_del_pais LIKE lt_clientes.

     CLEAR lt_clientes_del_pais.

     LOOP AT GROUP <fs_cliente> INTO DATA(ls_miembro).
       lt_clientes_del_pais = VALUE #( BASE lt_clientes_del_pais ( ls_miembro ) ).
     ENDLOOP.

     out->write( |  Total clientes: { lines( lt_clientes_del_pais ) }| ).
     out->write( lt_clientes_del_pais ).
     out->write( |---| ).
   ENDLOOP.

   out->write( |\n| ).

   "=================================================================
   " CASO 2: GROUP BY con CLAVE (más claro y potente)
   "=================================================================
   out->write( |CASO 2: Agrupar con clave (país + ciudad)| ).
   out->write( |======================================| ).

   " Agrupamos por país Y ciudad, creamos una clave con nombre

   LOOP AT lt_clientes ASSIGNING FIELD-SYMBOL(<fs_cli>) "Donde se hacen los grupos
     GROUP BY ( pais   = <fs_cli>-CountryCode
                ciudad = <fs_cli>-City )
     INTO DATA(ls_clave_grupo).

     out->write( |Grupo: { ls_clave_grupo-pais } - { ls_clave_grupo-ciudad }| ).

     " Acceder a los miembros usando la clave - Llenamos lt_grupo en una sola sentencia iterando el grupo

     DATA lt_grupo LIKE lt_clientes.

     lt_grupo = VALUE #(
       FOR ls_cliente_grupo IN GROUP ls_clave_grupo ( ls_cliente_grupo ) "extrae todos los registros completos de los clientes
     ).

     out->write( |  Clientes en { ls_clave_grupo-ciudad }: { lines( lt_grupo ) }| ).

     " Mostrar nombres
     LOOP AT lt_grupo INTO DATA(ls_det).
       out->write( |  { ls_det-FirstName } { ls_det-LastName }| ).
     ENDLOOP.

     out->write( |---| ).
   ENDLOOP.

   out->write( |\n| ).

   "=================================================================
   " CASO 3: GROUP BY sin miembros (solo contar - MÁS EFICIENTE)
   "=================================================================

   out->write( |CASO 3: Solo contar por país (sin acceder a miembros)| ).
   out->write( |===============================================| ).

   " WITHOUT MEMBERS = más rápido, solo para contar/resumir
   " GROUP INDEX = número de grupo (1, 2, 3...)
   " GROUP SIZE = cantidad de registros en el grupo

   LOOP AT lt_clientes ASSIGNING FIELD-SYMBOL(<fs_c>)
     GROUP BY ( pais  = <fs_c>-CountryCode
                indice = GROUP INDEX
                cantidad = GROUP SIZE )
     WITHOUT MEMBERS
     INTO DATA(ls_resumen).
     out->write( |Grupo #{ ls_resumen-indice }: { ls_resumen-pais } tiene { ls_resumen-cantidad } clientes| ).
   ENDLOOP.

*   "=================================================================
*   " RESUMEN
*   "=================================================================
*   out->write( |RESUMEN DE GROUP BY:| ).
*   out->write( |==================| ).
*   out->write( |Sintaxis básica:| ).
*   out->write( |  LOOP AT tabla GROUP BY campo.| ).
*   out->write( |    " Procesa cada grupo| ).
*   out->write( |    LOOP AT GROUP ... INTO miembro.| ).
*   out->write( |      " Procesa cada miembro del grupo| ).
*   out->write( |    ENDLOOP.| ).
*   out->write( |  ENDLOOP.| ).
*   out->write( | | ).
*   out->write( |Con clave (recomendado):| ).
*   out->write( |  GROUP BY ( campo1 = valor1 campo2 = valor2 ) INTO clave.| ).
*   out->write( | | ).
*   out->write( |Sin miembros (solo contar/resumir - más rápido):| ).
*   out->write( |  GROUP BY ( campo = valor cantidad = GROUP SIZE ) WITHOUT MEMBERS.| ).
*   out->write( | | ).
*   out->write( |Componentes útiles:| ).
*   out->write( |   GROUP INDEX → número secuencial del grupo| ).
*   out->write( |   GROUP SIZE → cantidad de registros en el grupo| ).
*
*
"=================================================================
   " CASO 4: DISCARDING DUPLICATES
   "=================================================================
   out->write( |CASO 3: DISCARDING DUPLICATES| ).
   out->write( |==========================| ).

   TYPES: BEGIN OF ty_venta,
            producto TYPE string,
            cantidad TYPE i,
          END OF ty_venta.

   " Tabla origen con duplicados (sin clave)

   DATA lt_ventas_dia TYPE TABLE OF ty_venta WITH EMPTY KEY.

   " Tabla destino con clave única (no permite duplicados)
   DATA lt_ventas_consolidadas TYPE SORTED TABLE OF ty_venta
     WITH UNIQUE KEY producto.

   " Ventas del día con productos repetidos
   lt_ventas_dia = VALUE #(
     ( producto = 'Laptop' cantidad = 2 )
     ( producto = 'Mouse' cantidad = 5 )
     ( producto = 'Laptop' cantidad = 1 )    " Duplicado - se ignora
     ( producto = 'Teclado' cantidad = 3 )
     ( producto = 'Mouse' cantidad = 2 )     " Duplicado - se ignora
   ).

   out->write( |Ventas del día: { lines( lt_ventas_dia ) } registros| ).
   out->write( lt_ventas_dia ).

   " Sin DISCARDING DUPLICATES -> DUMP (error en runtime)
   " lt_ventas_consolidadas = CORRESPONDING #( lt_ventas_dia ). " ¡ESTO FALLA!
   " Con DISCARDING DUPLICATES -> Toma el primero, ignora duplicados

   lt_ventas_consolidadas = CORRESPONDING #( lt_ventas_dia DISCARDING DUPLICATES ).

   out->write( |Consolidadas: { lines( lt_ventas_consolidadas ) } productos únicos| ).
   out->write( lt_ventas_consolidadas ).
   out->write( |\n| ).

   out->write( |DISCARDING DUPLICATES se usa cuando:| ).
   out->write( |   - Destino tiene clave UNIQUE| ).
   out->write( |   - Origen puede tener duplicados| ).
   out->write( |   - Quieres evitar DUMP por duplicados| ).


 ENDMETHOD.







ENDCLASS.
