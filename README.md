# PracticaLEMP

# Índice


<h1>Componentes de infraestructura</h1>


<h2>2.1 Equilibrador de carga (Nivel 1)</h2>


<h2>2.2 Servidor NFS (Nivel 2)</h2>


<h2>2.3 Servidor web (Nivel 2)</h2>


<h2>2.4 Servidor de base de datos (Nivel 3)</h2>


</h2>3.1 Definición de máquina virtual</h2>


3.2 Compartir guiones


Flujo de comunicación entre componentes.


Solicitud


1.
Finalidad de la infraestructura


El propósito de esta infraestructura es crear un entorno distribuido para alojar OwnCloud, una plataforma de almacenamiento en la nube privada.
La infraestructura está diseñada para ser escalable y tolerante a fallas mediante equilibrio de carga, almacenamiento conectado a la red y bases de datos configuradas de manera eficiente.



2.
Componentes de infraestructura


2.1 Equilibrio de carga (Nivel 1)


Qué hace: un equilibrador de carga distribuye el tráfico entrante entre servidores web.
Nginx se utiliza para manejar solicitudes y garantizar una distribución justa del tráfico.
Dirección IP: 192.168.60.1


Red: Se utiliza una red privada para comunicarse con los servidores de Internet.


Configuración: Nginx está configurado para equilibrar la carga entre servidores web utilizando un bloque maestro para reenviar solicitudes al servidor web cuando sea necesario.
2.2 Servidor NFS (Nivel 2)


Características: NFS Server proporciona un sistema de archivos compartido disponible para todos los servidores web, lo que garantiza el acceso central a los archivos OwnCloud.


Dirección IP: 192.168.60.30


Red: Se utiliza una red privada para comunicarse con los servidores de Internet.
Configuración: uso NFS para compartir carpetas OwnCloud entre servidores web.
La exportación NFS también está configurada para permitir el acceso desde la dirección IP del servidor web.
2.3 Servidor web (nivel 2)


Características: el servidor web ejecuta OwnCloud y maneja las solicitudes HTTP de los usuarios.
En este caso se utilizan dos servidores web para distribuir la carga.
Dirección IP: 192.168.60.10 y 192.168.60.20


Red: Red privada para balanceadores de carga y servidores NFS.


Configuración: en estos servidores, Nginx está configurado para admitir OwnCloud, los recursos compartidos se montan desde el servidor NFS y se configuran los permisos necesarios para acceder y ejecutar la aplicación.
2.4 Servidor de base de datos (Nivel 3)


Funciones: El servidor de base de datos almacena información de OwnCloud, como usuarios, archivos y configuraciones.


Dirección IP: 192.168.70.10


Red: Red privada utilizada para comunicarse con servidores de Internet.
Configuración: este servidor utiliza MariaDB para la gestión de bases de datos.
Se crea la base de datos owncloud y se configura el usuario con acceso desde el servidor web.
3.
Configurar roaming


3.1 Definición de máquina virtual


Load Balancer: Un balanceador que distribuye el tráfico entre servidores web.
Servidor web: dos servidores gestionan las solicitudes de los usuarios.


Servidor NFS: proporciona almacenamiento compartido para servidores web.
Servidor de base de datos: gestión de base de datos OwnCloud.


3.2 Escenario de compartir


Se configura un script de shell en cada máquina virtual para automatizar la instalación y configuración de los servicios requeridos:



El sistema se actualiza y se instalan los paquetes necesarios.
Nginx está configurado en servidores web y balanceadores de carga.


Servidor NFS configurado para compartir archivos OwnCloud.
La base de datos está configurada en MariaDB.


4.
Flujo de comunicación entre componentes.


Equilibrio de carga: los usuarios acceden a un equilibrador de carga para reenviar solicitudes a uno de los dos servidores web.


Servidor web: el servidor web procesa solicitudes, accediendo a archivos en el servidor NFS y en la base de datos para devolver la información solicitada.
Servidor NFS: proporciona almacenamiento centralizado, lo que garantiza que los archivos OwnCloud estén disponibles en ambos servidores web.


Base de datos: El servidor web se comunica con la base de datos MariaDB para gestionar la información de OwnCloud.
5. Conclusión


Esta infraestructura proporciona una solución de almacenamiento OwnCloud escalable y tolerante a fallos. Con equilibrio de carga, almacenamiento NFS compartido y bases de datos MariaDB, la infraestructura está diseñada para admitir más usuarios y garantizar una alta disponibilidad y confiabilidad.
Esta es la arquitectura ideal para entornos que requieren alta disponibilidad y fácil escalabilidad.

