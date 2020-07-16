with Ada.Real_Time, Sensor, Calefactor, PID;
use Ada.Real_Time, Sensor, Calefactor;
with Ada.Text_IO; use Ada.Text_IO;

procedure principal is
   package Temp_Es is new Ada.Text_IO.Float_IO(Temperaturas);
   package Control_Horno is new PID(Real => Float, Entrada => Temperaturas, Salida => Potencias);
   use Control_Horno;

   PID_Horno: Controlador;
   Ts: constant := 1.0; 	--Periodo
   Temp: Temperaturas; 		--Temperatura a medir
   Temp_ref: Temperaturas; 	--Temperatura ambiente
   P: Potencias; 		--Potencia
   Ct: constant  := 1_000.0; 	--Capacidad termica
   Cp: constant  := 25.0; 	--Coeficiente de perdidas
   L: constant := 1.2; 		--Retardo
   Kp, Ki, Kd: Float;

begin
   -- Fragmento dedicado al calculo de coeficientes y toma de temperatura de referencia
   declare
      R: Float;
   begin
      Put("Escribe la temperatura de referencia: ");
      Temp_Es.Get(Temp_ref);

      -- Coeficientes
      R := Float(Temp_ref-20.0)/(Ct/Cp);
      Kp := 1.2/(R*L);
      ki := kp/((2.0*L)*Ts);
      Kd := Kp*(0.5*L)/Ts;
   end;

   -- Programa el configurador del horno
   Programar(PID_Horno, Kp, Ki, Kd);

   -- Parte dedicada al bucle de control
   declare
      Periodo: constant Time_Span := To_Time_Span(Ts);
      Siguiente_Instante: Time := Clock;

   begin
      loop
	 -- Espera al siguiente momento de muestreo
         delay until Siguiente_Instante;
	 -- Leemos la temperatura
         Sensor.Leer(Temp);
	 -- Controlamos la de referencia con la real
         Controlar(PID_Horno,Temp_ref, Temp, P);
	 -- Escribimos la potencia para que el Horno caliente
         Escribir(P);
	 -- Fijamos el siguiente momento de muestreo
         Siguiente_Instante := Siguiente_Instante + Periodo;
         Temp_Es.Put(Temp,0,3,0);
         Put_Line("");
      end loop;
   end;
end principal;
