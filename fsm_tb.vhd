library ieee;
use ieee.std_logic_1164.all;

entity fsm_tb is
end entity;

architecture tb of fsm_tb is

    signal clk     : std_logic := '0';
    signal reset_n : std_logic := '1';
    signal X       : std_logic := '0';
    signal Z       : std_logic;

constant X_seq : std_logic_vector(0 to 18) :=
    ('0','1','0','0','0','1','0','0','1','1',
     '0','1','0','1','1','0','0','0','1');
begin

    dut: entity work.fsm_behavioral
        port map (
            clk     => clk,
            reset_n => reset_n,
            X       => X,
            Z       => Z
        );

    clk <= NOT clk after 5 ns;

    -- Stimulus
    process
    begin
        -- Apply asynchronous reset
        reset_n <= '0';
        wait for 20 ns;
        reset_n <= '1';
        wait for 10 ns;

        -- Apply X sequence
        for i in X_seq'range loop
            X <= X_seq(i);
            wait for 10 ns;
        end loop;

        wait;
    end process;

end architecture;
