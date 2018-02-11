---------------------------------------
-- Zubrych E.S.
-- Labwork 1
-- MA = MB * MC + a * ( MK + MT)
---------------------------------------
procedure Lab1 is

   N:Integer:=100;
   P:Integer:=2;
   H:Integer:=N/P;

   procedure Tasks is
      task T1 is
         pragma Storage_Size (3_000_000);
      end T1;
      task body T1 is
      begin
         Put_Line("T1 started");

         Put_Line("T1 finished");
      end T1;

      task T2 is
         pragma Storage_Size (3_000_000);
      end T2;

      task body T2 is
      begin
         Put_Line("T2 started");

         Put_Line("T2 finished");
      end T2;
   begin
      null;
   end Tasks;
begin
   Put_Line("Program started");
   Tasks;
end Lab1;
