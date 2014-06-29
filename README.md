liveCodeEvironmentChucK
=======================

Algunas clases y funciones para facilitar el hacer música basada en patrones rítmicos con ChucK.

Un ejemplo (debes tener [ChucK](http://chuck.cs.princeton.edu/release/) instalado)

``` $ clone https://github.com/son0p/liveCodeEvironmentChucK.git ```

``` $ cd liveCodeEnvironmentChucK```

``` $ chuck init.ck ```

En un editor de texto puede editar y alterar valores en los archivos bass.ck, drums.ck mel.ck

Ejemplo: Edita el archivo "mel.ck", puedes agregar intervalos al array de la línea 26.

```[-5, 0, 0, 0, 0, 0, 3, 3, 7, 7, 7, 7, 7, 12 ] @=> int optMel[]; ```

Agregue por ejemplo nuevos intervalos como 24, 32.

```[-5, 0, 0, 0, 0, 0, 3, 3, 7, 7, 7, 7, 7, 12, 24, 32 ] @=> int optMel[];```
