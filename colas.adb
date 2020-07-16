package body Colas is
   -- Implementación de las operaciones
   procedure Poner (el_Elemento: Integer;
                     en_la_Cola: in out Cola) is
      C: Cola renames en_la_Cola; -- Se renombra para reducir
                                  -- la escritura                  
   begin
      C.Elementos (C.Último) := el_Elemento;
      C.Último := (C.Último+1) mod Tamaño;
      -- if C.Último = Índice'Last then    
      --    C.Último := Índice'First;
      -- else
      --   C.Último := C.Último + 1;
      -- end if;
      C.Número_de_Elementos := C.Número_de_Elementos + 1;
   end Poner;

   procedure Quitar (un_Elemento: out Integer;
                      de_la_Cola: in out Cola) is
      C: Cola renames de_la_Cola; -- Se renombra para reducir
                                  -- la escritura                  
   begin
      un_Elemento := C.Elementos (C.Primero);
      C.Primero := (C.Primero + 1) mod Tamaño;
      C.Número_de_Elementos := C.Número_de_Elementos - 1;
   end Quitar;

   function Está_Vacía (la_Cola: Cola) return Boolean is
   begin
      return la_Cola.Número_de_Elementos = 0;
   end Está_Vacía;

   function Está_Llena (la_Cola: Cola) return Boolean is
   begin
      return la_Cola.Número_de_Elementos = Tamaño;
   end Está_Llena;
end Colas;