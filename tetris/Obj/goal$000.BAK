/*****************************************************************************

		Copyright (c) My Company

 Project:  TETRISV2
 FileName: TETRISV2.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "tetris.inc"

domains
  ancho=integer
  tipo=integer
  centro=integer
  orientacion=integer					/*             X                             */
  postab=integer

  ficha=f(tipo,orientacion,postab)     /* Solo depende de la posicion x XXX  que es la del punto medio las del tipo 0 */

  juego=tipo*			       /* Es la secuencia de fichas a colocar */
  solucion=ficha*		       /* Es la solucion que que se genera para colocar las fichas en el tablero */
  
  filatab=postab*                      /* filatab tiene en el primer elemento la fila y en el resto los elementos de la fila
                                          4 0 0 0 0 0
                                          3 0 0 0 0 0 
                                          2 0 0 1 0 0
                                          1 0 1 1 1 0. El suelo seria [0,1,2,1,0]*/
  suelo=postab*
  tabla=filatab*
  tablero=tab(suelo,tabla)
  contador=integer
  tamanho=integer
  
  
predicates

  vacia(tablero)
  pinta(tablero)
  pintafila(filatab)
  escribelista(filatab)
  
  escribesol(solucion)
  
  backtrack(juego,tablero,solucion,solucion)
  
  regla(tablero,tipo,orientacion,postab,tablero)
  
  mete(ficha,tablero,tablero)
  
  cambia_fila(tabla,suelo,postab,postab,ancho,tabla,suelo)
  
  /*concatena(suelo,suelo,suelo)*/
  
  modifica(filatab,suelo,postab,postab,ancho,filatab,suelo)
  
  obtiene_fila(postab,suelo,postab,postab)
  
  extrae_fila(filatab,tabla,postab,postab)
  
  recalcula_suelo(suelo,postab,postab,tabla,suelo)
  
  recorrefila(postab,filatab,suelo,suelo)
  
  mayor(postab,postab,postab)
  
  filallena(filatab)
  
  quitafilas(tabla,postab,postab,tabla)
  
  renumera(tabla,postab,postab,tabla)
  
  anhade(tabla,postab,postab,tabla)
  
  recorta(tabla,postab,suelo,tabla,suelo)
  
  limpia_filas(tabla,suelo,suelo,tabla)  
  
  tetris()

clauses
/* Extrae la fila que nosotros queremos con el cuarto parámetro*/
/*Cuando el contador es igual a la fila_objetivo, extraemos la fila deseada*/
     
  extrae_fila(Fila,Tabla,Indice,Indice):-
      Tabla=[H|_],
      Fila=H.
      
  extrae_fila(Fila,[_|T],Cont,Fila_obj):-
      ContN=Cont-1,
      extrae_fila(Fila,T,ContN,Fila_obj).


     
/* El predicado permite obtener la altura de la columna deseada a través del parámetro suelos*/  
     
  obtiene_fila(Numfila,[H|_],Contador,Contador):-
     Numfila=H.
  
  obtiene_fila(Numfila,[_|T],Contador_int,Posicion):-
     ContadorN=Contador_int+1,
     obtiene_fila(Numfila,T,ContadorN,Posicion).


     
/* Recalcula el suelo nos dice por donde van los indices del suelo */
/* Ha llegado arriba del todo por lo que el suelo est? calculado */
/*El predicado para cuando el suelo final es igual que el inicial*/
     
  recalcula_suelo(Suelo_in,Contador,Limite,_,Suelo_out):-
     Contador<Limite,
     Suelo_out=Suelo_in.

/*Extrae la fila correspondiente, la divide en inicio y resto, recorre la fila calculando el suelo en cada caso*/
     
  recalcula_suelo(Suelo_in,Contador,Limite,Tabla,Suelo_out):-
     extrae_fila(Fila,Tabla,4,Contador),
     Fila=[Numero|Resto],
     recorrefila(Numero,Resto,Suelo_in,Suelo_int),
     Contadorn=Contador-1,
     recalcula_suelo(Suelo_int,Contadorn,Limite,Tabla,Suelo_out).



     
/* Vamos a recorrer la fila recalculando el suelo */
/*Caso en el que no hay más elementos de la fila*/
  recorrefila(_,[],_,[]).
     
/* Vamos iterando si hay un 0 esa posicion de suelo se queda como est? */
     
  recorrefila(Numero,[0|Cola],[S|Resto],Suelo_out):-
     recorrefila(Numero,Cola,Resto,Queda),
     Suelo_out=[S|Queda].
     
/*La fila empieza por el primer elemento, y el id de la fila se guarda en Numero*/     	
/*Cuando hay un 1. El suelo temporalmente es la fila */
/*El parámetro número es el identificador de la fila que recorre*/
/*Cuando este valor es mayor que el que había anteriormente, se cambia el valor de esa posición del suelo*/
     
  recorrefila(Numero,[H|T],[S_in|Resto],Suelo_out):-         
      recorrefila(Numero,T,Resto,Queda),
      H=1,
      mayor(S_in,Numero,S_out),                                 /* Ya esta detectad el suelo por arriba del 1 que se ha encontrado */
      Suelo_out=[S_out|Queda].
      
