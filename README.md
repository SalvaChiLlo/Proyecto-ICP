# Proyecto-ICP
## Despliegue de una aplicación en AWS
El despliegue consta de dos partes:

### Preparación de las AMIs
La preparación de las AMIs está comletamente automatizada mediante Ansible.
```
cd Ansible
./generate-latest-ami.sh
```
Este script lanza a ejecución un playbook de Ansible el cual cuenta con las siguientes tareas:
1. Crear una instancia de EC2
  1. Configurar la instancia mediante `user_data`
2. Esperar a que finalice la configuración
3. Crear una AMI a partir de la instancia EC2 configurada.

Este playbook se ejecuta dos veces, una para crear la AMI del frontend y otra para crear la AMI del backend.

Una vez se han generado las nuevas AMIs, se puede pasar a desplegar la nueva infraestructura.

### Despliegue de la estructura
Mediante `Clouformation` se pueden desplegar estructuras personalizadas en AWS. Para lanzar nuestra infraestructura, primero tendremos que actualizar los ids de las AMIs a utilizar y después ya se podrá desplegar la infraestructura, para ello:
```
cd Cloudformation
./template.sh create
```

En caso de que querer actualizar la infraestructura, por, por ejemplo, un cambio a nuevas AMIs:
```
./template.sh update
```

Si se quiere obtener información de la infraestructura:
```
./template.sh describe
```

Si se quiere obtener una estimación de costes:
```
./template.sh estimate
```

Si se quiere eliminar toda la infraestructura:
```
./template.sh delete
```
