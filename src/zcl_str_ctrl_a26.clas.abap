CLASS zcl_str_ctrl_a26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_str_ctrl_a26 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

"     =  EQ (igual)
*     <> NE (diferente)
*     <  LT (menor que)
*     >  GT (mayor que)
*     <= LE (menor o igual)
*     >= GE (mayor o igual)

"NOT, AND, OR

*  "=================================================================
*    " 1. IF - Validar descuento según monto de compra
*    "=================================================================
*    out->write( '=== IF: CALCULAR DESCUENTO POR MONTO ===' ).
*
*    DATA(lv_monto_compra) = 500.
*    DATA(lv_descuento) = 0.
*
*    IF lv_monto_compra GE 1000.
*      lv_descuento = 10.  "10% de descuento
*      out->write( |Monto: { lv_monto_compra } - Descuento: { lv_descuento }%| ).
*
*    ELSEIF lv_monto_compra >= 500.
*      lv_descuento = 5.   "5% de descuento
*      out->write( |Monto: { lv_monto_compra } - Descuento: { lv_descuento }%| ).
*
*    ELSE.
*      out->write( |Monto: { lv_monto_compra } - Sin descuento| ).
*    ENDIF.
*    out->write( | | ).


    "=================================================================
*    " 2. CASE - Determinar estado de orden de compra
*    "=================================================================
*
*    out->write( '=== CASE: ESTADO DE ORDEN DE COMPRA ===' ).
*
*    DATA(lv_estado_orden) = 'E'. "A=Aprobada, P=Pendiente, R=Rechazada, E=Entregada
*
*    CASE lv_estado_orden.
*      WHEN 'A'.
*        out->write( 'Estado: APROBADA - Proceder con la entrega' ).
*      WHEN 'P'.
*        out->write( 'Estado: PENDIENTE - Esperando aprobación' ).
*      WHEN 'R'.
*        out->write( 'Estado: RECHAZADA - Contactar con compras' ).
*      WHEN 'E'.
*        out->write( 'Estado: ENTREGADA - Orden completada' ).
*      WHEN OTHERS.
*        out->write( 'Estado: DESCONOCIDO - Verificar sistema' ).
*    ENDCASE.
*    out->write( | | ).

*    "=================================================================
*    " 3. DO - Generar números de factura consecutivos
*    "=================================================================
*    out->write( '=== DO: GENERAR 5 NÚMEROS DE FACTURA ===' ).
*
*    DATA(lv_numero_factura) = 10001.
*    DATA(lv_contador) = 0.
*
*    DO 5 TIMES.
*      lv_contador = lv_contador + 1.
*      out->write( |Factura { lv_contador }: FAC-{ lv_numero_factura }| ).
*      lv_numero_factura = lv_numero_factura + 1.
*    ENDDO.
*
*    out->write( | | ).

*    "=================================================================
    " 4. WHILE - Procesar pagos hasta alcanzar el total
    "=================================================================
    out->write( '=== WHILE: PROCESAR PAGOS HASTA COMPLETAR DEUDA ===' ).

    DATA(lv_deuda_total) = 5000.
    DATA(lv_pago_acumulado) = 0.
    DATA(lv_numero_pago) = 0.

    WHILE lv_pago_acumulado < lv_deuda_total.
      lv_numero_pago = lv_numero_pago + 1.

      DATA(lv_pago) = 1500. "Pago de 1500 cada vez
      lv_pago_acumulado = lv_pago_acumulado + lv_pago.

      out->write( |Pago { lv_numero_pago }: { lv_pago } - Acumulado: { lv_pago_acumulado }| ).

      IF lv_pago_acumulado >= lv_deuda_total.
        out->write( '¡Deuda completamente pagada!' ).
      ENDIF.

    ENDWHILE.

    out->write( | | ).


*    "=================================================================
*    " 5. CHECK - Procesar solo facturas aprobadas
*    "=================================================================
*
*    out->write( '=== CHECK: PROCESAR SOLO FACTURAS APROBADAS ===' ).
*
*    TYPES: BEGIN OF ty_factura,
*             numero TYPE string,
*             estado TYPE c LENGTH 1, "A=Aprobada, P=Pendiente
*             monto  TYPE i,
*           END OF ty_factura.
*
*    DATA: lt_facturas TYPE TABLE OF ty_factura.
*
*    lt_facturas = VALUE #(
*      ( numero = 'FAC-001' estado = 'A' monto = 1000 )
*      ( numero = 'FAC-002' estado = 'P' monto = 1500 )
*      ( numero = 'FAC-003' estado = 'A' monto = 2000 )
*      ( numero = 'FAC-004' estado = 'P' monto = 500 )
*    ).
*    LOOP AT lt_facturas INTO DATA(ls_factura).
*      CHECK ls_factura-estado = 'A'. "Solo procesar aprobadas
*      out->write( |Procesando: { ls_factura-numero } - Monto: { ls_factura-monto }| ).
*    ENDLOOP.
*    out->write( | | ).