/* Para cuando el suelo est? por encima, necesita un predicado que determine el mayor de dos cantidades */
/*Comprueba el elemento mayor de entre los dos*/   
  mayor(A,B,Mayor):-
      A>B,
      Mayor=A.
/*Si el elemento A no es mayor que B, da igual lo que haya, y devolvemos B*/      
  mayor(_,M,M).
   
   
   
   
   
/* Determina si una fila esta llena de 1's */
/*Si el elemenot de la fila tiene un 1 pasa al segundo elemento, si contiene un cero falla*/

  filallena([]).
  
  filallena([1|Cola]):-
  	filallena(Cola).
  	
  	
  	
  	
/* Quita las filas que est?n llenas de unos */
/*Si el contador externo es igual al interno, devuelve tabla vacia porque ha llegado al final de la tabla (piso más alto)*/  
  quitafilas([],Contador_in,Contador_out,Tabla_out):-
     Contador_out=Contador_in,
     Tabla_out=[],!. /*El ! indica que si todas las sentencias son correctas pare el flujo de ejecución del predicado*/
 
 /*Caso en el que la fila no está llena de unos*/    
  quitafilas([HTabla|TTabla],Contador_in,Contador_out,Tabla_out):- 
     HTabla=[_|Numeros],    
     not(filallena(Numeros)),
     quitafilas(TTabla,Contador_in,Contador_out,Tabla_int),
     Tabla_out=[HTabla|Tabla_int].
     
/*Caso en el que la fila está llena de unos*/     
  quitafilas([H|Tabla_in],Contador_in,Contador_out,Tabla_out):-  /* Es para el caso que la fila de la cabeza est? llena de 1's */
     H=[_|Numeros], /*Esta H es la fila, y está separando el id de la fila (_) con los propios valores (Numeros)*/
     filallena(Numeros),/*Comprueba si la fila está llena de 1's*/
     Contador_int=Contador_in-1,
     quitafilas(Tabla_in,Contador_int,Contador_out,Tabla_int),
     Tabla_out=Tabla_int.

/*Contador_out se utiliza para saber cuantas filas tiene la tabla al final, después de haber eliminado las correspondientes*/
/*Con esto conseguimos que añadir sea simplemente comparar este número con 4*/
/*Si cambiamos este número de 4 a otro cualquiera en renumera, podemos hacer un tablero a nuestro gusto con la altura deseada*/



/* Sirve para renumerar las que han quedado tras eliminar */
/*Contador inicia en 0 y llega hasta el límite que es el número de filas tras aplicar quitafilas*/
     
  renumera(Tabla,Contador,Limite,Tabla):-
     Contador=Limite.
     
  renumera([Fila|Resto],Contador,Limite,Tabla_out):-   
     Contadorn=Contador+1,     
     renumera(Resto,Contadorn,Limite,Tabla_int),
     Fila=[_|TF],
     NuevaFila=4-(Contador+1), /*Lo cambié porque creo que estaba mal, antes era "NuevaFila=4-(Contadorn+1)"*/
     /*La razón por la que está mal es porque si yo uso contador nuevo , a la primera fila le asigna un 0*/
     /*Si queremos cambiar la altura del tablero hay que cambiar este número también */
     Filan=[NuevaFila|TF],
     Tabla_out=[Filan|Tabla_int].


/* Sirve para a?adir tantas filas como haya eliminado */  
/*Simplemente se van añadiendo filas llenas de ceros en la parte de arriba de la tabla*/
/*Cuando se da la tabla, el primer elemento es la fila más alta, en nuestro caso la 4*/

  anhade(Tabla_int,Contador,Limite,Tabla_out):-
     Contador>=Limite,
     Tabla_out=Tabla_int.

  anhade(Tabla_in,Contador,Limite,Tabla_out):-
     Contadorn=Contador + 1,
     FILAN=[Contadorn,0,0,0,0,0],
     Tabla_int=[FILAN|Tabla_in],
     anhade(Tabla_int,Contadorn,Limite,Tabla_out).


/*Sirve para limpiar las filas que est?n llenas de 1's */
  limpia_filas(Tabla_in,_,Suelo_out,Tabla_out):-
     quitafilas(Tabla_in,4,Quedan,Tabla_int),  /* 4 maximo de filas */
     Quedan<4,                  /* Es para el caso de que se haya quitado alguna fila */
     recorta(Tabla_int,Quedan,[0,0,0,0,0],Tabla_out,Suelo_out).

  limpia_filas(Tabla,Suelo,Suelo,Tabla).
 
 
 
 /*En el caso de que se haya quitado alguna fila porque estaba llena de unos, hay que usar la función recorta*/
  
  recorta(Tabla_entrada,Restantes,Suelo_entrada,Tabla_out,Suelo_out):-
     /* Renumera las que quedan */
     renumera(Tabla_entrada,0,Restantes,Tabla_semi),
     /* A?ade las nuevas vacias */
     anhade(Tabla_semi,Restantes,4,Tabla_out),
     recalcula_suelo(Suelo_entrada,4,1,Tabla_out,Suelo_out).

/* A Continuaci?n se generan los predicados que modifican el tablero con filas de un tama?o en una posicion */
     
