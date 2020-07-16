package Colas is
   -- Definición de la estructura de la cola
   Tamaño: constant Natural := 32;
   subtype Índice is Natural range 0..Tamaño-1;
   type array_Elementos is array (Índice) of Integer;
   subtype Contadores is Natural range 0..Tamaño;
   type Cola is record
      Primero: Índice := Índice'First;
      Último: Índice := Índice'First;
      Número_de_Elementos: Contadores := 0;
      Elementos: array_Elementos;
   end record;

   -- Definición de las operaciones de la cola
   procedure Poner (el_Elemento: Integer;
                     en_la_Cola: in out Cola);
   procedure Quitar (un_Elemento: out Integer;
                      de_la_Cola: in out Cola);
   function Está_Vacía (la_Cola: Cola) return Boolean;
   function Está_Llena (la_Cola: Cola) return Boolean;
end Colas;