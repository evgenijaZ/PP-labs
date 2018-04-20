with Ada.Text_IO, Ada.Integer_Text_IO,
     Ada.Synchronous_Task_Control;
use Ada.Text_IO, Ada.Integer_Text_IO,
    Ada.Synchronous_Task_Control;

procedure Main is
   N : Integer := 2000;
   P : Integer := 4;
   H : Integer := N / P;

   type Vector is array (1 .. N) of Integer;
   type Matrix is array (1 .. N) of Vector;

   A, B, C, S, Z : Vector;
   MO : Matrix;

   protected Box is
      function Copy_e return Integer;
      function Copy_d return Integer;
      function Copy_MK return Matrix;


      procedure Input_d (x: in Integer);
      procedure Input_MK (x: in Integer);


      procedure Add_e (x : in Integer);


      entry Wait1;
      entry Wait2;
      entry Wait3;
      procedure Signal1;
      procedure Signal2;
      procedure Signal3;
   private

      e : Integer := 0;
      d : Integer := 0;

      MK : Matrix;

      F1 : Integer := 0;
      F2 : Integer := 0;
      F3 : Integer := 0;
   end Box;

   protected body Box is

      function Copy_e return Integer is
      begin
         return e;
      end Copy_e;

      function Copy_d return Integer is
      begin
         return d;
      end Copy_d;


      function Copy_MK return Matrix is
      begin
         return MK;
      end Copy_MK;


      procedure Input_MK (x: in Integer)is
      begin
         for i in 1 .. N loop
            for j in 1 .. N loop
               MK(i)(j):=x;
            end loop;
         end loop;
      end Input_MK;

      procedure Input_d (x : in Integer) is
      begin
         d := x;
      end Input_d;

      procedure Add_e (x : in Integer) is
      begin
         e := e + x;
      end Add_e;

      entry Wait1
        when F1 = 4 is
      begin
         null;
      end;

      entry Wait2
        when F2 = 4 is
      begin
         null;
      end;

      entry Wait3
        when F3 = 3 is
      begin
         null;
      end;

      procedure Signal1 is
      begin
         F1 := F1 + 1;
      end Signal1;

      procedure Signal2 is
      begin
         F2 := F2 + 1;
      end Signal2;

      procedure Signal3 is
      begin
         F3 := F3 + 1;
      end Signal3;

   end Box;

   procedure Start is

      task T1 is
         pragma Storage_Size (100000000);
      end T1;
      task body T1 is
         e1  : Integer;
         d1  : Integer;
         MK1 : Matrix;
         V : Vector;

         current : Integer;
      begin
         Put_Line ("T1 started");

         -- Input B,S
         for i in 1 .. N loop
            B (i) := 1;
            S (i) := 1;
         end loop;


         -- Signal B, S input
         Box.Signal1;
         -- Wait for other threads to finish input
         Box.Wait1;

         -- Calculate e = BH * CH
         e1 := 0;
         for i in 1 .. H loop
            e1 := e1 + (B (i) * C (i));
         end loop;
         Box.Add_e (e1);

         -- Signal calculating B*C finish
         Box.Signal2;
         -- Wait for other threads to fihish calculating B*C
         Box.Wait2;

         -- Copy data
         e1 := Box.Copy_e;
         d1:=Box.Copy_d;
         MK1:=Box.Copy_MK;


         -- Calculate MAH = e * ZH + d *  SH (MOH * MK).
         for i in 1 .. H loop
            for j in 1 .. N loop
               V(j):= 0;
               current := 0;
               for k in 1 .. N loop
                  current := current + MO (i)(k) * MK1 (k)(j);
               end loop;
               for l in 1 .. N loop
                  V(j):= V(j) +  current * S(l);
               end loop;
            end loop;
            A(i):=e1*Z(i)+d1*V(i);
         end loop;


         -- Wait for other threads to finish
         Box.Wait3;


         if N <= 12 then
            for i in 1 .. N loop
               Put (A (i));
               Put (" ");
            end loop;
            Put_Line ("");
         end if;


         Put_Line ("T1 finished");
      end T1;

      task T2 is
         pragma Storage_Size (100000000);
      end T2;
      task body T2 is

         e2  : Integer;
         d2  : Integer;
         MK2 : Matrix;
         V : Vector;
         current : Integer;
      begin Put_Line ("T2 started");


         -- Input C
         for i in 1 .. N loop
            C (i) := 1;
         end loop;
         Box.Input_MK(1);


         -- Signal C input
         Box.Signal1;
         -- Wait for other threads to finish input
         Box.Wait1;


         -- Calculate e = BH * CH
         e2 := 0;
         for i in  H+1..2*H loop
            e2 := e2 + (B (i) * C (i));
         end loop;
         Box.Add_e (e2);


         -- Signal calculating B*C finish
         Box.Signal2;
         -- Wait for other threads to fihish calculating B*C
         Box.Wait2;

         -- Copy data
         e2 := Box.Copy_e;
         d2:=Box.Copy_d;
         MK2:=Box.Copy_MK;

         -- Calculate MAH = e * ZH + d *  SH (MOH * MK).
         for i in H+1..2*H loop
            for j in 1 .. N loop
               V(j):= 0;
               current := 0;
               for k in 1 .. N loop
                  current := current + MO (i)(k) * MK2 (k)(j);
               end loop;
               for l in 1 .. N loop
                  V(j):= V(j) +  current * S(l);
               end loop;
            end loop;
            A(i):=e2*Z(i)+d2*V(i);
         end loop;

         Box.Signal3;
         Put_Line ("T2 finished");
      end T2;

      task T3 is
         pragma Storage_Size (100000000);
      end T3;
      task body T3 is

         e3  : Integer;
         d3  : Integer;
         MK3 : Matrix;
         V : Vector;

         current : Integer;
      begin
         Put_Line ("T3 started");

         -- Input Z, S
         for i in 1 .. N loop
            Z (i) := 1;
            S (i) :=1;
         end loop;

         -- Signal C, MT input
         Box.Signal1;
         -- Wait for other threads to finish input
         Box.Wait1;
         -- Calculate e = BH * CH
         e3 := 0;
         for i in 2*H+1 .. 3*H loop
            e3 := e3 + (B (i) * C (i));
         end loop;
         Box.Add_e (e3);

         -- Signal calculating B*C finish
         Box.Signal2;
         -- Wait for other threads to fihish calculating B*C
         Box.Wait2;

         -- Copy data
         e3 := Box.Copy_e;
         d3:=Box.Copy_d;
         MK3:=Box.Copy_MK;

         -- Calculate MAH = e * ZH + d *  SH (MOH * MK).
         for i in 2*H+1 .. 3*H loop
            for j in 1 .. N loop
               V(j):= 0;
               current := 0;
               for k in 1 .. N loop
                  current := current + MO (i)(k) * MK3 (k)(j);
               end loop;
               for l in 1 .. N loop
                  V(j):= V(j) +  current * S(l);
               end loop;
            end loop;
            A(i):=e3*Z(i)+d3*V(i);
         end loop;

         Box.Signal3;

         Put_Line ("T3 finished");
      end T3;

      task T4 is
         pragma Storage_Size (100000000);
      end T4;
      task body T4 is
         e4  : Integer;
         d4  : Integer;
         MK4 : Matrix;
         V : Vector;

         current : Integer;
      begin
         Put_Line ("T4 started");

         -- Input MO, d
         Box.Input_d(1);
         for i in 1..N loop
            for j in 1 .. N loop
               MO (i)(j) := 1;
            end loop;
         end loop;

         -- Signal MO, d input
         Box.Signal1;
         -- Wait for other threads to finish input
         Box.Wait1;

         -- Calculate e = BH * CH
         e4 := 0;
         for i in 3*H+1 .. N loop
            e4 := e4 + (B (i) * C (i));
         end loop;
         Box.Add_e (e4);

         -- Signal calculating B*C finish
         Box.Signal2;
         -- Wait for other threads to fihish calculating B*C
         Box.Wait2;

         -- Copy data
         e4 := Box.Copy_e;
         d4:=Box.Copy_d;
         MK4:=Box.Copy_MK;


         -- Calculate MAH = e * ZH + d *  SH (MOH * MK).
         for i in 3*H+1 .. N loop
            for j in 1 .. N loop
               V(j):= 0;
               current := 0;
               for k in 1 .. N loop
                  current := current + MO (i)(k) * MK4 (k)(j);
               end loop;
               for l in 1 .. N loop
                  V(j):= V(j) +  current * S(l);
               end loop;
            end loop;
            A(i):=e4*Z(i)+d4*V(i);
         end loop;

         Box.Signal3;

         Put_Line ("T4 finished");
      end T4;

   begin
      null;
   end Start;

begin
   Start;
end Main;

