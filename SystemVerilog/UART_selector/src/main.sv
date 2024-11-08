module main(input logic clk,
            reset,
            select,
            Rx_ESP_Master,
            Rx_Esp_Sim,
            Rx_Pc_17,
            output logic Tx_Pc_18,
            Tx_Esp_Master,
            Tx_Esp_Sim,
            Led_Selector,
            Led_Reset);

    assign Led_Selector = select;
    assign Led_Reset = reset;

    uart_selector us(select, Rx_Pc_17, Rx_ESP_Master, Rx_Esp_Sim, Tx_Pc_18, Tx_Esp_Master, Tx_Esp_Sim);

endmodule

module triState(input logic a, select, output tri y);

    assign y = select ? a : 1'bz;

endmodule

module mux_triState(input logic Rx_ESP_Master,Rx_Esp_Sim, select, output tri Tx_Pc_18);

    triState tri_1(Rx_ESP_Master,select,Tx_Pc_18);
    triState tri_2(Rx_Esp_Sim,~select,Tx_Pc_18);

endmodule

module demux(input logic Rx_PC_17, select, output logic Rx_ESP_Master, Rx_Esp_Sim);

    assign Rx_ESP_Master = select ? Rx_PC_17 : 1;
    assign Rx_Esp_Sim = select ? Rx_PC_17 : 1;

endmodule

module uart_selector(input logic select, Rx_PC_17, Rx_ESP_Master, Rx_Esp_Sim, output logic Tx_Pc_18, Tx_Esp_Master, Tx_Esp_Sim);

    mux_triState mux(Rx_Esp_Sim, Rx_ESP_Master, select, Tx_Pc_18);
    demux dmx(Tx_Pc_18,select,Tx_Esp_Sim, Tx_Esp_Master);

endmodule
