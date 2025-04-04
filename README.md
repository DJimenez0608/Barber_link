
# **BarberLink - Business Project**  
## **Inicio del proyecto: 3 de abril del 2025**  

## 📝 Descripción del Proyecto

**BarberLink** es una iniciativa que surge a partir de la necesidad de optimizar el uso del tiempo tanto para los clientes como para las barberías. El objetivo principal del proyecto es permitir que los usuarios puedan agendar sus citas en el momento que más les convenga, eliminando las largas esperas y mejorando su experiencia.

Además, BarberLink está diseñado para ayudar a las barberías a llevar un control más preciso y eficiente de sus operaciones diarias y mensuales. A través de la aplicación, cada establecimiento podrá tener una visión clara de sus ganancias, pérdidas, servicios más demandados, y áreas que requieren mejoras.

De esta manera, BarberLink no solo mejora la relación con los clientes, sino que también ofrece herramientas de análisis que permiten tomar decisiones estratégicas, identificar tendencias y potenciar los servicios que realmente atraen a las personas.

# **BarberLink - Business Project**

## 🏗️ Arquitectura MVVM

BarberLink sigue la arquitectura **MVVM (Model-View-ViewModel)**, lo que facilita la separación de responsabilidades y mejora la mantenibilidad del código. Esta arquitectura se organiza en tres capas principales:

- **Model (Modelo)**: Representa los datos y las reglas de negocio de la aplicación. Aquí se incluyen clases como `User` y `Cita`, que definen la estructura de los datos.
- **View (Vista)**: Contiene la interfaz gráfica y es responsable de mostrar la información al usuario. Pantallas como `HomeScreen`, `LoginScreen` y `ProfileScreen` forman parte de esta capa.
- **ViewModel (Modelo de Vista)**: Actúa como un intermediario entre la Vista y el Modelo, gestionando la lógica de presentación. Aquí se encuentran clases como `AuthViewModel` y `AppointmentViewModel`, que manejan la comunicación con los repositorios y actualizan la UI mediante `Provider`.

---

## 🛠️ **Uso de Firebase y Provider**

### 🔥 **Firebase**

Firebase es el backend de BarberLink y proporciona los siguientes servicios:

- **Autenticación**: Maneja el inicio de sesión y registro de usuarios.
- **Firestore**: Almacena información como usuarios, citas y transacciones.
- **Storage**: Guarda imágenes de perfil o fotos de los cortes de cabello.

Firebase es responsable de la gestión de datos en la nube y proporciona herramientas para la autenticación y almacenamiento de la información.

### 🌐 **Provider**

Provider se usa para gestionar el estado en la aplicación. En lugar de llamar directamente a Firebase en la UI, se pasa por un ViewModel o Provider que maneja la lógica de negocio.

### 🔄 **Cómo se complementan Firebase y Provider**

| **Función**            | **Responsable** |
|----------------------|------------------|
| Autenticación de usuarios | Firebase |
| Almacenamiento de datos | Firebase Firestore |
| Gestión de imágenes | Firebase Storage |
| Obtener datos de Firestore | Repositorios |
| Transformación de datos | ViewModel |
| Notificación de cambios a la UI | Provider |
| Manejo del estado de la app | Provider |
| Conexión entre UI y lógica de negocio | ViewModel |



### 🔥 **Acceso a Firebase**  
Para hacer uso de Firebase, deben acceder al siguiente enlace donde está creada la base de datos. Ahí pueden visualizar los cambios realizados en las colecciones y la autenticación:  

🔗 [Firebase Console - BarberLink](https://console.firebase.google.com/project/barberlink-a4f23/settings/iam?hl=es-419)  

### 📖 **Documentación Flutter-Firebase**  
Para facilitar la integración de Firebase con Flutter, pueden consultar la siguiente documentación:  
- 📚 [Guía oficial de Firebase para Flutter](https://firebase.google.com/docs/flutter?hl=es-419)  
- 🔗 [Documentación de FlutterFire](https://firebase.flutter.dev/docs/overview/) _(contiene información adicional)_  

### 🛠 **Instalación de Firebase en su PC**  
Es posible que necesiten instalar Firebase en sus computadoras. Pueden seguir la siguiente guía para hacerlo:  

🔗 [Guía de instalación de Firebase CLI](https://firebase.google.com/docs/cli?hl=es&authuser=0#install-cli-windows)  

### ⚠️ **IMPORTANTE**  
La aplicación ya tiene Firebase implementado. Solo necesitan descargar el código y configurarlo en sus computadoras para comenzar a trabajar.  

