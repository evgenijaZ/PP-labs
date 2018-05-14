with Ada.Text_IO, Ada.Integer_Text_IO,
     Ada.Synchronous_Task_Control;
use Ada.Text_IO, Ada.Integer_Text_IO,
    Ada.Synchronous_Task_Control;

procedure Main is
   N : Integer := 12;
   P : Integer := 4;
   H : Integer := N / P;

   type Vector is array (1 .. N) of Integer;
   type Matrix is array (1 .. N) of Vector;

   A  : Vector;
   MD,ME : Matrix;

   protected Box is
      function Copy_e return Integer;
      function Copy_B return Vector;
      function Copy_MC return Matrix;


      procedure Input_e (x: in Integer);
      procedure Input_B (x: in Integer);
      procedure Input_MC (x: in Integer);

      entry Wait1;
      entry Wait2;

      procedure Signal1;
      procedure Signal2;

   private

      e: Integer;
      B:Vector;
      MC : Matrix;

      F1 : Integer := 0;
      F2 : Integer := 0;

   end Box;

   protected body Box is


      function Copy_e return Integer is
      begin
         return e;
      end Copy_e;

      function Copy_B return Vector is
      begin
         return B;
      end Copy_B;

      function Copy_MC return Matrix is
      begin
         return MC;
      end Copy_MC;


      procedure Input_MC (x: in Integer)is
      begin
         for i in 1 .. N loop
            for j in 1 .. N loop
               MC(i)(j):=x;
            end loop;
         end loop;
      end Input_MC;


      procedure Input_B (x: in Integer)is
      begin
         for i in 1 .. N loop
            B(i):=x;
         end loop;
      end Input_B;

      procedure Input_e (x : in Integer) is
      begin
         e := x;
      end Input_e;


      entry Wait1
        when F1 = 3 is
      begin
         null;
      end;

      entry Wait2
        when F2 = 3 is
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

   end Box;

   procedure Start is

      task T1;

      task body T1 is
         e : Integer;
         MC : Matrix;
         B : Vector;
         MR:Matrix;
         from, to : Integer;
       begin
         Put_Line ("T1 started");

         from:=1;
         to:=H;

         -- Wait for other threads to finish input
         Box.Wait1;


          -- Copy data
         e:=Box.Copy_e;
         B:=Box.Copy_B;
         MC:=Box.Copy_MC;


         --Calculate A = B * (MC * MDH - MEH * e)
         for i in 1..N loop
            for j in from..to loop
               MR(i)(j):=0;
               for k in 1..N loop
                  MR(i)(j):=MR(i)(j)+MC(i)(k)*MD(k)(j);
               end loop;
                MR(i)(j):=MR(i)(j)-ME(i)(j)*e;
            end loop;
         end loop;

         for j in from..to loop
            A(j):=0;
            for k in 1..N loop
               A(j):=A(j)+B(k)*MR(k)(j);
            end loop;
         end loop;


         -- Signal for other threads to finish
         Box.Signal2;

         Put_Line ("T1 finished");
      end T1;

      task T2 is
         pragma Storage_Size (100000000);
      end T2;
      task body T2 is
         e : Integer;
         MC : Matrix;
         B : Vector;
         MR:Matrix;
         from, to : Integer;
       begin
         Put_Line ("T2 started");
         from:=H+1;
         to:=2*H;
         --Input B, MD
         Box.Input_B(1);
         for i in 1..N loop
            for j in 1..N loop
               MD(i)(j):=1;
            end loop;
         end loop;

         -- Input is finished
         Box.Signal1;

         -- Wait for other threads to finish input
         Box.Wait1;

         -- Copy data
         e:=Box.Copy_e;
         B:=Box.Copy_B;
         MC:=Box.Copy_MC;

         --Calculate A = B * (MC * MDH - MEH * e)
         for i in 1..N loop
            for j in from..to loop
               MR(i)(j):=0;
               for k in 1..N loop
                  MR(i)(j):=MR(i)(j)+MC(i)(k)*MD(k)(j);
               end loop;
                MR(i)(j):=MR(i)(j)-ME(i)(j)*e;
            end loop;
         end loop;

         for j in from..to loop
            A(j):=0;
            for k in 1..N loop
               A(j):=A(j)+B(k)*MR(k)(j);
            end loop;
         end loop;


         Box.Wait2;

         if N <= 12 then
            for i in 1 .. N loop
              Put (A (i));
               Put (" ");
            end loop;
            Put_Line ("");
         end if;

         Put_Line ("T2 finished");
      end T2;

      task T3 is
         pragma Storage_Size (100000000);
      end T3;
      task body T3 is
         e : Integer;
         MC : Matrix;
         B : Vector;
         MR:Matrix;
         from, to : Integer;
       begin
         Put_Line ("T3 started");
         from:=2*H+1;
         to:=3*H;

         --Input e, MC
         Box.Input_MC(1);
         Box.Input_e(1);

         -- Input is finished
         Box.Signal1;

         -- Wait for other threads to finish input
         Box.Wait1;

         -- Copy data
         e:=Box.Copy_e;
         B:=Box.Copy_B;
         MC:=Box.Copy_MC;

         --Calculate A = B * (MC * MDH - MEH * e)
         for i in 1..N loop
            for j in from..to loop
               MR(i)(j):=0;
               for k in 1..N loop
                  MR(i)(j):=MR(i)(j)+MC(i)(k)*MD(k)(j);
               end loop;
                MR(i)(j):=MR(i)(j)-ME(i)(j)*e;
            end loop;
         end loop;

         for j in from..to loop
            A(j):=0;
            for k in 1..N loop
               A(j):=A(j)+B(k)*MR(k)(j);
            end loop;
         end loop;


         Box.Signal2;

         Put_Line ("T3 finished");
      end T3;

      task T4 is
         pragma Storage_Size (100000000);
      end T4;
      task body T4 is
         e : Integer;
         MC : Matrix;
         B : Vector;
         MR:Matrix;
         from, to : Integer;
       begin
         Put_Line ("T4 started");
         from:=3*H+1;
         to:=N;
         --Input ME
         for i in 1..N loop
            for j in 1..N loop
               ME(i)(j):=1;
            end loop;
         end loop;

         -- Input is finished
         Box.Signal1;

         -- Wait for other threads to finish input
         Box.Wait1;

         -- Copy data
         e:=Box.Copy_e;
         B:=Box.Copy_B;
         MC:=Box.Copy_MC;

         --Calculate A = B * (MC * MDH - MEH * e)
         for i in 1..N loop
            for j in from..to loop
               MR(i)(j):=0;
               for k in 1..N loop
                  MR(i)(j):=MR(i)(j)+MC(i)(k)*MD(k)(j);
               end loop;
                MR(i)(j):=MR(i)(j)-ME(i)(j)*e;
            end loop;
         end loop;

         for j in from..to loop
            A(j):=0;
            for k in 1..N loop
               A(j):=A(j)+B(k)*MR(k)(j);
            end loop;
         end loop;

         Box.Signal2;

         Put_Line ("T4 finished");
      end T4;

   begin
      null;
   end Start;

begin
   Start;
end Main;

