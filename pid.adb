with Ada.Real_Time; use Ada.Real_Time;

package body PID is
   -- Programar establece los parámetros del controlador del horno
   procedure Programar (el_Controlador: in out Controlador;
                        Kp, Ki, Kd:        Real) is
   begin

      el_Controlador := (Kp => Kp, Ki => Ki, Kd => Kd, S_Anterior => 0.0, Error_Anterior => 0.0);

   end Programar;

   -- Controlar se encarga de modificar el controlador y dar una salida U
   procedure Controlar(con_el_Controlador: in out Controlador;
                                     R, C:        Entrada;
                                        U: out    Salida) is
      E: Real;  	-- El error
      S: Real;		
      Up, Ui, Ud: Real;

      begin
	-- El error es la diferencia de los parámetros de entrada
        E := Real(R-C);
	-- Up = Kp * Error
	Up := con_el_Controlador.Kp * E;
	-- s = s anterior + error
	S := con_el_Controlador.S_Anterior + E;
	-- Ui = Ki*s
	Ui := con_el_Controlador.Ki * S;
	-- Ud = kd * (error - error anterior)
	Ud := con_el_Controlador.Kd * (E - con_el_Controlador.Error_Anterior);
	-- U total es la salida y suma de los demás U
	U := Salida (Up + Ui + Ud);
	-- S se actualiza
	con_el_Controlador.S_Anterior := S;
	-- El error tambien
	con_el_Controlador.Error_Anterior := E;
   end Controlar;

end PID;