*    "=================================================================
*    " 6. LOOP - Calcular total de ventas por vendedor
*    "=================================================================
*    out->write( '=== LOOP: CALCULAR VENTAS POR VENDEDOR ===' ).
*
*    TYPES: BEGIN OF ty_venta,
*             vendedor TYPE string,
*             monto    TYPE i,
*           END OF ty_venta.
*
*    DATA: lt_ventas TYPE TABLE OF ty_venta.
*
*    lt_ventas = VALUE #(
*      ( vendedor = 'Juan' monto = 1000 )
*      ( vendedor = 'Maria' monto = 1500 )
*      ( vendedor = 'Juan' monto = 2000 )
*      ( vendedor = 'Maria' monto = 500 )
*    ).
*
*    DATA(lv_total_ventas) = 0.
*
*    LOOP AT lt_ventas INTO DATA(ls_venta).
*      lv_total_ventas = lv_total_ventas + ls_venta-monto.
*      out->write( |{ ls_venta-vendedor }: { ls_venta-monto }| ).
*    ENDLOOP.
*
*    out->write( |Total de ventas: { lv_total_ventas }| ).
*    out->write( | | ).

*    "=================================================================
*    " 7. SWITCH - Calcular comisión según categoría de producto
*    "=================================================================
*    out->write( '=== SWITCH: CALCULAR COMISIÓN POR CATEGORÍA ===' ).
*
*    DATA(lv_categoria) = 'ELECTRO'. "ELECTRO, ROPA, ALIMENTOS
*    DATA(lv_precio_producto) = 1000.
*
*    "ALT+SHIFT+A selección múltiple
*
*    DATA(lv_comision) = SWITCH decfloat34( lv_categoria
*                             WHEN 'ELECTRO'   THEN lv_precio_producto * '0.15'  "15%
*                             WHEN 'ROPA'      THEN lv_precio_producto * '0.10'  "10%
*                             WHEN 'ALIMENTOS' THEN lv_precio_producto * '0.05'  "5%
*                             ELSE                  lv_precio_producto * '0.03'  "3%
*                             ).
*
*    out->write( |Categoría: { lv_categoria }| ).
*    out->write( |Precio: { lv_precio_producto } - Comisión: { lv_comision }| ).
*    out->write( | | ).


*    "=================================================================
*    " 8. COND - Determinar prioridad de envío
*    "=================================================================
*    out->write( '=== COND: PRIORIDAD DE ENVÍO SEGÚN CLIENTE ===' ).
*
*    DATA(lv_tipo_cliente) = 'VIP'. "VIP, REGULAR, NUEVO
*
*    DATA(lv_prioridad) = COND string(
*                              WHEN lv_tipo_cliente = 'VIP'     THEN 'ENVÍO EXPRESS - 24 horas'
*                              WHEN lv_tipo_cliente = 'REGULAR' THEN 'ENVÍO ESTÁNDAR - 3-5 días'
*                              WHEN lv_tipo_cliente = 'NUEVO'   THEN 'ENVÍO ESTÁNDAR - 5-7 días'
*                              ELSE                                  'ENVÍO REGULAR - 7-10 días'
*    ).
*
*    out->write( |Cliente: { lv_tipo_cliente }| ).
*    out->write( |Prioridad: { lv_prioridad }| ).
*    out->write( | | ).

*    "=================================================================
*    " 9. TRY - Validar conversión de monto (manejo de errores)
*    "=================================================================
*    out->write( '=== TRY: CONVERTIR MONTO DE STRING A NÚMERO ===' ).
*
*    DATA(lv_monto_texto) = '1500.5A'. "Cantidad como texto
*
*    DATA: lv_monto_numero TYPE p DECIMALS 2.
*
*   TRY.
*        lv_monto_numero = lv_monto_texto.
*        out->write( |✓ Conversión exitosa: { lv_monto_numero }| ).
*        "Validar que el monto sea positivo
*        IF lv_monto_numero <= 0.
*          out->write( '✗ Error: El monto debe ser mayor a cero' ).
*        ELSE.
*          out->write( |Monto válido para procesamiento: { lv_monto_numero }| ).
*        ENDIF.
*      CATCH cx_sy_conversion_error INTO DATA(lx_error).
*        out->write( |✗ Error de conversión: { lx_error->get_text( ) }| ).
*    ENDTRY.
*    out->write( | | ).
*
*
*    "Ejemplo con error
*    out->write( '--- Ejemplo con dato inválido ---' ).
*    lv_monto_texto = 'ABC123'. "Texto inválido
*
*    TRY.
*        lv_monto_numero = lv_monto_texto.
*        out->write( |Conversión exitosa: { lv_monto_numero }| ).
*      CATCH cx_sy_conversion_error INTO lx_error.
*        out->write( |✗ No se pudo convertir "{ lv_monto_texto }" a número| ).
*        out->write( |  Razón: { lx_error->get_text( ) }| ).
*    ENDTRY.

  ENDMETHOD.

ENDCLASS.