/* 
FILAS DE 3 */
  /* Centradas en el 2 */
  modifica([A1,A2,A3,A4,A5],[_,_,_,S4,S5],Fila,2,3,Salida,Suelo_out):-
     A1=0,
     A2=0,
     A3=0,
     S1n=Fila,
     S2n=Fila,
     S3n=Fila,
     Salida=[1,1,1,A4,A5],
     Suelo_out=[S1n,S2n,S3n,S4,S5].

     /* TODO 
        Completar la implementacion de la regla para la columna 3*/
  modifica([A1,A2,A3,A4,A5],[S1,_,_,_,S5],Fila,3,3,Salida,Suelo_out):-
     /*Es obligatorio que las celdas que vamos a ocupar estén vacias*/
     A2=0,
     A3=0,
     A4=0,
     /*Ahora actualizamos el valor de suelo con el de la fila donde estamos colocando, es decir, actualizamos la altura*/
     S2n=Fila,
     S3n=Fila,
     S4n=Fila,
     /*Actualizamos la fila modificada*/
     Salida=[A1,1,1,1,A5],
     /*Actualizamos el suelo modificado*/
     Suelo_out=[S1,S2n,S3n,S4n,S5].



  /* Centradas en el 4 */   
  modifica([A1,A2,A3,A4,A5],[S1,S2,_,_,_],Fila,4,3,Salida,Suelo_out):-
     A3=0,
     A4=0,
     A5=0,
     S3n=Fila,
     S4n=Fila,
     S5n=Fila,
     Salida=[A1,A2,1,1,1],
     Suelo_out=[S1,S2,S3n,S4n,S5n].
     
/* FILAS de 2 */
  /* Centradas en el 1 */
  modifica([A1,A2,A3,A4,A5],[_,_,S3,S4,S5],Fila,1,2,Salida,Suelo_out):-
     A1=0,
     A2=0,
     S1n=Fila,
     S2n=Fila,
     Salida=[1,1,A3,A4,A5],
     Suelo_out=[S1n,S2n,S3,S4,S5].
     
  /* Centradas en el 2 */
  modifica([A1,A2,A3,A4,A5],[S1,_,_,S4,S5],Fila,2,2,Salida,Suelo_out):-
     A2=0,
     A3=0,
     S2n=Fila,
     S3n=Fila,
     Salida=[A1,1,1,A4,A5],
     Suelo_out=[S1,S2n,S3n,S4,S5].
     
  /* Centradas en el 3 */
  modifica([A1,A2,A3,A4,A5],[S1,S2,_,_,S5],Fila,3,2,Salida,Suelo_out):-
     A3=0,
     A4=0,
     S3n=Fila,
     S4n=Fila,
     Salida=[A1,A2,1,1,A5],
     Suelo_out=[S1,S2,S3n,S4n,S5].
     
  /* Centradas en el 4 */
  modifica([A1,A2,A3,A4,A5],[S1,S2,S3,_,_],Fila,4,2,Salida,Suelo_out):-
     A4=0,
     A5=0,
     S4n=Fila,
     S5n=Fila,
     Salida=[A1,A2,A3,1,1],
     Suelo_out=[S1,S2,S3,S4n,S5n].


     
/* FILAS de 1 */
  /* Centradas en el 1 */
  modifica([A1,A2,A3,A4,A5],[S1,S2,S3,S4,S5],_,1,1,Salida,Suelo_out):-
     A1=0,
     Salida=[1,A2,A3,A4,A5],
     S1n=S1+1,
     Suelo_out=[S1n,S2,S3,S4,S5].
  
  /* Centradas en el 2 */      
  modifica([A1,A2,A3,A4,A5],[S1,S2,S3,S4,S5],_,2,1,Salida,Suelo_out):-
     A2=0,
     Salida=[A1,1,A3,A4,A5],
     S2n=S2+1,
     Suelo_out=[S1,S2n,S3,S4,S5].
     
  
  /* Centradas en el 3 */      
  modifica([A1,A2,A3,A4,A5],[S1,S2,S3,S4,S5],_,3,1,Salida,Suelo_out):-
     A3=0,
     Salida=[A1,A2,1,A4,A5],
     S3n=S3+1,
     Suelo_out=[S1,S2,S3n,S4,S5]. 
     
  /* Centradas en el 4 */      
  modifica([A1,A2,A3,A4,A5],[S1,S2,S3,S4,S5],_,4,1,Salida,Suelo_out):-
     A4=0,
     Salida=[A1,A2,A3,1,A5],
     S4n=S4+1,
     Suelo_out=[S1,S2,S3,S4n,S5]. 
  
  
  /* Centradas en el 5 */      
  modifica([A1,A2,A3,A4,A5],[S1,S2,S3,S4,S5],_,5,1,Salida,Suelo_out):-
     A5=0,
     Salida=[A1,A2,A3,A4,1],
     S5n=S5+1,
     Suelo_out=[S1,S2,S3,S4,S5n]. 
     
     


   
/* A PARTIR DE AQUI VIENEN LAS INTRODUCCIONES DE LAS FICHAS */
/*  TIPO   1. LA T invertida*/

