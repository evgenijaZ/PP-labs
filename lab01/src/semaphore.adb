package body semaphore is

protected body Counting_Semaphore is

    entry Secure when Current_Count > 0 is
    begin
        Current_Count := Current_Count - 1;
    end;

    procedure Release is
    begin
        Current_Count := Current_Count + 1;
    end;

    function Count return Integer is
    begin
        return Current_Count;
    end;

end Counting_Semaphore;

end semaphore;
