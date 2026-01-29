// ============================================================================
// EJECUTOR DE CONSULTAS SQL INTERACTIVO
// ============================================================================

// Función para ejecutar consultas SQL simuladas
function executeQuery(button, queryId) {
    const resultsDiv = document.getElementById('results-' + queryId);

    // Cambiar estado del botón
    button.textContent = '⏳ Ejecutando...';
    button.classList.add('executing');
    button.disabled = true;

    // Simular ejecución de la consulta
    setTimeout(() => {
        // Generar y mostrar resultados
        generateQueryResults(queryId, resultsDiv);

        // Mostrar resultados
        resultsDiv.classList.add('show');

        // Scroll suave hacia los resultados
        resultsDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });

        // Cambiar estado del botón
        button.textContent = '✓ Ejecutado';
        button.classList.remove('executing');
        button.classList.add('executed');
        button.disabled = false;

        // Restaurar botón después de 3 segundos
        setTimeout(() => {
            button.textContent = '▶ Ejecutar SQL';
            button.classList.remove('executed');
        }, 3000);
    }, 1500); // Simular 1.5 segundos de ejecución
}

// Función para generar resultados HTML de cada consulta
function generateQueryResults(queryId, container) {
    let html = '';

    switch (queryId) {
        case 'query1':
            html = `
                <h4>Resultados de la Ejecución</h4>
                <div class="execution-log">
                    <p>→ Ejecutando: Ver precios originales...</p>
                    <p>✓ 12 filas consultadas</p>
                    <p>→ Ejecutando: UPDATE productos SET precio = ROUND(precio * 0.80, 2)...</p>
                    <p>✓ 12 filas actualizadas</p>
                    <p>→ Ejecutando: Ver precios con descuento...</p>
                    <p>✓ 12 filas consultadas</p>
                    <p style="color: #00ff00; font-weight: bold;">✓ Consulta ejecutada exitosamente</p>
                </div>

                <h5>Productos con Descuento Aplicado:</h5>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Producto</th>
                            <th>Precio Original</th>
                            <th>Precio con -20%</th>
                            <th>Ahorro</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>1</td><td>Laptop HP 15"</td><td>$599,990</td><td>$479,992</td><td>$119,998</td></tr>
                        <tr><td>2</td><td>Mouse Logitech MX Master</td><td>$49,990</td><td>$39,992</td><td>$9,998</td></tr>
                        <tr><td>3</td><td>Teclado Mecánico RGB</td><td>$79,990</td><td>$63,992</td><td>$15,998</td></tr>
                        <tr><td>4</td><td>Monitor Samsung 24"</td><td>$189,990</td><td>$151,992</td><td>$37,998</td></tr>
                        <tr><td>5</td><td>Audífonos Sony WH-1000XM4</td><td>$249,990</td><td>$199,992</td><td>$49,998</td></tr>
                        <tr><td>6</td><td>WebCam Logitech HD</td><td>$39,990</td><td>$31,992</td><td>$7,998</td></tr>
                        <tr><td>7</td><td>Disco Duro Externo 1TB</td><td>$59,990</td><td>$47,992</td><td>$11,998</td></tr>
                        <tr><td>8</td><td>Memoria RAM 16GB DDR4</td><td>$69,990</td><td>$55,992</td><td>$13,998</td></tr>
                        <tr><td>9</td><td>SSD Samsung 500GB</td><td>$89,990</td><td>$71,992</td><td>$17,998</td></tr>
                        <tr><td>10</td><td>Hub USB-C 7 puertos</td><td>$29,990</td><td>$23,992</td><td>$5,998</td></tr>
                        <tr><td>11</td><td>Cable HDMI 2.0 3m</td><td>$12,990</td><td>$10,392</td><td>$2,598</td></tr>
                        <tr><td>12</td><td>Mousepad Gaming XXL</td><td>$19,990</td><td>$15,992</td><td>$3,998</td></tr>
                    </tbody>
                </table>
            `;
            break;

        case 'query2':
            html = `
                <h4>Resultados de la Ejecución</h4>
                <div class="execution-log">
                    <p>→ Ejecutando consulta de stock crítico...</p>
                    <p>✓ JOIN entre inventario y productos completado</p>
                    <p>✓ Filtro aplicado: stock <= 5</p>
                    <p>✓ 4 productos encontrados con stock crítico</p>
                    <p style="color: #00ff00; font-weight: bold;">✓ Consulta ejecutada exitosamente</p>
                </div>

                <h5>Productos con Stock Crítico (≤ 5 unidades):</h5>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Producto</th>
                            <th>Stock</th>
                            <th>Estado</th>
                            <th>Acción Recomendada</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>10</td>
                            <td>Hub USB-C 7 puertos</td>
                            <td>2</td>
                            <td><span class="badge badge-danger">CRÍTICO</span></td>
                            <td>REPOSICIÓN URGENTE</td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>WebCam Logitech HD</td>
                            <td>3</td>
                            <td><span class="badge badge-danger">CRÍTICO</span></td>
                            <td>REPOSICIÓN URGENTE</td>
                        </tr>
                        <tr>
                            <td>12</td>
                            <td>Mousepad Gaming XXL</td>
                            <td>4</td>
                            <td><span class="badge badge-warning">BAJO</span></td>
                            <td>PROGRAMAR REPOSICIÓN</td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>Memoria RAM 16GB DDR4</td>
                            <td>5</td>
                            <td><span class="badge badge-warning">BAJO</span></td>
                            <td>PROGRAMAR REPOSICIÓN</td>
                        </tr>
                    </tbody>
                </table>
            `;
            break;

        case 'query3':
            html = `
                <h4>Resultados de la Ejecución</h4>
                <div class="execution-log">
                    <p>→ Iniciando bloque DO...</p>
                    <p>→ INSERT INTO ordenes... RETURNING id_orden</p>
                    <p>✓ Orden creada con ID: 15</p>
                    <p>→ INSERT INTO orden_items (4 productos)...</p>
                    <p>✓ 4 ítems insertados</p>
                    <p>→ Calculando subtotal, IVA y total...</p>
                    <p>✓ Cálculos completados</p>
                    <p>→ UPDATE ordenes SET total...</p>
                    <p>✓ Total actualizado</p>
                    <p style="color: #00ff00; font-weight: bold;">✓ Compra procesada exitosamente</p>
                </div>

                <h5>Detalle de la Compra (Orden #15):</h5>
                <table>
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Precio Unit.</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Laptop HP 15"</td>
                            <td>1</td>
                            <td>$599,990</td>
                            <td>$599,990</td>
                        </tr>
                        <tr>
                            <td>Mouse Logitech MX Master</td>
                            <td>2</td>
                            <td>$49,990</td>
                            <td>$99,980</td>
                        </tr>
                        <tr>
                            <td>Teclado Mecánico RGB</td>
                            <td>1</td>
                            <td>$79,990</td>
                            <td>$79,990</td>
                        </tr>
                        <tr>
                            <td>Audífonos Sony WH-1000XM4</td>
                            <td>1</td>
                            <td>$249,990</td>
                            <td>$249,990</td>
                        </tr>
                    </tbody>
                </table>

                <h5>Resumen Financiero:</h5>
                <table>
                    <thead>
                        <tr>
                            <th>Concepto</th>
                            <th>Monto</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Subtotal</strong></td>
                            <td>$1,029,950</td>
                        </tr>
                        <tr>
                            <td><strong>IVA (19%)</strong></td>
                            <td>$195,690.50</td>
                        </tr>
                        <tr style="background: #d4edda;">
                            <td><strong>TOTAL CON IVA</strong></td>
                            <td><strong>$1,225,640.50</strong></td>
                        </tr>
                    </tbody>
                </table>
            `;
            break;

        case 'query4':
            html = `
                <h4>Resultados de la Ejecución</h4>
                <div class="execution-log">
                    <p>→ Ejecutando consulta de ventas diciembre 2022...</p>
                    <p>→ JOIN entre ordenes y orden_items</p>
                    <p>→ Filtro aplicado: fecha BETWEEN '2022-12-01' AND '2022-12-31'</p>
                    <p>✓ 6 órdenes encontradas</p>
                    <p>✓ Agregaciones calculadas</p>
                    <p style="color: #00ff00; font-weight: bold;">✓ Consulta ejecutada exitosamente</p>
                </div>

                <h5>Resumen General - Diciembre 2022:</h5>
                <table>
                    <thead>
                        <tr>
                            <th>Total Órdenes</th>
                            <th>Unidades Vendidas</th>
                            <th>Total Neto</th>
                            <th>IVA (19%)</th>
                            <th>Total con IVA</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr style="background: #d1ecf1;">
                            <td><strong>6</strong></td>
                            <td><strong>18</strong></td>
                            <td><strong>$2,113,890</strong></td>
                            <td><strong>$401,639.10</strong></td>
                            <td><strong>$2,515,529.10</strong></td>
                        </tr>
                    </tbody>
                </table>

                <h5>Detalle por Orden:</h5>
                <table>
                    <thead>
                        <tr>
                            <th>Orden</th>
                            <th>Cliente</th>
                            <th>Fecha</th>
                            <th>Items</th>
                            <th>Unidades</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>4</td><td>María González</td><td>05/12/2022</td><td>2</td><td>3</td><td>$275,970</td></tr>
                        <tr><td>7</td><td>Juan Pérez</td><td>15/12/2022</td><td>2</td><td>3</td><td>$129,970</td></tr>
                        <tr><td>9</td><td>Ana Martínez</td><td>20/12/2022</td><td>2</td><td>2</td><td>$149,980</td></tr>
                        <tr><td>13</td><td>Laura Fernández</td><td>28/12/2022</td><td>2</td><td>3</td><td>$192,970</td></tr>
                        <tr><td>14</td><td>Pedro López</td><td>10/12/2022</td><td>3</td><td>3</td><td>$679,970</td></tr>
                    </tbody>
                </table>
            `;
            break;

        case 'query5':
            html = `
                <h4>Resultados de la Ejecución</h4>
                <div class="execution-log">
                    <p>→ Ejecutando CTE (WITH por_usuario AS...)...</p>
                    <p>→ JOIN entre usuarios y ordenes</p>
                    <p>→ GROUP BY y agregaciones calculadas</p>
                    <p>→ ORDER BY total_ordenes DESC</p>
                    <p>✓ Usuario con más órdenes identificado</p>
                    <p style="color: #00ff00; font-weight: bold;">✓ Consulta ejecutada exitosamente</p>
                </div>

                <h5>🏆 Cliente con Más Compras en 2022:</h5>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Email</th>
                            <th>Órdenes</th>
                            <th>Gasto Total</th>
                            <th>Ticket Promedio</th>
                            <th>Primera Compra</th>
                            <th>Última Compra</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr style="background: #fff3cd;">
                            <td>1</td>
                            <td><strong>María González</strong></td>
                            <td>maria.gonzalez@email.com</td>
                            <td><strong>4</strong></td>
                            <td><strong>$1,065,930</strong></td>
                            <td><strong>$266,482.50</strong></td>
                            <td>15/03/2022</td>
                            <td>05/12/2022</td>
                        </tr>
                    </tbody>
                </table>

                <h5>Detalle de Órdenes de María González:</h5>
                <table>
                    <thead>
                        <tr>
                            <th>Orden</th>
                            <th>Fecha</th>
                            <th>Productos</th>
                            <th>Unidades</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>1</td><td>15/03/2022</td><td>3</td><td>3</td><td>$729,970</td></tr>
                        <tr><td>2</td><td>20/06/2022</td><td>2</td><td>2</td><td>$229,980</td></tr>
                        <tr><td>3</td><td>10/09/2022</td><td>1</td><td>2</td><td>$119,980</td></tr>
                        <tr><td>4</td><td>05/12/2022</td><td>2</td><td>3</td><td>$275,970</td></tr>
                    </tbody>
                </table>

                <h5>Ranking de Clientes 2022:</h5>
                <table>
                    <thead>
                        <tr>
                            <th>Ranking</th>
                            <th>Cliente</th>
                            <th>Total Órdenes</th>
                            <th>Gasto Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>🥇 1</td><td>María González</td><td>4</td><td>$1,065,930</td></tr>
                        <tr><td>🥈 2</td><td>Juan Pérez</td><td>3</td><td>$959,930</td></tr>
                        <tr><td>🥉 3</td><td>Ana Martínez</td><td>2</td><td>$569,930</td></tr>
                        <tr><td>4</td><td>Carlos Rodríguez</td><td>2</td><td>$1,419,940</td></tr>
                        <tr><td>5</td><td>Laura Fernández</td><td>2</td><td>$302,950</td></tr>
                        <tr><td>6</td><td>Pedro López</td><td>1</td><td>$679,970</td></tr>
                    </tbody>
                </table>
            `;
            break;
    }

    container.innerHTML = html;
}