/*        X  */
/* Ficha XXX*/
/* Orientacion 0 */     
  mete(f(1,0,Columna),Tablero_in,Tablero_out):-  /*es una T.-->1  con la base horizontal --> 0 centrada en el pivote --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     /* Predicado que determina el nivel del suelo */
     /* afectados(Suelo_in,1,0,Columna,Suelo_partida),*/    /* ANCHO 3*/ /* Suelo_out Son los afectados para colocar una filita de tres */
     
     
     
     /*inserta en la fila x columna y long z*/
     /* Fila se obtiene del suelo_out. Es la fila, elemento de suelo, que est? definido en la columna */
     /*Aquí queremos el valor de la altura de la columna que le estamos pasando como parámetro para colocar la ficha*/
     /* CAMBIO obtiene_fila(Fila,Suelo_partida,1,Columna),*/
     Columna>1,Columna<5,
     /* Fila se obtiene del suelo_out*/  
     /* Tiene que analizar 2 columnas: Columna0 --> Fila0 Columna --> Fila1  y Columna2=Columna+1  --> Fila2
        Filan1=Fila1+1 y Filan2=Fila2+1
        y hay que verificar que Filan2<=Filan1+1. 3<=2+1 por ejemplo cabe */
     Columna1=Columna-1,
     Columna3=Columna+1,
     
     /*Obtiene fila recorre el vector suelo, y devuelve el valor de la altura correspondiente a la columna que le pasamos como parámetro*/
     obtiene_fila(Fila1,Suelo_in,1,Columna1),           
     obtiene_fila(Fila2,Suelo_in,1,Columna),
     obtiene_fila(Fila3,Suelo_in,1,Columna3),
     
     /*Sumamos 1 a todos los valores del suelo*/
          
     Fila1n=Fila1+1,
     Fila2n=Fila2+1,
     Fila3n=Fila3+1,
     
     
     /*Los valores de la altura de la columna anterior y posterior a la de referencia deben de ser iguales o menores a la altura de la col. de ref.*/
     /*Estas comprobaciones se deben a que la pieza de T invertida no puede quedar sostenida solamente de una esquina de la base*/
     /*Tiene que quedar soportada por la celda central, o bien por varias de las celdas de la parte inferior*/
     Fila1n<=Fila2n,
     Fila3n<=Fila2n,
     
     /*Asignamos el valor de la altura de la columna de referencia a Filanueva y comprobamos que no se salga del tablero*/
     
     Fila1n<4,
     
     /*Cambiamos las filas*/
     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna,3,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,1,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).
     
     
     
     

/*       X  */
/*       XX */
/* Ficha X  */
/* Orientacion 1 */    
 
mete(f(1,1,Columna),Tablero_in,Tablero_out):-  /*es una T.-->1  con la base horizontal --> 0 centrada en el pivote --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     /* Predicado que determina el nivel del suelo */
     /* afectados(Suelo_in,1,1,Columna,Suelo_partida), NO ESTABA DEFINIDO */    /* ANCHO 1*/ /* Suelo_out Son los afectados para colocar una fila de 1, 1 de 2 y 1 de 1 */
   
     /*inserta en la fila x columna y long z*/
     Columna>=1,Columna<5,  /*He cambiado el <= 5 por <5 porque el pivote está en la primera columna que se inserta (creo que estaba mal)*/

     /* Fila se obtiene del suelo_out*/  
     /* Tiene que analizar 2 columnas: Columna --> Fila1  y Columna2=Columna+1  --> Fila2
        Filan1=Fila1+1 y Filan2=Fila2+1
        y hay que verificar que Filan2<=Filan1+1. 3<=2+1 por ejemplo cabe */ 
     Columna2=Columna+1,       
     obtiene_fila(Fila1,Suelo_in,1,Columna),
     obtiene_fila(Fila2,Suelo_in,1,Columna2),
          
     Fila2n=Fila2+1,
     Fila1n=Fila1+1,
     
     Fila2n<=Fila1n+1,
     
     Fila1n<3,
     
     
     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna,1,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,2,Tabla_int2,Suelo_int2),
     Fila3=Fila22+1,
     cambia_fila(Tabla_int2,Suelo_int2,Fila3,Columna,1,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).

/*       XXX  */
/* Ficha  X */
/* Orientacion 2 */     
  mete(f(1,2,Columna),Tablero_in,Tablero_out):-  /*es una T.-->1  con la base horizontal --> 0 centrada en la columna --> 3*/
	

     /* TODO 
        Completar la implementacion de la regla */

     Tablero_in=tab(Suelo_in,Tabla_in),
     Columna>1,Columna<5,
     Columna1 = Columna - 1,
     Columna3 = Columna + 1,
     obtiene_fila(Fila1,Suelo_in,1,Columna1),
     obtiene_fila(Fila2, Suelo_in,1, Columna),
     obtiene_fila(Fila3,Suelo_in,1,Columna3),
     
     Fila1n = Fila1 + 1,
     Fila2n = Fila2 + 1,
     Fila3n = Fila3 + 1,
     
     /*Realizamos las comprobaciones para que las columnas de las celdas de los extremos tengan una altura inferior o igual a la de la columna de referencia*/
     Fila1n <= Fila2n + 1,
     Fila3n <= Fila2n + 1,
     
     /*Comprobamos que la ficha no se sale del tablero por arriba*/
     Fila2n<=3,
     
     /*Añadimos las celdas a cada una de las filas*/
     cambia_fila(Tabla_in,Suelo_in,Fila2n,Columna,1,Tabla_int,Suelo_int),
     Fila22=Fila2n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,3,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).
     
     


