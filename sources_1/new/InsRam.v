`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 13:34:04
// Design Name: 
// Module Name: InsRam
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


module InsRam(
    input [31:0] A,
    output [31:0] RD
    );
    
    reg [31:0] ram_cell [4095:0];
    wire add_valid = (A[31:14] == 18'h0) ? 1 : 0;
    wire [11:0] addr = A[13:2];
    initial begin
        //测试RAW相关
        /*
        ram_cell[0] = 32'h20010003; //addi $1,$0,3
        ram_cell[1] = 32'h20020002; //addi $2,$0,2
        ram_cell[2] = 32'h00221820; //add $3,$1,$2
        ram_cell[3] = 32'h00432020; //add $4,$2,$3
        ram_cell[4] = 32'h00642820; //add $5,$3,$4
        ram_cell[5] = 32'h20a60001; //addi $6,$5,1
        ram_cell[6] = 32'h00c63820; //add $7,$6,$6
        */
        
  
        
        //测试RAW相关及load互锁
        /*
        ram_cell[0] = 32'h20010000; //addi $1,$0,0
        ram_cell[1] = 32'h20020001; //addi $2,$0,1
        ram_cell[2] = 32'h00221820; //add $3,$1,$2
        ram_cell[3] = 32'h00432020; //add $4,$2,$3
        ram_cell[4] = 32'h8c450000; //lw $5,0($2)
        ram_cell[5] = 32'h00a43020; //add $6,$5,$4
        ram_cell[6] = 32'h00c43820; //add $7,$6,$4
        ram_cell[7] = 32'h00e54020; //add $8,$7,$5
        */
        
       
        //算术运算指令测试   
        /*
        ram_cell[0] = 32'h20010005; //addi $1,$0,5
        ram_cell[1] = 32'h20020003; //addi $2,$0,3
        ram_cell[2] = 32'h00221820; //add $3,$1,$2
        ram_cell[3] = 32'h00612022; //sub $4,$3,$1
        ram_cell[4] = 32'h00622824; //and $5,$3,$2
        ram_cell[5] = 32'h00853025; //or $6,$4,$5
        ram_cell[6] = 32'h00a43826; //xor $7,$5,$4
        ram_cell[7] = 32'h00434027; //nor $8,$2,$3
        ram_cell[8] = 32'h0087482a; //slt $9,$4,$7
        ram_cell[9] = 32'h01025004; //sllv $10,$8,$2
        ram_cell[10] = 32'h01425806; //srlv $11,$10,$2
        ram_cell[11] = 32'h01426007; //srav $12,$10,$2
        ram_cell[12] = 32'h30cd000a; //andi $13,$6,10
        ram_cell[13] = 32'h346e0009; //ori $14,$3,9
        ram_cell[14] = 32'h39cf0007; //xori $15,$14,7
        */
        
       
        //测试beq,j
        /*
        ram_cell[0] = 32'h2001ffff; //addi $1,$0,-1
        ram_cell[1] = 32'h20020000; //addi $2,$0,0
        ram_cell[2] = 32'h2003000a; //addi $3,$0,10
        ram_cell[3] = 32'h20040006; //addi $4,$0,6
        ram_cell[4] = 32'h10640003; //beq $4,$3,3
        ram_cell[5] = 32'h20420001; //addi $2,$2,1
        ram_cell[6] = 32'h00611820; //add $3,$3,$1
        ram_cell[7] = 32'h08000004; //j 4
        ram_cell[8] = 32'h00402820; //add $5,$2,$0
        ram_cell[9] = 32'h1000ffff; //beq $0,$0,-1
        */
        
        /*
        斐波那契数列：从存储器0号和1号单元读取初值(前两项)，
        此后每一项的计算结果依次存放到从存储器3号单元开始的位置
        如3号单元存放第三项，4号单元存放第四项......*/
        /*
        ram_cell[0] = 32'h20010000; //addi $1, $0, 0
        ram_cell[1] = 32'h20020004; //addi $2, $0, 4
        ram_cell[2] = 32'h8c230000; //lw $3, 0($1)
        ram_cell[3] = 32'h8c440000; //lw $4, 0($2)
        ram_cell[4] = 32'h20050006; //addi $5, $0, 6
        ram_cell[5] = 32'h20060000; //addi $6, $0, 0
        ram_cell[6] = 32'h00640820; //add $1, $3, $4
        ram_cell[7] = 32'h20420004; //addi $2, $2, 4
        ram_cell[8] = 32'hac410000; //sw $1, 0($2)
        ram_cell[9] = 32'h00801820; //add $3, $4, $0
        ram_cell[10] = 32'h00202020; //add $4, $1, $0
        ram_cell[11] = 32'h20c60001; //addi $6, $6, 1
        ram_cell[12] = 32'h10c50001; //beq $5, $6, 1
        ram_cell[13] = 32'h1000fff8; //beq $0, $0, -8
        ram_cell[14] = 32'h1000ffff; //beq $0, $0, -1
        */
        
    end
    assign RD = add_valid ? ram_cell[addr] : 0;  
endmodule
