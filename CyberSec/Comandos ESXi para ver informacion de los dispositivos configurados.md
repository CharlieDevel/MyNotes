Para obtener información detallada sobre diferentes aspectos de un servidor ESXi, VMware proporciona una serie de comandos `esxcli` que te permiten listar y gestionar diversas configuraciones y recursos. Aquí te menciono algunos comandos similares al `esxcli network vswitch standard list` que te pueden ser útiles:

1. **Listado de Adaptadores de Red (NICs físicas)**:
   - Este comando te permite listar las NICs físicas (adaptadores de red) que están configuradas y disponibles en el host ESXi:

     ```bash
     esxcli network nic list
     ```

     Esto te mostrará una lista de todas las NICs físicas en el host ESXi, junto con detalles como el nombre, velocidad, estado, dirección MAC, etc.

2. **Listado de Puertos (Ports) de Conexión**:
   - Este comando muestra información sobre los puertos de conexión físicos y virtuales en el host ESXi:

     ```bash
     esxcli network port list
     ```

     Proporciona detalles sobre los puertos físicos y virtuales, como el nombre del puerto, el estado, la velocidad, el tipo (físico o virtual), etc.

3. **Información de Almacenamiento (Storage)**:
   - Para obtener información sobre los dispositivos de almacenamiento y sus configuraciones, puedes usar el siguiente comando:

     ```bash
     esxcli storage core device list
     ```

     Este comando muestra una lista de dispositivos de almacenamiento conectados al host ESXi, incluyendo detalles como el nombre del dispositivo, tipo, capacidad, estado, etc.

4. **Información de Memoria (Memory)**:
   - Para ver información sobre el uso de memoria y configuración de memoria en el host ESXi, puedes usar:

     ```bash
     esxcli hardware memory get
     ```

     Este comando muestra detalles sobre la memoria física instalada en el host ESXi, como la capacidad total, la velocidad, la configuración NUMA (si aplica), etc.

5. **Información de CPU (CPU)**:
   - Para obtener detalles sobre los procesadores y su configuración en el host ESXi, puedes utilizar el siguiente comando:

     ```bash
     esxcli hardware cpu list
     ```

     Este comando muestra información sobre los procesadores físicos y virtuales en el host ESXi, incluyendo detalles como el modelo, velocidad, número de núcleos, hyper-threading (si aplica), etc.

6. **Información de VMkernel (VMkernel)**:
   - Para ver configuraciones y detalles de red relacionados con VMkernel, puedes usar:

     ```bash
     esxcli network ip interface list
     ```

     Este comando muestra una lista de interfaces de red VMkernel en el host ESXi, junto con configuraciones como la dirección IP, máscara de red, estado, etc.

### Nota Importante:

- Los comandos `esxcli` pueden variar según la versión específica de ESXi que estés utilizando. Es recomendable consultar la documentación oficial de VMware o la ayuda integrada (`esxcli --help`) para obtener la lista completa de comandos y opciones disponibles en tu versión de ESXi.
- Algunos comandos pueden requerir privilegios elevados (como ser root) para ejecutarlos y ver toda la información detallada.
- La salida de estos comandos puede ser extensa y conviene filtrar o formatear la salida según sea necesario, por ejemplo, usando herramientas como `grep`, `awk` o `jq` para mejorar la legibilidad o extraer información específica.