/*        X  */
/*       XX  */
/* Ficha  X  */
/* Orientacion 3 */     
mete(f(1,3,Columna),Tablero_in,Tablero_out):-  /*es una T.-->1  con la base horizontal --> 0 centrada en pivote --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     
     Columna > 1, Columna <= 5, /*Aquí si que puede ser la columna igual a 5 porque el pivote está en la segunda columna a insertar*/
     Columna1 = Columna -1,
     obtiene_fila(Fila1,Suelo_in,1,Columna1),
     obtiene_fila(Fila2, Suelo_in,1, Columna),
     
     Fila1n = Fila1 + 1,
     Fila2n = Fila2 + 1,
     
     /*Esto se comprueba para que el elemento saliente de la T no tenga ningún obstáculo por encima de la altura en la que se va a colocar*/
     Fila1n<=Fila2 + 1,
      
     
     /*Comprobamos las alturas*/
     Fila2n < 3, /*Si esta altura es 2 podemos colocar la pieza sin problemas*/
     
     /*Añadimos celdas*/
     /*Añadimos la primera celda*/
     cambia_fila(Tabla_in,Suelo_in,Fila2n,Columna,1,Tabla_int,Suelo_int),
     Fila22=Fila2n+1,
     /*Añadimos la segunda fila de 2 celdas, teniendo en cuenta que la referencia la tenemos en la columna de antes de la referencia, esto es en la columna0*/
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna1 ,2,Tabla_int2,Suelo_int2),
     Fila3=Fila22+1,
     cambia_fila(Tabla_int2,Suelo_int2,Fila3,Columna,1,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).

     
      
/*  TIPO   2. CUADRADO */     
/*               */
/*       XX      */
/* Ficha XX     */
/* Orientacion CUalquiera*/     
mete(f(2,_,Columna),Tablero_in,Tablero_out):-  /*es un cuadrado.-->1  con la base horizontal --> 0 centrada en la esquina izqd --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     /* Predicado que determina el nivel del suelo */
     /* afectados(Suelo_in,2,_,Columna,Suelo_partida), NO ESTABA DEFINIDO */   /* ANCHO 1*/ /* Suelo_out Son los afectados para colocar una fila de 1, 1 de 2 y 1 de 1 */
     Columna>=1,Columna<5,

     /*inserta en la fila x columna y long z*/
     
          /* Fila se obtiene del suelo_out*/  
     /* Tiene que analizar 2 columnas: Columna --> Fila1  y Columna2=Columna+1  --> Fila2
        Filan1=Fila1+1 y Filan2=Fila2+1
        y hay que verificar que Filan2<=Filan1. 3<=2+1 por ejemplo cabe */ 
     Columna2=Columna+1,       
     obtiene_fila(Fila1,Suelo_in,1,Columna),
     obtiene_fila(Fila2,Suelo_in,1,Columna2),
          
     Fila2n=Fila2+1,
     Fila1n=Fila1+1,
     
     Fila2n<=Fila1n,
     
     Fila1n<4,

     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna,2,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,2,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).
     

/*TIPO 3. ELE  */
/*             */
/*         X   */
/* Ficha XXX
          ^
          |
       pivote
   */    
