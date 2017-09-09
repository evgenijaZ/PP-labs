with Ada.Text_IO;
use Ada.Text_IO;
procedure Lab1 is

   task T1;
   task body T1 is
   begin
      Put("T1");
   end T1;

    task T2;
   task body T2 is
   begin
      Put("T2");
   end T2;

begin
   Put_Line("Lab1");
   null;
end Lab1;
