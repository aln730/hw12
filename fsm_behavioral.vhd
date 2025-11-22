library ieee;
use ieee.std_logic_1164.all;

entity fsm_behavioral is
    port (
        clk     : in  std_logic;
        reset_n : in  std_logic;     
        X       : in  std_logic;
        Z       : out std_logic
    );
end entity;

architecture behavioral of fsm_behavioral is

    type state_type is (A, B, C, D);
    signal state, next_state : state_type;

begin

    process(clk, reset_n)
    begin
        if reset_n = '0' then
            state <= A;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    process(state, X)
    begin
        Z <= '0';          -- default
        next_state <= state;

        case state is

            when A =>
                -- Z from sequence: 0 whenever in state A
                if X = '1' then 
                    next_state <= B;
                else
                    next_state <= A;
                end if;

            when B =>
                -- Only state with Z = 1 in your sequence
                Z <= '1';
                if X = '1' then
                    next_state <= C;
                else
                    next_state <= A;
                end if;

            when C =>
                -- Z = 0 in your sequence
                if X = '0' then
                    next_state <= D;
                else
                    next_state <= C;
                end if;

            when D =>
                -- Z = 0 in your sequence
                if X = '1' then
                    next_state <= A;
                else
                    next_state <= C;
                end if;

        end case;
    end process;

end architecture;