mete(f(3,0,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 0 centrada en la mitad de Largo --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     /* Predicado que determina el nivel del suelo */
     /* afectados(Suelo_in,3,0,Columna,Suelo_partida),  NO ESTABA DEFINIDO*/  /* ANCHO 1*/ /* Suelo_out Son los afectados para colocar una fila de 3, y 1 de 1 */
     Columna>1,Columna<5,
     /* Fila se obtiene del suelo_out*/  
     /* Tiene que analizar 2 columnas: Columna0 --> Fila0 Columna --> Fila1  y Columna2=Columna+1  --> Fila2
        Filan1=Fila1+1 y Filan2=Fila2+1
        y hay que verificar que Filan2<=Filan1+1. 3<=2+1 por ejemplo cabe */
     Columna1=Columna-1,
     Columna3=Columna+1,
     obtiene_fila(Fila1,Suelo_in,1,Columna1),           
     obtiene_fila(Fila2,Suelo_in,1,Columna),
     obtiene_fila(Fila3,Suelo_in,1,Columna3),
          
     Fila1n=Fila1+1,
     Fila2n=Fila2+1,
     Fila3n=Fila3+1,
     
     Fila1n<=Fila2n,
     Fila3n<=Fila2n,
     
     Fila1n<4,

     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna,3,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_in,Suelo_in,Fila22,Columna3,1,Tabla_int,Suelo_int),
     limpia_filas(Tabla_int,Suelo_int,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).


     
/*FICHA ELE    */
/*       X     */
/*       X     */
/* Ficha XX    */     
mete(f(3,1,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 1 centrada en la columna --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     /* Predicado que determina el nivel del suelo */
     /* afectados(Suelo_in,3,1,Columna,Suelo_partida), NO ESTABA DEFINIDO*/   /* ANCHO 1*/ /* Suelo_out Son los afectados para colocar una fila de 3, y 1 de 1 */
     Columna>=1,Columna<5,
          /* Fila se obtiene del suelo_out*/  
     /* Tiene que analizar 2 columnas: Columna --> Fila1  y Columna2=Columna+1  --> Fila2
        Filan1=Fila1+1 y Filan2=Fila2+1
        y hay que verificar que Filan2<=Filan1. 3<=2+1 por ejemplo cabe */
     Columna2=Columna+1,        
     obtiene_fila(Fila1,Suelo_in,1,Columna),
     obtiene_fila(Fila2,Suelo_in,1,Columna2),
          
     Fila2n=Fila2+1,
     Fila1n=Fila1+1,
     
     Fila2n<=Fila1n,
     
     Fila1n<3,

     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna,2,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,1,Tabla_preint,Suelo_preint),
     Fila3=Fila22+1,
     cambia_fila(Tabla_preint,Suelo_preint,Fila3,Columna,1,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).

     
/*FICHA ELE    */
/*             */
/*       XXX   */
/* Ficha X     */     
mete(f(3,2,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 1 centrada en la columna --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     /* Predicado que determina el nivel del suelo */
     /* afectados(Suelo_in,3,2,Columna,Suelo_partida), NO ESTABA DEFINIDO*/   /* ANCHO 1*/ /* Suelo_out Son los afectados para colocar una fila de 3, y 1 de 1 */
     Columna>1,Columna<5,
     /* Fila se obtiene del suelo_out*/  
     /* Tiene que analizar 2 columnas: Columna0 --> Fila0 Columna --> Fila1  y Columna2=Columna+1  --> Fila2
        Filan1=Fila1+1 y Filan2=Fila2+1
        y hay que verificar que Filan2<=Filan1+1. 3<=2+1 por ejemplo cabe */
     Columna1=Columna-1,
     Columna3=Columna+1,
     obtiene_fila(Fila1,Suelo_in,1,Columna1),           
     obtiene_fila(Fila2,Suelo_in,1,Columna),
     obtiene_fila(Fila3,Suelo_in,1,Columna3),
          
     Fila1n=Fila1+1,
     Fila2n=Fila2+1,
     Fila3n=Fila3+1,
     
     Fila1n<=Fila2n-1,
     Fila3n<=Fila2n,
     
     
     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna1,1,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_in,Suelo_in,Fila22,Columna,3,Tabla_int,Suelo_int),
     limpia_filas(Tabla_int,Suelo_int,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).
     
     

/*FICHA ELE   */
/*       XX   */
/*        X   */
/* Ficha  X   */
/* Orientacion CUalquiera*/     
mete(f(3,3,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 1 centrada en la columna --> 3*/
     Tablero_in=tab(Suelo_in,Tabla_in),
     /* Predicado que determina el nivel del suelo */
     /* afectados(Suelo_in,3,3,Columna,Suelo_partida), NO ESTABA DEFINIDO*/   /* ANCHO 1*/ /* Suelo_out Son los afectados para colocar una fila de 3, y 1 de 1 */
     Columna>1,Columna<=5,
     /*inserta en la fila x columna y long z*/

     /* Fila se obtiene del suelo_out*/  
     /* Tiene que analizar 2 columnas: Columna --> Fila1  y Columna2=Columna-1  --> Fila2
        Filan1=Fila1+1 y Filan2=Fila2+1
        y hay que verificar que Filan2<=Filan1+1. 3<=2+1 por ejemplo cabe */  
     Columna1=Columna-1,      
     obtiene_fila(Fila1,Suelo_in,1,Columna1),
     obtiene_fila(Fila2,Suelo_in,1,Columna),

     Fila1n = Fila1 + 1,
     Fila2n = Fila2 + 1,
     
     /*Esto se debe a que la columna1 se va a escribir dos filas por encima de la segunda columna*/
     Fila1n <= Fila2n + 2,
     
     /*Comprobaciones para que la figura quepa*/
     Fila2n < 3,
     
     
     /*Añadimos las celdas*/
     cambia_fila(Tabla_in,Suelo_in,Fila2n,Columna,1,Tabla_int,Suelo_int),
     Fila22=Fila2n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,1,Tabla_preint,Suelo_preint),
     Fila3=Fila22+1,
     cambia_fila(Tabla_preint,Suelo_preint,Fila3,Columna1,2,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).
     
           
        
/*FICHA ELE_INV*/
/*             */
/*       X     */
/* Ficha XXX   */     
mete(f(4,0,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 0 centrada en la mitad palo largo --> 3*/

/* En esta zona faltan todas las reglas de la implementaci?n de este tipo de ficha. Ser?an las cuatro orientaciones */

     Tablero_in=tab(Suelo_in,Tabla_in),
     Columna > 1, Columna <5,
     Columna1 = Columna - 1,
     Columna3 = Columna + 1,
     obtiene_fila(Fila1,Suelo_in,1,Columna1),
     obtiene_fila(Fila2,Suelo_in,1,Columna),
     obtiene_fila(Fila3,Suelo_in,1,Columna3),
     
     Fila1n = Fila1 + 1,
     Fila2n = Fila2 + 1,
     Fila3n = Fila3 + 1,
     
     Fila1n <= Fila2n,
     Fila3n <= Fila2n,
     
     Fila2n <= 3,
     
     
     cambia_fila(Tabla_in,Suelo_in,Fila2n,Columna,3,Tabla_int,Suelo_int),
     Fila22=Fila2n+1,
     cambia_fila(Tabla_in,Suelo_in,Fila22,Columna1,1,Tabla_int,Suelo_int),
     limpia_filas(Tabla_int,Suelo_int,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).
     




/*FICHA ELE_INV*/
/*       XX    */
/*       X     */
/* Ficha X     */     
mete(f(4,1,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 0 centrada en la mitad palo largo --> 3*/

/* En esta zona faltan todas las reglas de la implementaci?n de este tipo de ficha. Ser?an las cuatro orientaciones */

     Tablero_in=tab(Suelo_in,Tabla_in),
     Columna >= 1, Columna <5,
     Columna2 = Columna + 1,
     obtiene_fila(Fila1,Suelo_in,1,Columna),
     obtiene_fila(Fila2,Suelo_in,1,Columna2),
     
     Fila1n = Fila1 + 1,
     Fila2n = Fila2 + 1,
     
     Fila2n <= Fila1n + 2,
     
     Fila2n <= 2,
     
     
     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna,1,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,1,Tabla_preint,Suelo_preint),
     Fila3=Fila22+1,
     cambia_fila(Tabla_preint,Suelo_preint,Fila3,Columna,2,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).


/*FICHA ELE_INV*/
/*             */
/*       XXX   */
/* Ficha   X   */     
mete(f(4,0,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 0 centrada en la mitad palo largo --> 3*/

/* En esta zona faltan todas las reglas de la implementaci?n de este tipo de ficha. Ser?an las cuatro orientaciones */

     Tablero_in=tab(Suelo_in,Tabla_in),
     Columna > 1, Columna <5,
     Columna1 = Columna - 1,
     Columna3 = Columna + 1,
     obtiene_fila(Fila1,Suelo_in,1,Columna1),
     obtiene_fila(Fila2,Suelo_in,1,Columna),
     obtiene_fila(Fila3,Suelo_in,1,Columna3),
     
     Fila1n = Fila1 + 1,
     Fila2n = Fila2 + 1,
     Fila3n = Fila3 + 1,
     
     Fila1n <= Fila2n,
     Fila3n <= Fila2n - 1,
     
     Fila2n <= 4,
     
     
     cambia_fila(Tabla_in,Suelo_in,Fila3n,Columna3,1,Tabla_int,Suelo_int),
     Fila22=Fila3n+1,
     cambia_fila(Tabla_in,Suelo_in,Fila22,Columna,3,Tabla_int,Suelo_int),
     limpia_filas(Tabla_int,Suelo_int,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out).

 
 
 
/*FICHA ELE_INV*/
/*        X    */
/*        X    */
/* Ficha XX    */     
mete(f(4,1,Columna),Tablero_in,Tablero_out):-  /*es una L.-->1  con la base horizontal --> 0 centrada en la mitad palo largo --> 3*/

/* En esta zona faltan todas las reglas de la implementaci?n de este tipo de ficha. Ser?an las cuatro orientaciones */

     Tablero_in=tab(Suelo_in,Tabla_in),
     Columna > 1, Columna <= 5,
     Columna1 = Columna - 1,
     obtiene_fila(Fila1,Suelo_in,1,Columna1),
     obtiene_fila(Fila2,Suelo_in,1,Columna),
     
     Fila1n = Fila1 + 1,
     Fila2n = Fila2 + 1,
     
     Fila1n <= Fila2n,
     
     Fila2n <= 2,
     
     
     cambia_fila(Tabla_in,Suelo_in,Fila1n,Columna1,2,Tabla_int,Suelo_int),
     Fila22=Fila1n+1,
     cambia_fila(Tabla_int,Suelo_int,Fila22,Columna,1,Tabla_preint,Suelo_preint),
     Fila3=Fila22+1,
     cambia_fila(Tabla_preint,Suelo_preint,Fila3,Columna,1,Tabla_preout,Suelo_preout),
     limpia_filas(Tabla_preout,Suelo_preout,Suelo_out,Tabla_out),
     Tablero_out=tab(Suelo_out,Tabla_out). 
 
 
     
/*  FIN DE LAS FICHAS  */
/*Cambia filas consigue modificar la fila antigua por una nueva con las celdas a introducir realizando llamadas a otras funciones*/
  cambia_fila([],S,1,_,_,[],S).
  cambia_fila([],S,2,_,_,[],S).
  cambia_fila([],S,3,_,_,[],S).
  cambia_fila([],S,4,_,_,[],S).
  
  cambia_fila([H|T],Suelo_in,Fila,Columna,Ancho,Tabla_out,Suelo_out):-
     H=[FilaH|Resto],
     Fila=FilaH,
/*     write(Fila,'\t',FilaH,'\t',Columna,'\t',Ancho,'\n'),*/
     modifica(Resto,Suelo_in,Fila,Columna,Ancho,Resto_out,Suelo_out),
     H_out=[FilaH|Resto_out],
     Tabla_out=[H_out|T].
     
  cambia_fila([H|T],Suelo_in,Fila,Columna,Ancho,Tabla_out,Suelo_out):-
     /*NO es esta fila */ /*No se producen cambios en el Suelo*/
     cambia_fila(T,Suelo_in,Fila,Columna,Ancho,Tabla_int,Suelo_out),
     Tabla_out=[H|Tabla_int].
     
/* Predicados de inicializaci?n e impresion de resultados */
     
  vacia(Tablero):-     
     Suelo=[0,0,0,0,0],
     Filastab=[[4, 0, 0, 0, 0, 0],
               [3, 0, 0, 0, 0, 0],
               [2, 0, 0, 0, 0, 0],
               [1, 0, 0, 0, 0, 0]],
     Tablero=tab(Suelo,Filastab).
     
  pinta(tab(_,[])).
     
  pinta(tab(Suelo,Tablero)):-
     Tablero=[H|T],
     pintafila(H),
     write('\n'),
     pinta(tab(Suelo,T)).
     
  escribelista([]).
  
  escribelista([H|T]):-
  	write(H,'\t'),
  	escribelista(T).
     
  pintafila([H|T]):-
     write("Fila: ",H,'\t'),
     escribelista(T).

/* Predicado para describir las soluciones de como se colocan las fichas */    
/*Escribe para cada una de las fichas, su identificador, la orientación, y la columna donde se insertan*/ 
  escribesol([]).
  
  escribesol([H|T]):-
     escribesol(T),
     write(H,'\n').
     
     
     
/* Empiezan las reglas de colocacion */
/* Columna 1*/ 
  regla(Tab_in,Ficha,0,1,Tab_int):-  /*Est? claro es el tablero, el tipo de ficha, su orientaci?n, la columna y el resultado intermedio */
     mete(f(Ficha,0,1),Tab_in,Tab_int).

  regla(Tab_in,Ficha,1,1,Tab_int):-
     mete(f(Ficha,1,1),Tab_in,Tab_int).
     
     
  regla(Tab_in,Ficha,2,1,Tab_int):-
     mete(f(Ficha,2,1),Tab_in,Tab_int).
     
  regla(Tab_in,Ficha,3,1,Tab_int):-
     mete(f(Ficha,3,1),Tab_in,Tab_int).   
     
  /* TODO TODO TODO */
/* Columna 2*/
  regla(Tab_in,Ficha,0,2,Tab_int):-
     mete(f(Ficha,0,2),Tab_in,Tab_int).

  regla(Tab_in,Ficha,1,2,Tab_int):-
     mete(f(Ficha,1,2),Tab_in,Tab_int).


  regla(Tab_in,Ficha,2,2,Tab_int):-
     mete(f(Ficha,2,2),Tab_in,Tab_int).


  regla(Tab_in,Ficha,3,2,Tab_int):-
     mete(f(Ficha,1,2),Tab_in,Tab_int).
     
/* Columna 3*/
  regla(Tab_in,Ficha,0,3,Tab_int):-
     mete(f(Ficha,0,3),Tab_in,Tab_int).
  
  
  regla(Tab_in,Ficha,1,3,Tab_int):-
     mete(f(Ficha,1,3),Tab_in,Tab_int).


  regla(Tab_in,Ficha,2,3,Tab_int):-
     mete(f(Ficha,2,3),Tab_in,Tab_int).


  regla(Tab_in,Ficha,3,3,Tab_int):-
     mete(f(Ficha,3,3),Tab_in,Tab_int).


     
/* Columna 4*/
  regla(Tab_in,Ficha,0,4,Tab_int):-
     mete(f(Ficha,0,4),Tab_in,Tab_int).     
     
     
  regla(Tab_in,Ficha,1,4,Tab_int):-
     mete(f(Ficha,1,4),Tab_in,Tab_int).   
     
  
  regla(Tab_in,Ficha,2,4,Tab_int):-
     mete(f(Ficha,2,4),Tab_in,Tab_int).      
  
  
  regla(Tab_in,Ficha,3,4,Tab_int):-
     mete(f(Ficha,3,4),Tab_in,Tab_int).      
     

/* Columna 5*/
  regla(Tab_in,Ficha,0,5,Tab_int):-
     mete(f(Ficha,0,5),Tab_in,Tab_int). 
     
  
  regla(Tab_in,Ficha,1,5,Tab_int):-
     mete(f(Ficha,1,5),Tab_in,Tab_int).   
     
     
  regla(Tab_in,Ficha,2,5,Tab_int):-
     mete(f(Ficha,2,5),Tab_in,Tab_int).   
     
     
  regla(Tab_in,Ficha,3,5,Tab_int):-
     mete(f(Ficha,3,5),Tab_in,Tab_int).   
     
        
/*Este predicado nos permite escribir la ficha siempre gracias a que siempre falla al final con el atributo fail, es decir, que nunca se ejecuta completamente*/
/*     
  regla(Tab_in,Ficha,_,_,_):-
    write("Backtrack....",'\t'),write("Ficha: ",'\t'),write(Ficha,'\n'),pinta(Tab_in),write('\n'),fail.
*/
/* C?digo de backtrack */

  backtrack([],Tablero,Solucion,Solucion):-
     pinta(Tablero),
     escribesol(Solucion).
     
  backtrack(Lista, Tablero, Estado_actual, Solucion_Final) :-
     Lista=[H|T],
     regla(Tablero, H,Orientacion ,Col , Tablero_out),
     Nuevo_Estado_Actual=[f(H,Orientacion,Col)|Estado_actual],
     backtrack(T, Tablero_out, Nuevo_Estado_Actual, Solucion_Final).
     
  
/* TODO 

  Es evidente que se necesita implementar la parte recursiva */




  tetris():-
  
     vacia(T),
     backtrack([2,2,2,2],T,[],Solucion_Final),
     write(Solucion_Final,'\n').
   

goal

  tetris().