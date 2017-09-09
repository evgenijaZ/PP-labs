with Ada.Text_IO; use Ada.Text_IO;
with Data; use Data;
procedure lab1 is
 
   task T1;
   task body T1 is
   begin
      Put_Line("Task 1:");
   end T1;
   
   task T2;
   task body T2 is
   begin
      Put_Line("Task 2:");
   end T2;
   
   task T3;
   task body T3 is
   begin
      Put_Line("Task 3:");
   end T3;
   
begin
   Put_Line("lab1");
end lab1;
