`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 17:40:08
// Design Name: 
// Module Name: HazardsUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HazardsUnit(
    input rst,
    input BranchD,
    input [4:0] RsD,
    input [4:0] RsE,
    input [4:0] RtD,
    input [4:0] RtE,
    input [4:0] WriteRegE,
    input [4:0] WriteRegM,
    input [4:0] WriteRegW,
    input RegWriteE,
    input RegWriteM,
    input RegWriteW,
    input MemtoRegE,
    input MemtoRegM,
    output reg StallF,
    output reg StallD,
    output reg ForwardAD,
    output reg ForwardBD,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output reg FlushE
    );
    initial begin
        StallF = 0;
        StallD = 0;
        FlushE = 0;
    end
    
    always@(*)begin
        if( (RsE != 0) && (RsE == WriteRegM) && RegWriteM ) begin
            ForwardAE = 2'b10;
        end
        else if( (RsE != 0) && (RsE == WriteRegW) && RegWriteW ) begin
            ForwardAE = 2'b01;
        end
        else 
            ForwardAE = 2'b00;
            
        //ForwardAE[1] <=  (RsE != 0) && (RsE == WriteRegM) && RegWriteM;
        //ForwardAE[0] <=  (RsE != 0) && (RsE == WriteRegW) && RegWriteW && ~((RsE == WriteRegM) && RegWriteM);
    end

    always@(*)begin
        if( (RtE != 0) && (RtE == WriteRegM) && RegWriteM ) begin
            ForwardBE = 2'b10;
        end
        else if( (RtE != 0) && (RtE == WriteRegW) && RegWriteW ) begin
            ForwardBE = 2'b01;
        end
        else 
            ForwardBE = 2'b00;
        //ForwardBE[1] <=  (RtE != 0) && (RtE == WriteRegM) && RegWriteM;
        //ForwardBE[0] <=  (RtE != 0) && (RtE == WriteRegW) && RegWriteW && ~((RtE == WriteRegM) && RegWriteM);
    end
    
    
    /*
    always @(*) begin
        ForwardAE = 2'b00;
        if (RsE != 0) begin
            // 优先级：EX > MEM > WB
            if (RsE == WriteRegE && RegWriteE)        ForwardAE = 2'b11; // 当前 EX 阶段结果
            else if (RsE == WriteRegM && RegWriteM)   ForwardAE = 2'b10; // MEM 阶段结果
            else if (RsE == WriteRegW && RegWriteW)   ForwardAE = 2'b01; // WB 阶段结果
        end
    end
    always @(*) begin
        ForwardBE = 2'b00;
        if (RtE != 0) begin
            // 优先级：EX > MEM > WB
            if (RtE == WriteRegE && RegWriteE)        ForwardBE = 2'b11; // 当前 EX 阶段结果
            else if (RtE == WriteRegM && RegWriteM)   ForwardBE = 2'b10; // MEM 阶段结果
            else if (RtE == WriteRegW && RegWriteW)   ForwardBE = 2'b01; // WB 阶段结果
        end
    end
    */
    
    
    
    reg lwstall, branchstall;
    always@(*)begin
        lwstall = ((RsD == RtE) || (RtD == RtE)) && MemtoRegE;
        branchstall = (BranchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD)) ||
                      (BranchD && MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD));                  
        if(lwstall || branchstall )begin
            StallF = 1; StallD = 1; FlushE = 1;
        end else begin
            StallF = 0; StallD = 0; FlushE = 0;
        end
        if(rst)begin
            StallF = 0;
            StallD = 0;
            FlushE = 0;
        end 
    end
    
    always@(*)begin
        ForwardAD = (RsD != 0) && (RsD == WriteRegM) && RegWriteM;
        ForwardBD = (RtD != 0) && (RtD == WriteRegM) && RegWriteM;
    end
endmodule
