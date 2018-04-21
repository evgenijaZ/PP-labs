procedure Main is
   N : Integer := 6;
   P : Integer := 6;
   H : Integer := N / P;

   type GeneralVector is array (Integer range <>) of Integer;
   subtype Vector is GeneralVector (1 .. N);
   subtype VectorH is GeneralVector (1 .. H);
   subtype Vector2H is GeneralVector (1 .. 2 * H);
   subtype Vector4H is GeneralVector (1 .. 4 * H);
   subtype Vector5H is GeneralVector (1 .. 5 * H);

   type GeneralMatrix is array (Integer range <>, Integer range <>) of Integer;
   subtype Matrix is GeneralMatrix (1 .. N, 1 .. N);
   subtype MatrixH is GeneralMatrix (1 .. H, 1 .. H);
   subtype Matrix4H is GeneralMatrix (1 .. 4 * H, 1 .. 4 * H);
   subtype Matrix2H is GeneralMatrix (1 .. 2 * H, 1 .. 2 * H);
   subtype Matrix5H is GeneralMatrix (1 .. 5 * H, 1 .. 5 * H);

   task T1 is
      entry Data1 (MB : in MatrixH; MK : in Matrix);
      entry ShareM (m : in Integer);
   end T1;

   task T2 is
      entry Data1 (MB : in Matrix2H; MK : in Matrix);
      entry Data2 (Z : in Vector5H; MO : in Matrix5H);
      entry SendMin1 (m1 : in Integer);
      entry ShareM (m : in Integer);
      entry Rezult1 (MA : in VectorH);
   end T2;

   task T3 is
      entry Data1 (MB : in Matrix5H; MK : in Matrix);
      entry Data2 (Z : in Vector4H; MO : in Matrix4H);
      entry SendMin12 (m1, m2 : in Integer);
      entry SedMin5 (m5 : in Integer);
      entry SedMin6 (m6 : in Integer);
      entry ShareM (m : in Integer);
      entry Rezult2 (MA : in Vector2H);
      entry Rezult5 (MA : in Vector2H);
      entry Rezult6 (MA : in Vector2H);
   end T3;

   task T4 is
      entry SendMin12356 (m1, m2, m3, m5, m6 : in Integer);
      entry Data2 (Z : in VectorH; MO : in MatrixH);
      entry Rezult12356 (MA : in Matrix5H);
   end T4;

   task T5 is
      entry Data1 (MB : in MatrixH; MK : in Matrix);
      entry Data2 (Z : in VectorH; MO : in MatrixH);
      entry ShareM (m : in Integer);
   end T5;

   task T6 is
      entry Data1 (MB : in MatrixH; MK : in Matrix);
      entry Data2 (Z : in VectorH; MO : in MatrixH);
      entry ShareM (m : in Integer);
   end T6;

   task body T1 is
      Z      : Vector;
      MO, MK : Matrix;
      m1, m  : Integer;
      MA, MB : MatrixH;
   begin
      --Input Z, MO
      --Send Z, MO to T2
      --Receive MB, MK from T2
      --Calculate m1
      --Send m1 to T2
      --Receive m from T2
      --Calculate MAH = MBH + m*(MOH*MK)
      --Send MAH to T2
      null;
   end T1;

   task body T2 is
      Z         : Vector5H;
      MO, MK    : Matrix5H;
      MB, MA    : Matrix2H;
      m1, m2, m : Integer;
   begin
      --Receive Z, MO from T1;
      --Receive MB, MK from T3;
      --Calculate m2;
      --Receive m1 from T1;
      --Send m1, m2 to T3;
      --Receive m from T3
      --Send m to T1;
      --Calculate MAH = MBH + m*(MOH*MK)
      --Receive MA from T1;
      --Send MA2H to T3
      null;
   end T2;

   task body T3 is
      m1, m2, m3, m5, m6, m : Integer;
      MA                    : Matrix5H;
      Z                     : Vector4H;
      MO                    : Matrix4H;
      MK                    : Matrix;
      MB                    : Matrix5H;
   begin
      --Receive Z, MO from T2;
      --Receive MB, MK from T4;
      --Send Z,MO  to T2;
      --Send MB,MK to T2;
      --Send Z,MO  to T5;
      --Send MB,MK to T5;
      --Send Z,MO  to T6;
      --Send MB,MK to T6;
      --Calculate m3;
      --Receive m1,m2 from T2;
      --Receive m5 from T5;
      --Receive m6 from T6;
      --Send m1,m2,m3,m5,m6 to T4;
      --Receive m from T4;
      --Send m to T2;
      --Send m to T5;
      --Send m to T6;
      --Calculate MAH = MBH + m*(MOH*MK);
      --Receive MA from T2;
      --Receive MA from T5;
      --Receive MA from T6;
      --Send MA to T4;
      null;
   end T3;

   task body T4 is
      MA, MB, MK                : Matrix;
      Z                         : VectorH;
      MO                        : MatrixH;
      m1, m2, m3, m4, m5, m6, m : Integer;
   begin
      --Send MB, MK to T3;
      --Receive Z, MO from T3;
      --Calculate m4;
      --Receive m1,m2,m3,m5,m6 from T3;
      --Calculate m;
      --Send m to T3;
      --Calculate MAH = MBH + m*(MOH*MK);
      --Receive MA from T3;
      --Output MA;
      null;
   end T4;

   task body T5 is
      MK         : Matrix;
      MB, MO, MA : MatrixH;
      Z          : VectorH;
      m5, m      : Integer;
   begin
      --Receive MB, MK from T3;
      --Receive Z, MO from T3;
      --Calculate m5;
      --Send m5 to T3;
      --Receive m from T3;
      --Calculate MAH = MBH + m*(MOH*MK);
      --Send MA to T3;
      null;
   end T5;

   task body T6 is
      MK         : Matrix;
      MB, MO, MA : MatrixH;
      Z          : VectorH;
      m6, m      : Integer;
   begin
      --Receive MB, MK from T3;
      --Receive Z, MO from T3;
      --Calculate m6;
      --Send m6 to T3;
      --Receive m from T3;
      --Calculate MAH = MBH + m*(MOH*MK);
      --Send MA to T3;
      null;
   end T6;

begin
   null;
end Main;
