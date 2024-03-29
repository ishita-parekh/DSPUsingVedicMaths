
module fredivider(clk,rst,clk_out);
input clk,rst;
output clk_out;
reg counter[15];

always @(posedege clk or negedge rst)
begin
if(!rst)
counter<=16'd0;
else
if(counter==16'd5000)
counter<=16'd0;
else
counter<=counter+1;
end

assign out_clk<=counter[15;

end module
